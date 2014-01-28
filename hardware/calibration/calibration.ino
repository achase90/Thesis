//TODO: add checking if data is actually available for all sensors, especially serial sensors

#include <Wire.h>
#include <ITG3200.h>
#include <SPI.h>
#include <SD.h>
#include <ADXL362.h>
#include <OneWire.h>
#include <DallasTemperature.h>

#define magInstalled 0
#define pressureInstalled 1
#define ONE_WIRE_BUS 49
#define tempInstalled 0
#define TEMPERATURE_PRECISION 9
#define hmcAddress 0x1E //0011110b, I2C 7bit address of HMC5883
#define accelSlaveSelect 50
#define accelSlaveSelect2 48


#define serialBaud 19200
#define magBaud 19200
#define pressBaud 19200
#define sdChipSelect 51

boolean sdCardClosed = true;

char filename[80]={0};
File dataFile;

char pressSN0[13] = "R11L07-20-A4";
char pressSN1[13] = "R10F30-04-A1";
char pressSN2[13] = "R11L07-20-A5";
char pressSN3[13] = "R13K01-04-A3";

// set up communication with sensors
USARTClass &magSerial = Serial1;
USARTClass &gpsSerial = Serial2;
USARTClass &pressureSerial = Serial3;

//Constructors
ITG3200 gyro = ITG3200(); //construct gyro object
ADXL362 accel = ADXL362(accelSlaveSelect); //construct accel object
ADXL362 accel2 = ADXL362(accelSlaveSelect2); //construct accel object

OneWire oneWire(ONE_WIRE_BUS);

// Pass oneWire reference to Dallas Temperature. 
DallasTemperature sensors(&oneWire);

DeviceAddress tempDeviceAddress; // temperature sensor device address

void setup() {
	unsigned long time=millis();

	Serial.begin(serialBaud); //begin serial communication for debugging
	Serial.println("Serial port initialized.");

#if (magInstalled)
	Serial.println("Initializing magnetometer...");
	serialDeviceInit(Serial, magSerial, magBaud,"mag"); //initialize magnetometer on Serial1
#endif

#if (pressureInstalled)
	Serial.println("Initializing pressure sensors...");
	serialDeviceInit(Serial, pressureSerial, pressBaud,"pre"); //initialize pressure sensors on Serial3
	pressureSerial.setTimeout(50);
#endif

	//set up gyro
	Wire.begin(); //begin wire transmission
	delay(1000); //todo:check if this is necessary
	gyro.init(ITG3200_ADDR_AD0_HIGH); //initialize gyro with address pulled high

	//set up accelerometer
	accel.begin();
	accel.beginMeasure();

	//set up HMC5883L magnetometer
	Wire.beginTransmission(hmcAddress); //open communication with HMC5883
	Wire.write(0x02); //select mode register
	Wire.write(0x00); //continuous measurement mode
	Wire.endTransmission();

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

	//initialize the SD card
	initSDCard(Serial,sdChipSelect);
	Serial.println("Calibration script. To calibrate, type one of the following : ");
	Serial.println("#accelGyro& : calibrate accelerometer and zero-offset calibrate the gyroscope.");
	Serial.println("#pressure& : calibrate zero-offset of pressure sensors and temperature.");
	Serial.println("#mag& : calibrate hard-iron,soft-iron, and alignment of magnetometers.");
	}

