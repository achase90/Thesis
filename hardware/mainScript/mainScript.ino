//TODO: add checking if data is actually available for all sensors, especially serial sensors

#include <Wire.h>
#include <ITG3200.h>
#include <SPI.h>
#include <SD.h>
#include <ADXL362.h>
#include <OneWire.h>
#include <DallasTemperature.h>

#define profiling 0
#define magInstalled 1
#define gpsInstalled 1
#define pressureInstalled 1
#define ONE_WIRE_BUS 49
#define tempInstalled 0
#define TEMPERATURE_PRECISION 9

#define serialBaud 19200
#define magBaud 19200
#define gpsBaud 57600
#define pressBaud 9600
#define sdChipSelect 52
#define pwmPin0 38
#define pwmPin1 39
#define pwmPin2 40
#define pwmPin3 41
#define pwmPin4 42
#define pwmPin5 43
#define pwmPin6 44
#define pwmPin7 45

volatile unsigned long trig0,trig1,trig2,trig3,trig4,trig5,trig6,trig7=0;
volatile unsigned long pwm0,pwm1,pwm2,pwm3,pwm4,pwm5,pwm6,pwm7 = 0;

boolean printSerialOut = false;
boolean sdCardClosed = true;

char filename[80]={0};
File dataFile;
boolean logData=false;

char pressSN0[13] = "R11L07-20-A4";
char pressSN1[13] = "R10F30-04-A1";
char pressSN2[13] = "R11L07-20-A5";
char pressSN3[13] = "4F15-01-A213";

byte writeBuff[1028];
uint16_t writeBuffLoc=0;
const uint8_t nBytesPerSample = 31; //todo:check if this is correct

// set up communication with sensors
USARTClass &magSerial = Serial1;
USARTClass &gpsSerial = Serial2;
USARTClass &pressureSerial = Serial3;

//Constructors
ITG3200 gyro = ITG3200(); //construct gyro object
ADXL362 accel; //construct accel object

OneWire oneWire(ONE_WIRE_BUS);

// Pass oneWire reference to Dallas Temperature. 
DallasTemperature sensors(&oneWire);

DeviceAddress tempDeviceAddress; // temperature sensor device address

