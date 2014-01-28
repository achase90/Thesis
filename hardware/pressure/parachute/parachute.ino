#include <SPI.h>
#include <SD.h>

File myFile;
int i=0;

void setup() {
	Serial.begin(9600);
	Serial3.begin(19200);
	Serial.println("Serial ports open");
SD.begin(51);
	}

void loop() {
	char bytesIn[80] = {0x00};
	int nchars;
	char trash[80] = {0x00};
	int16_t pressure;
	Serial3.println("WC\r");
delay(10);
/*
delay(10);
	Serial3.print("UR11L07-20-A4RC\r");
	nchars = Serial3.readBytesUntil('=',trash,80);
	nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
	pressure = (int16_t)strtol(bytesIn,NULL,16);
	Serial.print(pressure);
	Serial.print('\t');

	Serial3.print("UR10F30-04-A1RC\r");
	nchars = Serial3.readBytesUntil('=',trash,80);
	nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
	pressure = (int16_t)strtol(bytesIn,NULL,16);
	Serial.print(pressure);
Serial.print('\t');

	bytesIn = {0x00};
	Serial3.print("UR11L07-20-A5RC\r");
	nchars = Serial3.readBytesUntil('=',trash,80);
	nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
	pressure = (int16_t)strtol(bytesIn,NULL,16);
	Serial.print(pressure);
Serial.print('\t');

*/
	//bytesIn = {0x00};
	Serial3.print("UR13K01-04-A3RC\r");
        //Serial3.print("U4F15-01-A213RH\r");
        //Serial3.print("RH\r");
        delay(10);
        /*while(Serial3.available()>0)
        {
          delay(10);
        Serial.write(Serial3.read());
      //delay(5);  
        }*/
	nchars = Serial3.readBytesUntil('=',trash,80);
	nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
	pressure = (int16_t)strtol(bytesIn,NULL,16);
	Serial.print(pressure);
Serial.println();
File myFile = SD.open("parachut.txt",FILE_WRITE);
    myFile.println(pressure);
myFile.close();
//delay(100);
	}
