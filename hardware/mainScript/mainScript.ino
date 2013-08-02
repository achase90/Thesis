//TODO: add checking if data is actually available for all sensors, especially serial sensors

#include <Wire.h>
#include <ITG3200.h>
#include <SPI.h>
#include <SD.h>
#include <ADXL362.h>

const uint32_t magBaud = 9600;
const uint32_t gpsBaud = 9600;
const uint32_t pressBaud = 9600;

unsigned long startTime;

// set up communication with sensors
USARTClass &magSerial = Serial1;
USARTClass &gpsSerial = Serial2;
USARTClass &pressureSerial = Serial3;


ITG3200 gyro = ITG3200(); //construct gyro object


ADXL362 accel; //construct accel object

char pressSN0[13] = "4F15-01-A213";
char pressSN1[13] = "R10F30-04-A1";
char pressSN2[13] = "R11L7-20-A50"; //not sure this serial number is correct
char pressSN3[13] = "R11L7-20-A51"; //not sure this serial number is correct

void setup() {

  Serial.begin(9600); //begin serial communication for debugging
  Serial.println("Serial port initialized.");

  serialDeviceInit(Serial, magSerial, magBaud,"mag"); //initialize magnetometer on Serial1
  serialDeviceInit(Serial, gpsSerial, gpsBaud,"gps"); //initialize gps on Serial2
  serialDeviceInit(Serial, pressureSerial, pressBaud,"pre"); //initialize pressure sensors on Serial3
  gpsSerial.setTimeout(200);

  //set up gyro
  Wire.begin(); //begin wire transmission
  delay(1000);
  gyro.init(ITG3200_ADDR_AD0_HIGH); //initialize gyro with address pulled high


  //set up accelerometer
  accel.begin();
  accel.beginMeasure();
  startTime = millis();
  gpsSerial.flush();
}

void loop() {
  //start timer
  unsigned long time = millis();
  int16_t pressure[4]; //pressure sensor data
  int16_t magReading[3]; //magnetometer data
  int16_t gyroX, gyroY, gyroZ;
  int16_t accelX, accelY, accelZ, accelT;
  char msgID[6]="?????";
  char *gpsStatus={"?"},*nsInd={"?"},*ewInd={"?"},*mode={"?"};
  int32_t gpsLat=0,gpsLong=0,gpsSpd=0,gpsCrs={0};
  uint32_t utcTime=0,date=0,CS={0};

  //read pressure transducers
  readAllPress (pressureSerial,pressSN0,pressSN1,pressSN2,pressSN3,pressure);
  Serial.print(pressure[0]);
  Serial.print('\t');
  Serial.print(pressure[1]);

  //read magnetometer
  readMagnetometer(magSerial,magReading);
  Serial.print('\t');
  Serial.print(magReading[0]);
  Serial.print('\t');
  Serial.print(magReading[1]);
  Serial.print('\t');
  Serial.print(magReading[2]);

  //read gyro
  readGyroData(gyroX,gyroY,gyroZ);
  Serial.print('\t');
  Serial.print(gyroX);
  Serial.print('\t');
  Serial.print(gyroY);
  Serial.print('\t');
  Serial.print(gyroZ);
  Serial.print('\t');

  //read accel
  accel.readXYZTData(accelX,accelY,accelZ,accelT);
  Serial.print(accelX);
  Serial.print('\t');
  Serial.print(accelY);
  Serial.print('\t');
  Serial.print(accelZ);
  Serial.print('\t');

  //read GPS
  if (gpsSerial.available()>0)
  {
    readGPS(gpsSerial,msgID,utcTime,&gpsStatus, gpsLat,&nsInd,gpsLong,&ewInd,gpsSpd,gpsCrs,date,&mode,CS);
  }

  //format packet to be sent to SD card

  Serial.print(msgID);
  Serial.print("\t");

  Serial.print(utcTime);
  Serial.print("\t");

  Serial.print(gpsStatus);
  Serial.print("\t");

  Serial.print(gpsLat);
  Serial.print('\t');

  Serial.print(nsInd);
  Serial.print('\t');

  Serial.print(gpsLong);
  Serial.print('\t');

  Serial.print(ewInd);
  Serial.print('\t');

  Serial.print(gpsSpd);
  Serial.print('\t');

  Serial.print(gpsCrs);
  Serial.print('\t');

  Serial.print(date);
  Serial.print('\t');

  Serial.print(mode);
  Serial.print('\t');

  Serial.print(CS);
  Serial.print('\t');

  //write to SD card
  unsigned long now = millis()-time;
  Serial.println(now);
}

void readMagnetometer(USARTClass &magSerial,int16_t *magReading)
{
  magSerial.print("*99P\r");
  if (magSerial.available()>0)
  {
    byte buff[70];
    for (int i=0;i<7;i++)
    {
      buff[i]=magSerial.read(); 
    }
    magReading[0] = buff[1]  + (buff[0] << 8);
    magReading[1] = buff[3] + (buff[2] << 8);
    magReading[2] = buff[5] + (buff[4]  << 8);
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

void readGPS(USARTClass &gpsSerial,char *msgID,uint32_t &utcTime,char **gpsStatus, int32_t &gpsLat,char **nsInd,int32_t &gpsLong,char **ewInd,int32_t &gpsSpd,int32_t &gpsCrs,uint32_t &date,char **mode,uint32_t &CS)
{
  char bytesIn[200] = {0};
  int nchars;
  if (gpsSerial.available()>0)
  {
    if (gpsSerial.read() == '$')
    {
      nchars = gpsSerial.readBytesUntil(0x0a,bytesIn,200);

      //process gps string
      char *s1=bytesIn;
      char *pt;
      pt = strsep(&s1,",*");

      for (int j=0;j<8;j++)
      {
        msgID[j] = (char )pt[j];
      }


      int i=0;
      while (pt = strsep( &s1,",*"))
      {
        switch (i++)
        {
        case 0:
          {
            utcTime = 100*atof(pt);
            break;
          }
        case 1:
          {
            *gpsStatus = pt;
            break;
          }
        case 2:
          {                    
            gpsLat = 100000*atof(pt);
            break;
          }
        case 3:
          {                    
            *nsInd = pt;
            break;
          }
        case 4:
          {                    
            gpsLong = 100000*atof(pt);
            break;
          }
        case 5:
          {                    
            * ewInd = pt;
            break;
          }
        case 6:
          {                    
            gpsSpd = 1000*atof(pt);
            break;
          }
        case 7:
          {                    
            gpsCrs = 1000*atof(pt);
            break;
          }
        case 8:
          {                    
            date = atoi(pt);
            break;
          }
        case 9:
          {                    
            //magnetic variation, not available
            break;
          }
        case 10:
          {                    
            //magnetic variation indicator, not available
            break;
          }
        case 11:
          {                    
            *mode = pt;
            break;
          }
        case 12:
          {                    
            CS = atoi(pt);
            break;
          }
        }
      }

    }


    // if the character that was read then flush the rest of the data
    while (gpsSerial.available()>0)
    {
      gpsSerial.read(); 
    }
  }
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



