/*
 ADXL362_SimpleRead.ino -  Simple XYZ axis reading example
 for Analog Devices ADXL362 - Micropower 3-axis accelerometer
 go to http://www.analog.com/ADXL362 for datasheet
 
 
 License: CC BY-SA 3.0: Creative Commons Share-alike 3.0. Feel free 
 to use and abuse this code however you'd like. If you find it useful
 please attribute, and SHARE-ALIKE!
 
 Created June 2012
 by Anne Mahaffey - hosted on http://annem.github.com/ADXL362

Connect SCLK, MISO, MOSI, and CSB of ADXL362 to
SCLK, MISO, MOSI, and DP 10 of Arduino 
(check http://arduino.cc/en/Reference/SPI for details)
 
*/ 

#include <SPI.h>
#include <ADXL362.h>


// TODO: create return value for all data

ADXL362 xl;

int temp;
float FS=10000;
int16_t XValue, YValue, ZValue, Temperature;


void setup(){
    Serial.begin(9600);
    xl.begin();                   // Setup SPI protocol, issue device soft reset
    xl.beginMeasure();            // Switch ADXL362 to measure mode  
    //xl.checkAllControlRegs();     // Burst Read all Control Registers, to check for proper setup
	byte range = xl.SPIreadOneRegister(0x2c);
range = (range >> 6);
Serial.println(range);
switch (range)
{
 case 0: FS = 2;break;
 case 1: FS = 4;break;
 case 3: FS = 8;break;
 case 4: FS = 8; break;  
}
    Serial.print("\n\nBegin Loop Function:\n");
}

void loop(){
    
    // read all three axis in burst to ensure all measurements correspond to same sample time
    xl.readXYZTData(XValue, YValue, ZValue, Temperature);  	 
    //long xData = xl.readXData();
    //Serial.println(xData);
        Serial.print('\t');
    Serial.print(FS*XValue/4096,6);
    Serial.print('\t');
        Serial.print(FS*YValue/4096,6);
    Serial.print('\t');
        Serial.print(FS*ZValue/4096,6);
    Serial.print('\t');
        Serial.println( Temperature);
    delay(100);                // Arbitrary delay to make serial monitor easier to observe
}