void setup() {
	char msgID[6]="?????";
	char *gpsStatus,*nsInd,*ewInd,*mode={"?"};
	int32_t gpsLat,gpsLong,gpsSpd,gpsCrs=0;
	uint32_t utcTime,date,CS=0;
	unsigned long time=millis();

	Serial.begin(serialBaud); //begin serial communication for debugging
	Serial.println("Serial port initialized.");

	Serial.print("Data logging : ");
	if (logData)
		{
		Serial.println("on.");
		}
	else {
		Serial.println("off.");
		}
#if (magInstalled)
	Serial.println("Initializing magnetometer...");
	serialDeviceInit(Serial, magSerial, magBaud,"mag"); //initialize magnetometer on Serial1
#endif

#if(gpsInstalled)
	Serial.println("Initializing GPS...");
	serialDeviceInit(Serial, gpsSerial, gpsBaud,"gps"); //initialize gps on Serial2
	gpsSerial.setTimeout(50);
#endif

#if (pressureInstalled)
	Serial.println("Initializing pressure sensors...");
	serialDeviceInit(Serial, pressureSerial, pressBaud,"pre"); //initialize pressure sensors on Serial3
	pressureSerial.setTimeout(50);
#endif

#if (gpsInstalled)
	while (!gpsSerial.available()>0)
		{
		if (millis()>time+5000)
			{
			break;
			} 
		}
	readGPS(gpsSerial,msgID,utcTime,&gpsStatus, gpsLat,&nsInd,gpsLong,&ewInd,gpsSpd,gpsCrs,date,&mode,CS);
	Serial.println(filename);
	char str[20];
	sprintf(str,"%d",utcTime);
	strcpy(filename,str);
	strcat(filename,".bin");
	Serial.println(filename);
#else
	Serial.print("No GPS installed. Filename : ");
	char str[20];
	sprintf(str,"%d",rand()%10000000);
	strcpy(filename,str);
	strcat(filename,".bin");
	Serial.println(filename);
#endif

	//set up gyro
	Wire.begin(); //begin wire transmission
	delay(1000); //todo:check if this is necessary
	gyro.init(ITG3200_ADDR_AD0_HIGH); //initialize gyro with address pulled high

	//set up accelerometer
	accel.begin();
	accel.beginMeasure();

#if (tempInstalled)
	//set up temp sensor
	sensors.begin();
	// Serial.println("Temperature sensor set up : ");

	if(sensors.getAddress(tempDeviceAddress, 0))
		{
		sensors.setResolution(tempDeviceAddress, TEMPERATURE_PRECISION);
		}
	else Serial.println("No temperature sensors found.");

#else
	Serial.println("Temperature sensor not installed.");
#endif

	pinMode(pwmPin0, INPUT);
	pinMode(pwmPin1, INPUT);
	pinMode(pwmPin2, INPUT);
	pinMode(pwmPin3, INPUT);
	pinMode(pwmPin4, INPUT);
	pinMode(pwmPin5, INPUT);
	pinMode(pwmPin6, INPUT);
	pinMode(pwmPin7, INPUT);

	attachInterrupt(pwmPin0,intHandler0,CHANGE);
	attachInterrupt(pwmPin1,intHandler1,CHANGE);
	attachInterrupt(pwmPin2,intHandler2,CHANGE);
	attachInterrupt(pwmPin3,intHandler3,CHANGE);
	attachInterrupt(pwmPin4,intHandler4,CHANGE);
	attachInterrupt(pwmPin5,intHandler5,CHANGE);
	attachInterrupt(pwmPin6,intHandler6,CHANGE);
	attachInterrupt(pwmPin7,intHandler7,CHANGE);

#if (gpsInstalled)
	//flush any data that has accumulated between turning on the device and starting the main loop.
		{
		while(gpsSerial.available()>0)
			{
			gpsSerial.read();
			}
		}
#endif
	}