void loop() {

	if (Serial.available()>0) //check if there's serial data available
		{
		parseInput();
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
	}
void readHMC(int16_t *hmcReading)
	{
	unsigned long profile = micros();

	//Tell the HMC5883 where to begin reading data
	Wire.beginTransmission(hmcAddress);
	Wire.write(0x03); //select register 3, X MSB register
	Wire.endTransmission();


	//Read data from each axis, 2 registers per axis
	Wire.requestFrom(hmcAddress, 6);
	if(6<=Wire.available()){
		hmcReading[0] = Wire.read()<<8; //X msb
		hmcReading[0] |= Wire.read(); //X lsb
		hmcReading[1] = Wire.read()<<8; //Z msb
		hmcReading[1] |= Wire.read(); //Z lsb
		hmcReading[2] = Wire.read()<<8; //Y msb
		hmcReading[2] |= Wire.read(); //Y lsb
		}
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
	}
void readAccelData(int16_t &accelX,int16_t &accelY,int16_t &accelZ)
	{
	unsigned long profile = micros();
	int16_t accelT = 0;
	accel.readXYZTData(accelX,accelY,accelZ,accelT);
	}
void readSecondAccelData(int16_t &accelX,int16_t &accelY,int16_t &accelZ)
	{
	unsigned long profile = micros();
	int16_t accelT = 0;
	accel2.readXYZTData(accelX,accelY,accelZ,accelT);
	}
void readAllPress (USARTClass &pressureSerial,char add0[], char add1[], char add2[], char add3[], int16_t *pressure)
	{
	pressureSerial.print("WC\r");
	pressure[0] = readUniquePress(pressureSerial,add0);
	pressure[1] = readUniquePress(pressureSerial,add1);
	pressure[2] = readUniquePress(pressureSerial,add2);
	pressure[3] = readUniquePress(pressureSerial,add3);
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


void parseInput()
	{
	char comm[80] = {0};
	//Serial.println(Serial.peek());
	//Serial.print(Serial.peek() == '#');
	if (Serial.read() == '#')
		{
		int i = 0;
		unsigned long now=micros();
delay(10);
		while(Serial.available()>0)
			{
			comm[i++] = Serial.read();
delay(10);
			if (comm[i-1] == '&')
				{
				Serial.println(comm);
				break;  
				}
			}
		if (!strcmp(comm,"accelGyro&"))
			{
			accelGyroMain();
			}
		else if (!strcmp(comm, "pressure&"))
			{
			pressureMain();
			}
		else if (!strcmp(comm, "mag&"))
			magMain();
		else if (!strcmp(comm, "?&"))
			{
			Serial.println("Help menu");
			Serial.println("List of commands : ");
			Serial.println("accelGyro :\tcalibate accel and gyro");
			Serial.println("pressure :\tcalibrate pressure sensors.");
			Serial.println("mag :\tcalibrate magnetometers.");
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
void pressureMain()
	{
	Serial.println("Pressure calibration routine.");
	Serial.println("Ensure the probe is covered or in a zero wind environment. Type 'r' when ready.");
	while(Serial.read()!='r');
	Serial.println("Collecting data...");
	//open SD card
		SD.remove("PRESSURE.clb");
	dataFile = SD.open("PRESSURE.clb",FILE_WRITE);

	//write header line
	dataFile.print('\t');
	dataFile.print("press0");
	dataFile.print('\t');
	dataFile.print("press1");
	dataFile.print('\t');
	dataFile.print("press2");
	dataFile.print('\t');
	dataFile.print("press3");
	dataFile.print('\t');
	dataFile.print("temperature");
	dataFile.print('\n');

	int16_t pressure[4]; //pressure sensor data
	int16_t temperature=0;

	for(int i=0;i<100;i++) //read for 10 seconds
		{
		//read pressure transducers
		readAllPress (pressureSerial,pressSN0,pressSN1,pressSN2,pressSN3,pressure);
#if (tempInstalled)
		sensors.requestTemperatures(); // Send the command to get temperatures
		temperature = int16_t (100*sensors.getTempF(tempDeviceAddress));
#endif
		dataFile.print('\t');
		dataFile.print(pressure[0]);
		dataFile.print('\t');
		dataFile.print(pressure[1]);
		dataFile.print('\t');
		dataFile.print(pressure[2]);
		dataFile.print('\t');
		dataFile.print(pressure[3]);
		dataFile.print('\t');
		dataFile.print(temperature);
		dataFile.print('\n');
		}
	dataFile.close();
	Serial.println("Pressure calibration complete.");
	}
void magMain()
	{
	Serial.println("Magnetometer calibration routine.");
	Serial.println("Rotate system randomly for 10 seconds. Type 'r' when ready.");
	while(Serial.read()!='r');

	//open SD card
	SD.remove("MGNTMTRS.clb");
	dataFile = SD.open("MGNTMTRS.clb",FILE_WRITE);
	dataFile.seek(0);

	Serial.println("Collecting data...");
	//write header line
	dataFile.print('\t');
	dataFile.print("magX");
	dataFile.print('\t');
	dataFile.print("magY");
	dataFile.print('\t');
	dataFile.print("magZ");
	dataFile.print('\t');
	dataFile.print("hmcX");
	dataFile.print('\t');
	dataFile.print("hmcY");
	dataFile.print('\t');
	dataFile.print("hmcZ");
	dataFile.print('\n');

	int16_t magReading[3]; //magnetometer data
	int16_t hmcReading[3]; //hmc5883L mag data

	unsigned long now = millis();
	while(millis()<now+10000) //read for 10 seconds
		{
		//read magnetometer data
#if (magInstalled)
		readMagnetometer(magSerial,magReading);
#endif
		readHMC(hmcReading);

		dataFile.print('\t');
		dataFile.print(magReading[0]);
		dataFile.print('\t');
		dataFile.print(magReading[1]);
		dataFile.print('\t');
		dataFile.print(magReading[2]);
		dataFile.print('\t');
		dataFile.print(hmcReading[0]);
		dataFile.print('\t');
		dataFile.print(hmcReading[2]); //switching order so it's X Y Z, not X Z Y
		dataFile.print('\t');
		dataFile.print(hmcReading[1]);
		dataFile.print('\n');

		/*Serial.print('\t');
		Serial.print(magReading[0]);
		Serial.print('\t');
		Serial.print(magReading[1]);
		Serial.print('\t');
		Serial.print(magReading[2]);
		Serial.print('\t');
		Serial.print(hmcReading[0]);
		Serial.print('\t');
		Serial.print(hmcReading[2]); //switching order so it's X Y Z, not X Z Y
		Serial.print('\t');
		Serial.print(hmcReading[1]);
		Serial.print('\n');*/

		}
	dataFile.close();
	Serial.println("Magnetometer calibration complete.");
	}
void accelGyroMain()
	{
	//open SD card
	SD.remove("ACCLGYRO.clb");
	dataFile = SD.open("ACCLGYRO.clb",FILE_WRITE);

	//write header line
	dataFile.print('\t');
	dataFile.print("accelX");
	dataFile.print('\t');
	dataFile.print("accelY");
	dataFile.print('\t');
	dataFile.print("accelZ");
	dataFile.print('\t');
	dataFile.print("gyroX");
	dataFile.print('\t');
	dataFile.print("gyroY");
	dataFile.print('\t');
	dataFile.print("gyroZ");
	dataFile.print('\n');

	Serial.println("Place the system in an orientation and keep stationary. Type 'r' when ready.");
	while(Serial.read()!='r');
	Serial.println("Collecting data...");
	accelGyroRead();
	Serial.println("Now change orientation, and type 'r' when ready.");
	while(Serial.read()!='r');
	Serial.println("Collecting data...");
	accelGyroRead();
	Serial.println("Now change orientation, and type 'r' when ready.");
	while(Serial.read()!='r');
	Serial.println("Collecting data...");
	accelGyroRead();
	Serial.println("Now change orientation, and type 'r' when ready.");
	while(Serial.read()!='r');
	Serial.println("Collecting data...");
	accelGyroRead();
	Serial.println("Now change orientation, and type 'r' when ready.");
	while(Serial.read()!='r');
	Serial.println("Collecting data...");
	accelGyroRead();
	Serial.println("Now change orientation, and type 'r' when ready.");
	while(Serial.read()!='r');
	Serial.println("Collecting data...");
	accelGyroRead();
	dataFile.close();
	Serial.println("Accelerometer and gyroscope calibration done.");
	}
void accelGyroRead()
	{
	int16_t gyroX, gyroY, gyroZ;
	int16_t accelX, accelY, accelZ, accelT;

	for(int i=0;i<100;i++)
		{
		readAccelData(accelX,accelY,accelZ);
		//readSecondAccelData(accel2X,accel2Y,accel2Z);
		readGyroData(gyroX,gyroY,gyroZ);

	dataFile.print('\t');
	dataFile.print(accelX);
	dataFile.print('\t');
	dataFile.print(accelY);
	dataFile.print('\t');
	dataFile.print(accelZ);
	dataFile.print('\t');
	dataFile.print(gyroX);
	dataFile.print('\t');
	dataFile.print(gyroY);
	dataFile.print('\t');
	dataFile.print(gyroZ);
	dataFile.print('\n');
/*
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
	Serial.print('\n');
        Serial.println("looped");*/
		}
	}

