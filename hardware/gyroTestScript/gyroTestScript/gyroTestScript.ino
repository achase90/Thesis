// ITG-3200_test
// Copyright 2010-2011 Filipe Vieira & various contributors.
// http://code.google.com/p/itg-3200driver
// Simple test of gyro sensors output using default settings.

#include <Wire.h>
#include <ITG3200.h>

ITG3200 gyro = ITG3200();
float  x,y,z;
int16_t ix, iy, iz;

void setup(void) {
  Serial.begin(9600);
  Wire.begin();      // if experiencing gyro problems/crashes while reading XYZ values
                     // please read class constructor comments for further info.
  delay(1000);
  // Use ITG3200_ADDR_AD0_HIGH or ITG3200_ADDR_AD0_LOW as the ITG3200 address 
  // depending on how AD0 is connected on your breakout board, check its schematics for details
  gyro.init(ITG3200_ADDR_AD0_HIGH); 
  
 // Serial.print("zeroCalibrating...");
// gyro.zeroCalibrate(2500, 2);
  //Serial.println("done.");
  //gyro.setOffsets(-65489,-37,-4);
  byte x = gyro.getFilterBW();

}

void loop(void) {
  unsigned long now = micros();
      while (gyro.isRawDataReady()) {
    
    // Reads uncalibrated raw values from the sensor 
    gyro.readGyroRaw(&ix,&iy,&iz); 
        Serial.print("  "); 
    Serial.print(ix); 
        Serial.print("  "); 
    Serial.print(iy); 
        Serial.print("  "); 
    Serial.print(iz); 
            Serial.print("  "); 
    Serial.println(micros()-now); 
    now = micros();
}
}