void loop() {
	byte buff4[4];
	byte buff2[2];
	int16_t pressure[4]; //pressure sensor data
	int16_t temperature=0;
	int16_t magReading[3]; //magnetometer data
	int16_t gyroX, gyroY, gyroZ;
	int16_t accelX, accelY, accelZ, accelT;
	char msgID[6]="?????";
	char *gpsStatus={"?"},*nsInd={"?"},*ewInd={"?"},*mode={"?"};
	int32_t gpsLat,gpsLong,gpsSpd,gpsCrs=0;
	uint32_t utcTime,date,CS=0;

	if (Serial.available()>0) //check if there's serial data available
		{
		parseInput();
		}

	//start timer for tDiff data
	unsigned long time = millis();
	//read accel data
	readAccelData(accelX,accelY,accelZ);
	//read gyro data
	readGyroData(gyroX,gyroY,gyroZ);
	//read magnetometer data
#if (magInstalled)
	readMagnetometer(magSerial,magReading);
#endif

	//read pressure transducers
#if (pressureInstalled)
	readAllPress (pressureSerial,pressSN0,pressSN1,pressSN2,pressSN3,pressure);
#endif

	//read GPS
#if (gpsInstalled)
	if (gpsSerial.available()>0)
		{
		readGPS(gpsSerial,msgID,utcTime,&gpsStatus, gpsLat,&nsInd,gpsLong,&ewInd,gpsSpd,gpsCrs,date,&mode,CS);
		}
#endif

#if (tempInstalled)
	sensors.requestTemperatures(); // Send the command to get temperatures
	temperature = int16_t (100*sensors.getTempF(tempDeviceAddress));
#endif

	//format packet to be sent to SD card

	unsigned long tDiff = millis()-time; //end tDiff timer

	//write to SD card
	if (logData) //if we're storing data
		{
		unsigned long profile = micros();
		if (writeBuffLoc + nBytesPerSample > sizeof(writeBuff)) //if there's not enough room in the buffer, right it to the card first
			{
			File dataFile = SD.open(filename,FILE_WRITE);
			int bytesWritten = dataFile.write(writeBuff,writeBuffLoc);
			Serial.println();
			if (bytesWritten>0)
			Serial.println("Data buffer written to SD card.");
			else
				Serial.println("Error : Data buffer NOT written to SD card.");
			Serial.println();
			dataFile.close();
			writeBuffLoc = 0;
			}
		parseToBinUInt32(writeBuff,time,writeBuffLoc); //split data into bytes for binary storage
		parseToBinInt16(writeBuff,accelX,writeBuffLoc);
		parseToBinInt16(writeBuff,accelY,writeBuffLoc);
		parseToBinInt16(writeBuff,accelZ,writeBuffLoc);
		parseToBinInt16(writeBuff,gyroX,writeBuffLoc);
		parseToBinInt16(writeBuff,gyroY,writeBuffLoc);
		parseToBinInt16(writeBuff,gyroZ,writeBuffLoc);
		parseToBinInt16(writeBuff,magReading[0],writeBuffLoc);
		parseToBinInt16(writeBuff,magReading[1],writeBuffLoc);
		parseToBinInt16(writeBuff,magReading[2],writeBuffLoc);
		parseToBinInt16(writeBuff,pressure[0],writeBuffLoc);
		parseToBinInt16(writeBuff,pressure[1],writeBuffLoc);
		parseToBinInt16(writeBuff,pressure[2],writeBuffLoc);
		parseToBinInt16(writeBuff,pressure[3],writeBuffLoc);
		for (int i=0;i<5;i++)
			{
			writeBuff[writeBuffLoc++] = byte (msgID[i]);
			}
		parseToBinUInt32(writeBuff,utcTime,writeBuffLoc);
		writeBuff[writeBuffLoc++] = (byte) gpsStatus[0];
		parseToBinInt32(writeBuff,gpsLat,writeBuffLoc);
		writeBuff[writeBuffLoc++] = (byte) *nsInd;
		parseToBinInt32(writeBuff,gpsLong,writeBuffLoc);
		writeBuff[writeBuffLoc++] = (byte) *ewInd;
		parseToBinInt32(writeBuff,gpsSpd,writeBuffLoc);
		parseToBinInt32(writeBuff,gpsCrs,writeBuffLoc);
		parseToBinUInt32(writeBuff,date,writeBuffLoc);
		writeBuff[writeBuffLoc++] = (byte) *mode;
		parseToBinUInt32(writeBuff,CS,writeBuffLoc);
		parseToBinInt16(writeBuff,temperature,writeBuffLoc);
		parseToBinUInt32(writeBuff,tDiff,writeBuffLoc);
		parseToBinUInt32(writeBuff,pwm7,writeBuffLoc);
#if (profiling)
		Serial.print("parsing into binary : ");
		Serial.print(micros()-profile);
		Serial.println(" usec");
		profile = micros();
#endif
		}

	else if(writeBuffLoc != 0) //we're not logging data, but theres data in the buffer. write it out to SD
		{
		unsigned long profile = micros();
		dataFile = SD.open(filename,FILE_WRITE);
#if (profiling)
		Serial.print("opening SD : ");
		Serial.print(micros()-profile);
		Serial.println(" usec");
		profile = micros();
#endif
		int bytesWritten = dataFile.write(writeBuff,writeBuffLoc);
#if (profiling)
		Serial.print("writing to SD : ");
		Serial.print(micros()-profile);
		Serial.println(" usec");
		profile = micros();
#endif
		Serial.println();
		if (bytesWritten>0)
			{
			Serial.println("Data buffer written to SD card.");
			}
		else
			{
			Serial.println("ERROR : Data buffer NOT written to SD card.");
			}
		Serial.println();
		dataFile.close();
		writeBuffLoc = 0;
		}
	if (printSerialOut) //if the user wants to see the data (should be off by default for increased speed)
		{
		Serial.print(time);
		Serial.print('\t');
		Serial.print(accelX);
		Serial.print('\t');
		Serial.print(accelY);
		Serial.print('\t');
		Serial.print(accelZ);
		Serial.print('\t');
		Serial.print(gyroX);
		Serial.print('\t');
		Serial.print(gyroY);
		Serial.print('\t');
		Serial.print(gyroZ);
		Serial.print('\t');
		Serial.print(magReading[0]);
		Serial.print('\t');
		Serial.print(magReading[1]);
		Serial.print('\t');
		Serial.print(magReading[2]);
		Serial.print('\t');
		Serial.print(pressure[0]);
		Serial.print('\t');
		Serial.print(pressure[1]);
		Serial.print('\t');
		Serial.print(pressure[2]);
		Serial.print('\t');
		Serial.print(pressure[3]);
		Serial.print('\t');
		Serial.print(msgID);
		Serial.print('\t');
		Serial.print(utcTime);
		Serial.print('\t');
		Serial.print(gpsStatus);
		Serial.print('\t');
		Serial.print(gpsLat);
		Serial.print('\t');
		Serial.print(nsInd);
		Serial.print('\t');
		Serial.print(gpsLong);
		Serial.print('\t');
		Serial.print(ewInd);
		Serial.print('\t');
		Serial.print(gpsSpd);
		Serial.print('\t');
		Serial.print(gpsCrs);
		Serial.print('\t');
		Serial.print(date);
		Serial.print('\t');
		Serial.print(mode);
		Serial.print('\t');
		Serial.print(CS);
		Serial.print('\t');
		Serial.print(temperature);
		Serial.print('\t');
		Serial.print(tDiff);
		Serial.print('\t');
		Serial.println(pwm7);
		}
	}

