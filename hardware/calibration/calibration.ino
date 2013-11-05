//TODO: add checking if data is actually available for all sensors, especially serial sensors

#include <Wire.h>
#include <ITG3200.h>
#include <SPI.h>
#include <SD.h>
#include <ADXL362.h>

#define pressureInstalled 1

#define serialBaud 19200
#define pressBaud 9600
#define sdChipSelect 52

// set up communication with sensors
USARTClass &pressureSerial = Serial3;

//Constructors
ITG3200 gyro = ITG3200(); //construct gyro object
ADXL362 accel; //construct accel object

char pressSN0[13] = "R11L07-20-A4";
char pressSN1[13] = "R10F30-04-A1";
char pressSN2[13] = "R11L07-20-A5";
char pressSN3[13] = "4F15-01-A213";

int16_t pressure[4]; //pressure sensor data
int16_t gyroX, gyroY, gyroZ=0;
int16_t accelX, accelY, accelZ, accelT=0;


float pressureZero[4]={0}; //pressure sensor data
float gyroXZero, gyroYZero, gyroZZero=0;
float accelXZero, accelYZero, accelZZero=0;
float accelXNeg, accelYNeg, accelZNeg=0;
float accelXPos, accelYPos, accelZPos=0;

void setup() {

	Serial.begin(serialBaud); //begin serial communication for debugging
	Serial.println("Serial port initialized.");

#if (pressureInstalled)
	Serial.println("Initializing pressure sensors...");
	pressureSerial.begin(pressBaud);
	pressureSerial.setTimeout(50);
#endif
	//set up gyro
	Wire.begin(); //begin wire transmission
	delay(1000); //todo:check if this is necessary
	gyro.init(ITG3200_ADDR_AD0_HIGH); //initialize gyro with address pulled high

	//set up accelerometer
	accel.begin();
	accel.beginMeasure();
	Serial.println("Connect one output to the other for each differential pressure sensor. Type 'r' when finished.");
	Serial.println("Place data acquisition system flat on a level surface. Type 'r' when finished, then do not touch until prompted.");
	while (Serial.read()!='r'){}
	unsigned long then = millis();
	unsigned long timeOut = 20000; //read data for 20 seconds
	int i=0;
	while(millis()<then+timeOut)
		{
		//read pressure transducers
#if (pressureInstalled)
		readAllPress (pressureSerial,pressSN0,pressSN1,pressSN2,pressSN3,pressure);
#endif
		//accumulate and average pressure values
		pressureZero[0] = ((i-1)*pressureZero[0]+pressure[0])/i;
		pressureZero[1] = ((i-1)*pressureZero[1]+pressure[1])/i;
		pressureZero[2] = ((i-1)*pressureZero[2]+pressure[2])/i;

		//read accel data
		accel.readXYZTData(accelX,accelY,accelZ,accelT);
		accelXZero = ((i-1)*accelXZero+accelX)/i;
		accelYZero = ((i-1)*accelYZero+accelY)/i;
		accelZNeg = ((i-1)*accelZNeg+accelZ)/i;

		//read gyro data
		readGyroData(gyroX,gyroY,gyroZ);
		gyroXZero = ((i-1)*gyroXZero+gyroX)/i;
		gyroYZero = ((i-1)*gyroYZero+gyroY)/i;
		gyroXZero = ((i-1)*gyroXZero+gyroX)/i;

		if (!(i++%500)) //every 500th time print something to serial, and increment i
			{
			Serial.println("Collecting data...");
			}
		}

	Serial.println("Flip data acquisition system upside down and place on a flat surface. Type 'r' when finished, then do not touch until prompted.");
	readAccelData(Serial,timeOut,accelX,accelY,accelZ,accelT,accelZPos,accelZ);
	Serial.println("Place tall dimension of data acquisition parallel to gravity. Type 'r' when finished, then do not touch until prompted.");
	readAccelData(Serial,timeOut,accelX,accelY,accelZ,accelT,accelYPos,accelY);
	Serial.println("Flip data acquisition system, tall dimension of data acquisition parallel to gravity. Type 'r' when finished, then do not touch until prompted.");
	readAccelData(Serial,timeOut,accelX,accelY,accelZ,accelT,accelYNeg,accelY);
	Serial.println("Place short dimension of data acquisition parallel to gravity. Type 'r' when finished, then do not touch until prompted.");
	readAccelData(Serial,timeOut,accelX,accelY,accelZ,accelT,accelXPos,accelX);
	Serial.println("Flip data acquisition system, tall dimension of data acquisition parallel to gravity. Type 'r' when finished, then do not touch until prompted.");
	readAccelData(Serial,timeOut,accelX,accelY,accelZ,accelT,accelXNeg,accelX);
	}
void loop() {
	}

void readAccelData(UARTClass &Serial,unsigned long timeOut,int16_t &accelX,int16_t &accelY,int16_t &accelZ, int16_t &accelT, float &fDesired, int16_t desired)
	{
	int i=0;
	while (Serial.read()!='r'){}
	unsigned long then = millis();
	while(millis()<then+timeOut)
		{
		//read accel data
		accel.readXYZTData(accelX,accelY,accelZ,accelT);
		//throw out unwanted data
		//accumulate and average desired data
		desired = ((i-1)*fDesired+desired)/i;
		if (!(i++%500)) //every 500th time print something to serial, and increment i
			{
			Serial.println("Collecting data...");
			}

		}
	}
void readGyroData(int16_t &gyroX,int16_t &gyroY,int16_t &gyroZ)
	{
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

void readAllPress (USARTClass &pressureSerial,char add0[], char add1[], char add2[], char add3[], int16_t *pressure)
	{
	pressureSerial.print("WC\r");
	pressure[0] = readUniquePress(pressureSerial,add1);
	pressure[1] = readUniquePress(pressureSerial,add2);
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
