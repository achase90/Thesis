#include <SPI.h>
#include <ADXL362.h>


ADXL362 xl;

int16_t XValue, YValue, ZValue, Temperature;


void setup(){
  Serial.begin(9600);
  xl.begin();                   // Setup SPI protocol, issue device soft reset
  xl.beginMeasure();            // Switch ADXL362 to measure mode  
  byte range = xl.SPIreadOneRegister(0x2c);
  range = (range >> 6) & 00000011;
  Serial.println(range);
  switch (range)
  {
  case 0: 
    FS = 2;
    break;
  case 1: 
    FS = 4;
    break;
  case 2: 
    FS = 8;
    break;
  case 3: 
    FS = 8; 
    break;  
  }
  FS = 2;
  Serial.print("\n\nBegin Loop Function:\n");
}

void loop(){

  // read all three axis in burst to ensure all measurements correspond to same sample time
  xl.readXYZTData(XValue, YValue, ZValue, Temperature);  	 

  Serial.print('\t');
  Serial.print(XValue);
  Serial.print('\t');
  Serial.print(YValue);
  Serial.print('\t');
  Serial.print(ZValue);
  Serial.print('\t');
  Serial.println( Temperature);
  delay(100);                // Arbitrary delay to make serial monitor easier to observe
}


