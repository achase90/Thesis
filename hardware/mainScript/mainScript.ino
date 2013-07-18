#include <ITG3200.h>
#include <SPI.h>
#include <SD.h>

byte pressHigh;

void setup() {
  Serial.begin(9600); //begin serial communication for debugging
  Serial.println("Serial port initialized.");
  Serial1.begin(9600); //begin magnetometer serial communication
  Serial.println("Magnetometer serial port initiliazed.");
  Serial2.begin(9600); //begin GPS serial communication
  Serial.println("GPS serial port initialized");
}

void loop() {
  //start timer
  unsigned long time = millis();
  //read pressure transducer
for (int i=0,i<4,i++)
{
  readPress (pressAddress,CS, byte &highByte, byte &lowByte)
}
  //read temperature of each pressure transducer

  //read magnetometer

  //read gyro

  //read accel

  //read GPS

  //format packet to be sent to SD card

  //write to SD card
}

void readPress (pressAddress,CS, byte &highByte, byte &lowByte)
{
  //send pressAddress to CS
  
}