void readMagnetometer(USARTClass &magSerial,int16_t *magReading)
	{
	unsigned long profile = micros();
	magSerial.print("*99P\r");
	if (magSerial.available()>0)
		{
		byte buff[6];
		for (int i=0;i<7;i++)
			{
			buff[i]=magSerial.read(); 
			}
		magReading[0] = buff[1]  + (buff[0] << 8);
		magReading[1] = buff[3] + (buff[2] << 8);
		magReading[2] = buff[5] + (buff[4]  << 8);
		}
	#if (profiling)
		Serial.print("magnetometer : ");
	Serial.print(micros()-profile);
	Serial.println(" usec");
#endif
	}

void readGyroData(int16_t &gyroX,int16_t &gyroY,int16_t &gyroZ)
	{
	unsigned long profile = micros();
	if (gyro.isRawDataReady())
		{
		gyro.readGyroRaw(&gyroX,&gyroY,&gyroZ);
		} 
	else{
		gyroX = NAN;
		gyroY = NAN;
		gyroZ = NAN;
		}
#if (profiling)
		Serial.print("gyro : ");
	Serial.print(micros()-profile);
	Serial.println(" usec");
#endif
	}
void readAccelData(int16_t &accelX,int16_t &accelY,int16_t &accelZ)
	{
	unsigned long profile = micros();
	int16_t accelT = 0;
	accel.readXYZTData(accelX,accelY,accelZ,accelT);
#if (profiling)
		Serial.print("accel : ");
	Serial.print(micros()-profile);
	Serial.println(" usec");
#endif
	}
