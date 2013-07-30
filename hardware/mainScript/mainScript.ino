#include <Wire.h>
#include <ITG3200.h>
#include <SPI.h>
#include <SD.h>
//#include <HardwareSerial.h>

HardwareSerial *magSerial;
//magSerial = &Serial1;
//magSerial magSerial();
//magSerial = &Serial1;
HardwareSerial *gpsSerial;
HardwareSerial *pressSerial;

int magBaud = 9600;
int gpsBaud = 9600;
int pressBaud = 9600;

byte pressHigh;


void setup() {
  Serial.begin(9600); //begin serial communication for debugging
  Serial.println("Serial port initialized.");


  serialDeviceInit(Serial, Serial1, magBaud,"mag");
  serialDeviceInit(Serial, Serial2, gpsBaud,"gps");
  serialDeviceInit(Serial, Serial3, pressBaud,"pre");

  /*
  gpsSerial.begin(gpsBaud); //begin GPS serial communication
   start = millis();
   int time = start;
   while (!gpsSerial.available() && time < start +10000)
   {
   time = millis(); //wait for device to respond
   }
   magSerial.flush(); //flush data in serial buffer
   Serial.println("Magnetometer serial port initiliazed.");
   
   Serial.println("GPS serial port initialized");
   pressSerial.begin(pressBaud);
   */
}

void loop() {
  //start timer
  unsigned long time = millis();
  //read pressure transducer
  for (int i=0;i<4;i++)
  {
    //readPress (pressAddress,CS, byte &highByte, byte &lowByte)
  }
  //read temperature of each pressure transducer

    //read magnetometer

    //read gyro

  //read accel

  //read GPS
  readGPS();
  //format packet to be sent to SD card

  //write to SD card
}

/*void readPress (pressAddress,CS, byte &highByte, byte &lowByte)
 {
 //send pressAddress to CS
 
 }
 */

void readGPS()
{

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
    deviceSerial.flush(); //flush data in serial buffer
    mainSerial.print(ID);
    mainSerial.println(" serial port initiliazed.");
  }
  else{
    mainSerial.print("ERROR : ");
    mainSerial.print(ID);
    mainSerial.println(" serial port not responding.");
  }
}


