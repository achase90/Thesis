#include <SPI.h>
#include <ADXL362.h>
#include <math.h>
#define PI 3.14159265

ADXL362 xl;

int16_t accelX, accelY, accelZ;
int16_t val1,val2,val3;
float R[] = {.2974 ,.0166, .7843, -2.6941, -1.2293, .1676 ,-.7210, -.4136 ,-.0013};
//R[0] = -0.6765;
//R[1] = 0.6795;
//R[2] = -0.1461;
//R[3] = -0.228;
//R[4] = 0.2797;
//R[5] = 0.5173;
//R[6] = -0.4067;
//R[7] = -0.3419;
//R[8] = 0.8092;

void setup() {
	int16_t accelX, accelY, accelZ;
int16_t val1,val2,val3;

	
	Serial.begin(9600);
	Serial.println("Serial port opened");

	Serial1.begin(19200);
	Serial.println("Serial1 open");
	Serial.println();

	xl.begin();                   // Setup SPI protocol, issue device soft reset
	xl.beginMeasure();            // Switch ADXL362 to measure mode  
	Serial.println("accelerometer on");
	Serial.println("Place system still, type 'r' when ready");
	while(!Serial.available());
	if (Serial.read() == 'r')
		{
			for(int i=0;i<100;i++)
				{
		readMagAccel(val1, val2, val3, accelX, accelY, accelZ);
				}
		}

	Serial.println("Now change orientation, place system still, type 'r' when ready");
	while(!Serial.available());
	if (Serial.read() == 'r')
		{
			for(int i=0;i<100;i++)
				{
		readMagAccel(val1, val2, val3, accelX, accelY, accelZ);
				}
		}

	Serial.println("Now change orientation, place system still, type 'r' when ready");
	while(!Serial.available());
	if (Serial.read() == 'r')
		{
			for(int i=0;i<100;i++)
				{
		readMagAccel(val1, val2, val3, accelX, accelY, accelZ);
				}
		}
	//calcRotMatrix();
	Serial.println("Calibration done.");
	}

void loop() {
	int16_t accelX, accelY, accelZ;
int16_t val1,val2,val3;

	readMagAccel(val1, val2, val3, accelX, accelY, accelZ);
	float fval1 = val1;
	float fval2 = val2;
	float fval3 = val3;

	normVec(fval1,fval2, fval3);
	//Serial.print('\t');

	//Serial.print(fval1);
	//Serial.print('\t');
	//Serial.print(fval2);
	//Serial.print('\t');
	//Serial.print(fval3);

	getAngles(fval1, fval2,fval3,R);
	//Serial.print('\t');

	//Serial.print(fval1);
	//Serial.print('\t');
	//Serial.print(fval2);
	//Serial.print('\t');
	//Serial.print(fval3);
	Serial.println();
	}

void readMagAccel(int16_t &val1, int16_t &val2, int16_t &val3, int16_t &accelX, int16_t &accelY, int16_t &accelZ)
	{
	//Serial.print("made it to the function");
	int16_t temp;
	xl.readXYZTData(accelX,accelY,accelZ,temp);
	//Serial.print('\t');
	//Serial.print(accelX);
	//Serial.print('\t');
	//	Serial.print(accelY);
	//Serial.print('\t');
	//	Serial.print(accelZ);

	Serial1.print("*99P\r");
	delay(5);
	if (Serial1.available()>0)
		{
		byte buff[70];
		for (int i=0;i<7;i++)
			{
			buff[i]=Serial1.read(); 
			}
		val1= buff[1]  + (buff[0] << 8);
		val2 = buff[3] + (buff[2] << 8);
		val3 = buff[5] + (buff[4]  << 8);
		Serial.print('\t');

		Serial.print(val1);
		Serial.print('\t');
		Serial.print(val2);
		Serial.print('\t');
		Serial.print(val3);
		Serial.println();
		}
	else
		{
		Serial.println("no magnetometer data available");
		}
	}


void normVec(float &val1,float &val2, float &val3)
	{
	float x1 = val1;
	float x2 = val2;
	float x3 = val3;

	val1 = x1/sqrt(x1*x1 + x2*x2 + x3*x3);
	val2 = x2/sqrt(x1*x1 + x2*x2 + x3*x3);
	val3 = x3/sqrt(x1*x1 + x2*x2 + x3*x3);
	}

void getAngles(float &val1, float &val2,float &val3,float R[])
	{
	normVec(val1,val2, val3); //normalize

	float x1 = val1; //copy
	float x2 = val2;
	float x3 = val3;

	//rotate
	val1 = x1*R[0]+x2*R[3]+x3*R[6];
	val2 = x1*R[1]+x2*R[4]+x3*R[7];
	val3 = x1*R[2]+x2*R[5]+x3*R[8];

		//	Serial.print('\t');

		//Serial.print(val1);
		//Serial.print('\t');
		//Serial.print(val2);
		//Serial.print('\t');
		//Serial.print(val3);
		//Serial.println();

	//calc angles
	val1 = acos(val1) * 180/PI;
	val2 = acos(val2) * 180/PI;
	val3 = acos(val3) * 180/PI;
	}