void readAllPress (USARTClass &pressureSerial,char add0[], char add1[], char add2[], char add3[], int16_t *pressure)
	{
	pressureSerial.print("WC\r");
#if (profiling)
	unsigned long profile = micros();
	Serial.print("writing to pressure : ");
	Serial.print(micros()-profile);
	Serial.println(" usec");
	profile = micros();
#endif
	pressure[0] = readUniquePress(pressureSerial,add0);
#if (profiling)
	Serial.print("press0 : ");
	Serial.print(micros()-profile);
	Serial.println(" usec");
	profile = micros();
#endif
	pressure[1] = readUniquePress(pressureSerial,add1);
#if (profiling)
	Serial.print("press1 : ");
	Serial.print(micros()-profile);
	Serial.println(" usec");
	profile = micros();
#endif
	pressure[2] = readUniquePress(pressureSerial,add2);
#if (profiling)
	Serial.print("press2 : ");
	Serial.print(micros()-profile);
	Serial.println(" usec");
	profile = micros();
#endif
	pressure[3] = readUniquePress(pressureSerial,add3);
#if (profiling)
	Serial.print("press3 : ");
	Serial.print(micros()-profile);
	Serial.println(" usec");
	profile = micros();
#endif
	}

int16_t readUniquePress(USARTClass &pressureSerial,char address[])
	{
	char bytesIn[80]={0x00};
	char readComm[80]={0x00};

	int nchars;
	strcat(readComm,"U");
	strcat(readComm,address);
	strcat(readComm,"RC\r");
	pressureSerial.print(readComm); //issue "read captured pressure" command to device 1
	nchars = pressureSerial.readBytesUntil('=',bytesIn,80);
	nchars = pressureSerial.readBytesUntil(0x20,bytesIn,20);
	int16_t pressure = int16_t (strtol(bytesIn,NULL,16));
	return pressure;
	}

void readGPS(USARTClass &gpsSerial,char *msgID,uint32_t &utcTime,char **gpsStatus, int32_t &gpsLat,char **nsInd,int32_t &gpsLong,char **ewInd,int32_t &gpsSpd,int32_t &gpsCrs,uint32_t &date,char **mode,uint32_t &CS)
	{
	unsigned long profile = micros();

	char bytesIn[200] = {0};
	int csCalc;
	int csSentHex;


	if (Serial2.available()>0)
		{
		//Serial.println("Was available");
		unsigned long now = millis();
		unsigned long timeOut = 500;
		int i=0;
		while(true) //read bytes until we get to a start byte or timeout
			{
			//Serial.println("in loop #1");
			if (gpsSerial.available()>0)
				{
				//bytesIn[i] = gpsSerial.read();
				if (gpsSerial.read() == '$')
					{
					//Serial.println("found '$'");
					break;
					}
				if (millis()-now>timeOut)
					{
					//Serial.println("timed out #1");
					break;
					}
				}
			}
		now = millis();
		while(true) //read data until a stop byte or until timeout
			{
			//Serial.println("in loop #2");
			if (gpsSerial.available()>0)
				{
				bytesIn[i] = gpsSerial.read();
				if (bytesIn[i++] == '\n')
					{
					//Serial.println("found '\n'");
					break;
					}
				if (millis()-now>timeOut)
					{
					//Serial.println("timed out #2");
					break;
					}
				}
			}
		//if we've read a start
		//byte through an end byte, or timed out twice, just
		//flush everything on there and try again next time
		now = millis();
		while(gpsSerial.available()>0)
			{
			//Serial.println("in loop #3");
			gpsSerial.read();
			}

		csCalc =  getCheckSum(bytesIn);
		int j=i-4;
		char csSent[3] = {0};
		//Serial.println("Next char is bytesIn[j]");
		for (int k=0;k<2;k++)
			{
			//Serial.println(bytesIn[j]);
			csSent[k] = bytesIn[j++];
			}
		//Serial.println("next char is csSent");
		//Serial.println(csSent);
		csSentHex = strtol(csSent,NULL,HEX);
		}
	if (csSentHex == csCalc)
		{
		//process gps string
		char *s1=bytesIn; //copy to a new variable so we don't mess the data up;
		char *pt; //create container to store separated variable into
		pt = strsep(&s1,",*"); //pull of first delimted strings, based on either a , or a *

		for (int j=0;j<5;j++) //we know it's the msg field, so parse it into characters so we can write binary
			{
			msgID[j] = (char )pt[j];
			}

		int i=0; //variable for which section of delimited code we're in
		while (pt = strsep( &s1,",*")) //loop over string, delimiting it as we go
			{
			//Serial.println(pt);
			switch (i++)
				{
				case 0:
					{
					utcTime = 100*atof(pt);
					break;
					}
				case 1:
					{
					*gpsStatus = pt;
					break;
					}
				case 2:
					{                    
					gpsLat = 100000*atof(pt);
					break;
					}
				case 3:
					{                    
					*nsInd = pt;
					break;
					}
				case 4:
					{                    
					gpsLong = 100000*atof(pt);
					break;
					}
				case 5:
					{                    
					* ewInd = pt;
					break;
					}
				case 6:
					{                    
					gpsSpd = 1000*atof(pt);
					break;
					}
				case 7:
					{                    
					gpsCrs = 1000*atof(pt);
					break;
					}
				case 8:
					{      
					date = atoi(pt);
					break;
					}
				case 9:
					{                    
					//magnetic variation, not available
					break;
					}
				case 10:
					{                    
					//magnetic variation indicator, not available
					break;
					}
				case 11:
					{
					*mode = pt;
					break;
					}
				case 12:
					{
					CS = atoi(pt);
					break;
					}
				}
			}
		}
	// if the check sum wasn't correct, empty all data
	else
		{
		//Serial.println("bad CS, flushing gps buffer");
		//Serial.print("Calc-ed CS : ");
		//Serial.println(csCalc);
		//Serial.print("Calc-ed received CS : ");
		//Serial.println(csSentHex);
		//Serial.write(bytesIn);
		//Serial.println();
		while (gpsSerial.available()>0)
			gpsSerial.read();
		}
#if (profiling)
	Serial.print("writing to pressure : ");
	Serial.print(micros()-profile);
	Serial.println(" usec");
	profile = micros();	
#endif
}

