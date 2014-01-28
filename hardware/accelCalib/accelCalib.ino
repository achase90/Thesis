#include <SPI.h>
#include "ADXL362.h"
ADXL362 xl(50);

void setup() {

  Serial.begin(9600);
  Serial.println("Serial port opened");


  xl.begin();                   // Setup SPI protocol, issue device soft reset
  xl.beginMeasure();            // Switch ADXL362 to measure mode  
  
 // Serial.println("accelerometer on");
  Serial.println("Place system still, type 'r' when ready");
  calib();
  Serial.println("Now change orientation, place system still, type 'r' when ready");
  calib();
  Serial.println("Now change orientation, place system still, type 'r' when ready");
  calib();
  //Serial.println("Now change orientation, place system still, type 'r' when ready");
  //calib();
  //Serial.println("Now change orientation, place system still, type 'r' when ready");
  //calib();
  //Serial.println("Now change orientation, place system still, type 'r' when ready");
  //calib();
  Serial.println("Calibration done.");
}

void loop() {
}

void calib(void)
{
  while(!Serial.available());
  if (Serial.read() == 'r')
  {
    for(int i=0;i<100;i++)
    {
      int16_t XValue=0;
      int16_t YValue=0;
      int16_t ZValue=0;
      int16_t Temperature=0;
      xl.readXYZTData(XValue, YValue, ZValue, Temperature);  	 
      Serial.print('\t');
      Serial.print(XValue);
      Serial.print('\t');
      Serial.print(YValue);
      Serial.print('\t');
      Serial.print(ZValue);
      Serial.println();
    }
  } 
}


