#include <Wire.h>
#include <ITG3200.h>
#include <SPI.h>
#include <SD.h>
//#include <HardwareSerial.h>

HardwareSerial *magSerial;
HardwareSerial *gpsSerial;
HardwareSerial *pressSerial;

int magBaud = 9600;
int gpsBaud = 9600;
int pressBaud = 9600;


char pressSN0[13] = "4F15-01-A213";
char pressSN1[13] = "R10F30-04-A1";
char pressSN2[13] = "R11L7-20-A50"; //not sure this serial number is correct
char pressSN3[13] = "R11L7-20-A51"; //not sure this serial number is correct

void setup() {
  Serial.begin(9600); //begin serial communication for debugging
  Serial.println("Serial port initialized.");


  serialDeviceInit(Serial, Serial1, magBaud,"mag");
  //serialDeviceInit(Serial, Serial2, gpsBaud,"gps");
  serialDeviceInit(Serial, Serial3, pressBaud,"pre");

}

void loop() {
  int16_t pressure[4];

  //start timer
  unsigned long time = millis();
  //read pressure transducer
  readAllPress (Serial3,pressSN0,pressSN1,pressSN2,pressSN3,pressure);
  Serial.print(pressure[0]);
  Serial.print('\t');
  Serial.println(pressure[1]);
  //read temperature of each pressure transducer

  //read magnetometer

  //read gyro

  //read accel

  //read GPS
  readGPS();
  //format packet to be sent to SD card

  //write to SD card
  delay(10);
}

void readAllPress (USARTClass &pressureSerial,char add0[], char add1[], char add2[], char add3[], int16_t *pressure)
{
  pressureSerial.print("WC\r");
  pressure[0] = readUniquePress(pressureSerial,add0);
  pressure[1] = readUniquePress(pressureSerial,add1);
  //pressure[2] = readUniquePress(pressureSerial,add2);
  //pressure[3] = readUniquePress(pressureSerial,add3);
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
  int16_t pressure = strtol(bytesIn,NULL,16);
  return pressure;
}

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