void serialDeviceInit(UARTClass& mainSerial, USARTClass& deviceSerial, int deviceBaud,char ID[])
	{
	deviceSerial.begin(deviceBaud); //begin magnetometer serial communication
	if (ID == "mag")
		{
		deviceSerial.print("*99ID\r"); //send ID command to check if serial port is open
		}
	else if (ID == "gps")
		{
		}
	else if (ID == "pre")
		{
		deviceSerial.print("RS\r"); //send "Read Serial Number" command and wait for a response
		}

	else
		{
		mainSerial.println("Incorrect device ID for serial port initialization."); 
		}

	int start = millis();
	int time = start;
	boolean deviceSerialOpen = true; //assume it will open
	while (!deviceSerial.available())
		{
		time = millis(); //wait for device to respond

		if (time > start + 10000)
			{
			deviceSerialOpen = false; // if it doesn't open, set to false
			break; 
			}
		}
	if (deviceSerialOpen)
		{
		delay(20); //wait for all serial communication to come across before flushing
		while (deviceSerial.available()>0)
			{
			deviceSerial.read(); 
			}
		mainSerial.print(ID);
		mainSerial.println(" serial port initiliazed.");
		}
	else{
		mainSerial.print("ERROR : ");
		mainSerial.print(ID);
		mainSerial.println(" serial port not responding.");
		}
	}


void initSDCard(UARTClass &serial,uint8_t sdCardChipSelect)
	{
	unsigned long time = millis();
	while (millis() < time+10000)
		{
		boolean didWork = SD.begin(sdCardChipSelect);
		if (didWork)
			{
			sdCardClosed = false;
			break; 
			}    
		}
	if (sdCardClosed)
		{
		serial.println("ERROR : SD Card not responding.");
		}
	else
		{
		Serial.println("SD card initialized."); 
		}
	}

void parseToBinInt16(byte buff[],int16_t var,uint16_t &loc)
	{
	int i=0;
	for (i;i<2;i++)
		{
		buff[i+loc] = byte (var >> (8*i));
		}
	loc=loc+i;
	}

void parseToBinInt32(byte buff[],int32_t var,uint16_t &loc)
	{
	int i=0;
	for (i;i<4;i++)
		{
		buff[i+loc] = byte (var >> (8*i));
		}
	loc=loc+i;
	}

void parseToBinUInt32(byte buff[],uint32_t var,uint16_t &loc)
	{
	int i=0;
	for (i;i<4;i++)
		{
		buff[i+loc] = byte (var >> (8*i));
		}
	loc=loc+i;
	}


void parseInput()
	{
	char comm[80] = {0};
	if (Serial.read() == '#')
		{
		int i = 0;
		while(Serial.available()>0)
			{
			comm[i++] = Serial.read();

			if (comm[i-1] == '&')
				{
				break;  
				}
			}
		if (!strcmp(comm,"dataOn&"))
			{
			if (!sdCardClosed)
				{      
				logData = true;
				Serial.println("Data logging : on.");
				}
			else
				{
				Serial.println("Please initialize SD card first.");
				}
			}
		else if (!strcmp(comm, "dataOff&"))
			{
			logData = false;
			Serial.println("Data logging : off.");
			}
		else if (!strcmp(comm,"serialOn&"))
			{
			printSerialOut = true;
			}
		else if (!strcmp(comm,"serialOff&"))
			{
			printSerialOut = false;
			}
		else if (!strcmp(comm,"initSD&"))
			{
			// initialize SD card
			Serial.println("Initializing SD Card...");
			initSDCard(Serial,sdChipSelect);
			}
		else if (!strcmp(comm,"?&"))
			{
			Serial.println("Help menu");
			Serial.println("List of commands : ");
			Serial.println("dataOn :\tturn on data logging to SD card.");
			Serial.println("dataOff :\tturn off data logging to SD card.");
			Serial.println("initSD :\tinitialize SD card.");
			Serial.println("serialOn :\tturn on serial output.");
			Serial.println("serialOff :\tturn off serial output.");
			Serial.println("? :\t help menu.");
			}
		}
	else
		{
		Serial.print("Improprer serial command. Flushing data...  ");
		while (Serial.available()>0)
			{
			Serial.read();
			}
		Serial.println("Serial data flushed.");
		}

	}


void intHandler0()
	{
	if(digitalRead(pwmPin0))
		{
		trig0 = micros();
		}
	else
		{
		pwm0 = micros()-trig0;
		}
	}

void intHandler1()
	{
	if(digitalRead(pwmPin1))
		{
		trig1 = micros();
		}
	else
		{
		pwm1 = micros()-trig1;
		}
	}

void intHandler2()
	{
	if(digitalRead(pwmPin2))
		{
		trig2 = micros();
		}
	else
		{
		pwm2 = micros()-trig2;
		}
	}

void intHandler3()
	{
	if(digitalRead(pwmPin3))
		{
		trig3 = micros();
		}
	else
		{
		pwm3 = micros()-trig3;
		}
	}

void intHandler4()
	{

	if(digitalRead(pwmPin4))
		{
		trig4 = micros();
		}
	else
		{
		pwm4 = micros()-trig4;
		}
	}

void intHandler5()
	{
	if(digitalRead(pwmPin5))
		{
		trig5 = micros();
		}
	else
		{
		pwm5 = micros()-trig5;
		}
	}

void intHandler6()
	{
	if(digitalRead(pwmPin6))
		{
		trig6 = micros();
		}
	else
		{
		pwm6 = micros()-trig6;
		}
	}

void intHandler7()
	{
	if(digitalRead(pwmPin7))
		{
		trig7 = micros();
		}
	else
		{
		pwm7 = micros()-trig7;
		}
	}

// Calculates the checksum for a given string returns as integer
int getCheckSum(char *string) {
	int i;
	int XOR;
	int c;
	// Calculate checksum ignoring any $'s in the string
	for (XOR = 0, i = 0; i < strlen(string); i++) {
		c = (unsigned char)string[i];
		if (c == '*') break;
		if (c != '$') XOR ^= c;
		}
	return XOR;
	}