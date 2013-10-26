//TODO: add checking if data is actually available for all sensors, especially serial sensors

#include <Wire.h>
#include <ITG3200.h>
#include <SPI.h>
#include <SD.h>
#include <ADXL362.h>
#include <OneWire.h>
#include <DallasTemperature.h>

#define magInstalled 1
#define gpsInstalled 1
#define pressureInstalled 1
#define ONE_WIRE_BUS 49
#define TEMPERATURE_PRECISION 9

const uint32_t magBaud = 19200;
const uint32_t gpsBaud = 57600;
const uint32_t pressBaud = 9600;
const uint8_t sdChipSelect = 53;
boolean printSerialOut = false;
boolean sdCardClosed = true;

char filename[80]={
  0};
File dataFile;
boolean logData=false;
unsigned long startTime;

// set up communication with sensors
USARTClass &magSerial = Serial1;
USARTClass &gpsSerial = Serial2;
USARTClass &pressureSerial = Serial3;

//Constructors
ITG3200 gyro = ITG3200(); //construct gyro object

ADXL362 accel; //construct accel object

OneWire oneWire(ONE_WIRE_BUS);

// Pass oneWire reference to Dallas Temperature. 
DallasTemperature sensors(&oneWire);

DeviceAddress tempDeviceAddress; // temperature sensor device address

//File dataFile;


char pressSN0[13] = "4F15-01-A213";
char pressSN1[13] = "R10F30-04-A1";
char pressSN2[13] = "R11L07-20-A5"; //not sure this serial number is correct
char pressSN3[13] = "R11L7-20-A51"; //not sure this serial number is correct

byte writeBuff[1028];
uint16_t writeBuffLoc=0;
const uint8_t nBytesPerSample = 31;

void setup() {
  char msgID[6]="?????";
  char *gpsStatus={
    "?"                            }
  ,*nsInd={
    "?"                            }
  ,*ewInd={
    "?"                            }
  ,*mode={
    "?"                            };
  int32_t gpsLat=0,gpsLong=0,gpsSpd=0,gpsCrs=0;
  uint32_t utcTime=0,date=0,CS={
    0                            };

  Serial.begin(19200); //begin serial communication for debugging
  Serial.println("Serial port initialized.");
  unsigned long now = millis();



  Serial.print("Data logging : ");
  if (logData)
  {
    Serial.println("on.");
  }
  else {
    Serial.println("off.");
  }
#if (magInstalled)
  Serial.println("Initializing magnetometer...");
  serialDeviceInit(Serial, magSerial, magBaud,"mag"); //initialize magnetometer on Serial1
#endif

#if(gpsInstalled)
  Serial.println("Initializing GPS...");
  serialDeviceInit(Serial, gpsSerial, gpsBaud,"gps"); //initialize gps on Serial2
  gpsSerial.setTimeout(50);
#endif

#if (pressureInstalled)
  Serial.println("Initializing pressure sensors...");
  serialDeviceInit(Serial, pressureSerial, pressBaud,"pre"); //initialize pressure sensors on Serial3
  pressureSerial.setTimeout(50);
#endif

  unsigned long time=millis();

#if (gpsInstalled)
  while (!gpsSerial.available()>0)
  {
    if (millis()>time+5000)
    {
      break;
    } 
  }
  readGPS(gpsSerial,msgID,utcTime,&gpsStatus, gpsLat,&nsInd,gpsLong,&ewInd,gpsSpd,gpsCrs,date,&mode,CS);
  Serial.println(filename);
  char str[20];
  sprintf(str,"%d",utcTime);
  strcpy(filename,str);
  strcat(filename,".txt");
  Serial.println(filename);
#else
  Serial.print("No GPS installed. Filename : ");
  char str[20];
  sprintf(str,"%d",rand()%10000000);
  strcpy(filename,str);
  strcat(filename,".txt");
  Serial.println(filename);
#endif

  //set up gyro
  Wire.begin(); //begin wire transmission
  delay(1000);
  gyro.init(ITG3200_ADDR_AD0_HIGH); //initialize gyro with address pulled high


  //set up accelerometer
  accel.begin();
  accel.beginMeasure();
  startTime = millis();

  // set up gps
#if (gpsInstalled)
  {
    while(gpsSerial.available()>0)
    {
      gpsSerial.read();
    }
  }
#endif

  //set up temp sensor
  sensors.begin();
  // Serial.println("Temperature sensor set up : ");

  if(sensors.getAddress(tempDeviceAddress, 0))
  {
    sensors.setResolution(tempDeviceAddress, TEMPERATURE_PRECISION);
  }
  else Serial.println("No temperature sensors found.");


}


void loop() {
  byte buff4[4];
  byte buff2[2];
  int16_t pressure[4]; //pressure sensor data
  int16_t temperature=0;
  int16_t magReading[3]; //magnetometer data
  int16_t gyroX, gyroY, gyroZ;
  int16_t accelX, accelY, accelZ, accelT;
  char msgID[6]="?????";
  char *gpsStatus={
    "?"                            }
  ,*nsInd={
    "?"                            }
  ,*ewInd={
    "?"                            }
  ,*mode={
    "?"                            };
  int32_t gpsLat=0,gpsLong=0,gpsSpd=0,gpsCrs=0;
  uint32_t utcTime=0,date=0,CS={
    0                            };
  if (Serial.available()>0)
  {
    parseInput();
  }
  //start timer
  unsigned long time = millis();
  int i=0;

  //read accel
  accel.readXYZTData(accelX,accelY,accelZ,accelT);
  //Serial.println(i++);

  //read gyro
  readGyroData(gyroX,gyroY,gyroZ);
  //Serial.println(i++);

  //read magnetometer
#if (magInstalled)
  readMagnetometer(magSerial,magReading);
#endif

  //read pressure transducers
#if (pressureInstalled)
  readAllPress (pressureSerial,pressSN0,pressSN1,pressSN2,pressSN3,pressure);
#endif
  //Serial.println(i++);

  //read GPS
#if (gpsInstalled)
  if (gpsSerial.available()>0 && true)
  {
    readGPS(gpsSerial,msgID,utcTime,&gpsStatus, gpsLat,&nsInd,gpsLong,&ewInd,gpsSpd,gpsCrs,date,&mode,CS);
  }
  //todo:it seems like you never actually output the GPS date. might be messing up your data structures.
#endif
  // Serial.println(i++);

  sensors.requestTemperatures(); // Send the command to get temperatures
  // Serial.println(i++);

  temperature = int16_t (100*sensors.getTempF(tempDeviceAddress));
  //Serial.println(i++);

  //temperature = sensors.getTempF(tempDeviceAddress);

  //format packet to be sent to SD card
  unsigned long tDiff = millis()-time;
  //write to SD card

  if (logData)
  {
    if (writeBuffLoc + nBytesPerSample > sizeof(writeBuff))
    {
      File dataFile = SD.open(filename,FILE_WRITE);
      dataFile.write(writeBuff,writeBuffLoc);
      Serial.println();
      Serial.println("Data buffer written to SD card.");
      Serial.println();
      dataFile.close();
      writeBuffLoc = 0;
    }
    parseToBinUInt32(writeBuff,time,writeBuffLoc);

    parseToBinInt16(writeBuff,accelX,writeBuffLoc);

    parseToBinInt16(writeBuff,accelY,writeBuffLoc);

    parseToBinInt16(writeBuff,accelZ,writeBuffLoc);

    parseToBinInt16(writeBuff,gyroX,writeBuffLoc);

    parseToBinInt16(writeBuff,gyroY,writeBuffLoc);

    parseToBinInt16(writeBuff,gyroZ,writeBuffLoc);

    parseToBinInt16(writeBuff,magReading[0],writeBuffLoc);

    parseToBinInt16(writeBuff,magReading[1],writeBuffLoc);

    parseToBinInt16(writeBuff,magReading[2],writeBuffLoc);

    parseToBinInt16(writeBuff,pressure[0],writeBuffLoc);

    parseToBinInt16(writeBuff,pressure[1],writeBuffLoc);

    for (int i=0;i<5;i++)
    {
      writeBuff[writeBuffLoc++] = byte (msgID[i]);
    }
    parseToBinUInt32(writeBuff,utcTime,writeBuffLoc);

    writeBuff[writeBuffLoc++] = (byte) gpsStatus[0];

    parseToBinInt32(writeBuff,gpsLat,writeBuffLoc);

    writeBuff[writeBuffLoc++] = (byte) *nsInd;

    parseToBinInt32(writeBuff,gpsLong,writeBuffLoc);

    writeBuff[writeBuffLoc++] = (byte) *ewInd;

    parseToBinInt32(writeBuff,gpsSpd,writeBuffLoc);

    parseToBinInt32(writeBuff,gpsCrs,writeBuffLoc);

    parseToBinUInt32(writeBuff,date,writeBuffLoc);

    writeBuff[writeBuffLoc++] = (byte) *mode;

    parseToBinUInt32(writeBuff,CS,writeBuffLoc);

    parseToBinInt16(writeBuff,temperature,writeBuffLoc);

    parseToBinUInt32(writeBuff,tDiff,writeBuffLoc);
  }
  else if(writeBuffLoc != 0) //we're not logging data, but theres data in the buffer. write it out to SD
  {
    dataFile = SD.open(filename,FILE_WRITE);
    int bytesWritten = dataFile.write(writeBuff,writeBuffLoc);
    Serial.println();
    if (bytesWritten>0)
    {
      Serial.println("Data buffer written to SD card.");
    }
    else
    {
      Serial.println("Data NOT written to SD card.");
    }
    Serial.println();
    dataFile.close();
    writeBuffLoc = 0;
  }
  if (printSerialOut)
  {
    Serial.print(time);
    Serial.print('\t');
    Serial.print(accelX);
    Serial.print('\t');
    Serial.print(accelY);
    Serial.print('\t');
    Serial.print(accelZ);
    Serial.print('\t');
    Serial.print(gyroX);
    Serial.print('\t');
    Serial.print(gyroY);
    Serial.print('\t');
    Serial.print(gyroZ);
    Serial.print('\t');
    Serial.print(magReading[0]);
    Serial.print('\t');
    Serial.print(magReading[1]);
    Serial.print('\t');
    Serial.print(magReading[2]);
    Serial.print('\t');
    Serial.print(pressure[0]);
    Serial.print('\t');
    Serial.print(pressure[1]);
    Serial.print('\t');
    Serial.print(msgID);
    Serial.print('\t');
    Serial.print(utcTime);
    Serial.print('\t');
    Serial.print(gpsStatus);
    Serial.print('\t');
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
    Serial.print(temperature);
    Serial.print('\t');
    Serial.println(tDiff);
  }
}
void readMagnetometer(USARTClass &magSerial,int16_t *magReading)
{
  magSerial.print("*99P\r");
  if (magSerial.available()>0)
  {
    byte buff[6];
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
  pressure[0] = readUniquePress(pressureSerial,add1);
  pressure[1] = readUniquePress(pressureSerial,add2);
  //pressure[2] = readUniquePress(pressureSerial,add2);
  //pressure[3] = readUniquePress(pressureSerial,add3);
}

int16_t readUniquePress(USARTClass &pressureSerial,char address[])
{
  char bytesIn[80]={
    0x00                            };
  char readComm[80]={
    0x00                            };

  int nchars;
  strcat(readComm,"U");
  strcat(readComm,address);
  strcat(readComm,"RC\r");
  pressureSerial.print(readComm); //issue "read captured pressure" command to device 1
  nchars = pressureSerial.readBytesUntil('=',bytesIn,80);
  nchars = pressureSerial.readBytesUntil(0x20,bytesIn,20);
  int16_t pressure = int16_t (strtol(bytesIn,NULL,16));
  return pressure;
}

void readGPS(USARTClass &gpsSerial,char *msgID,uint32_t &utcTime,char **gpsStatus, int32_t &gpsLat,char **nsInd,int32_t &gpsLong,char **ewInd,int32_t &gpsSpd,int32_t &gpsCrs,uint32_t &date,char **mode,uint32_t &CS)
{
  char bytesIn[200] = {
    0                            };
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
      //Serial.println(pt);
      for (int j=0;j<5;j++)
      {
        msgID[j] = (char )pt[j];
      }


      int i=0;
      while (pt = strsep( &s1,",*"))
      {
        //Serial.println(pt);
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
//todo:check if this is right. might have a problem
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
            //     Serial.print("got here : ");
            //Serial.println(*mode);
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
    while (deviceSerial.available()>0)
    {
      deviceSerial.read(); 
    }
    mainSerial.print(ID);
    mainSerial.println(" serial port initiliazed.");
  }
  else{
    mainSerial.print("ERROR : ");
    mainSerial.print(ID);
    mainSerial.println(" serial port not responding.");
  }
}


void initSDCard(UARTClass &serial,uint8_t sdCardChipSelect)
{
  unsigned long time = millis();
  while (millis() < time+10000)
  {
    boolean didWork = SD.begin(sdCardChipSelect);
    if (didWork)
    {
      sdCardClosed = false;
      break; 
    }    
  }
  if (sdCardClosed)
  {
    serial.println("ERROR : SD Card not responding.");
  }
  else
  {
    Serial.println("SD card initialized."); 
  }
}

void parseToBinInt16(byte buff[],int16_t var,uint16_t &loc)
{
  int i=0;
  for (i;i<2;i++)
  {
    buff[i+loc] = byte (var >> (8*i));
  }
  loc=loc+i;
}

void parseToBinInt32(byte buff[],int32_t var,uint16_t &loc)
{
  int i=0;
  for (i;i<4;i++)
  {
    buff[i+loc] = byte (var >> (8*i));
  }
  loc=loc+i;
}

void parseToBinUInt32(byte buff[],uint32_t var,uint16_t &loc)
{
  int i=0;
  for (i;i<4;i++)
  {
    buff[i+loc] = byte (var >> (8*i));
  }
  loc=loc+i;
}


void parseInput()
{
  char comm[80] = {
    0                };
  if (Serial.read() == '#')
  {
    int i = 0;
    while(Serial.available()>0)
    {
      comm[i++] = Serial.read();

      if (comm[i-1] == '&')
      {
        break;  
      }
    }
    if (!strcmp(comm,"dataOn&"))
    {
      if (!sdCardClosed)
      {      
        logData = true;
        Serial.println("Data logging : on.");
      }
      else
      {
        Serial.println("Please initialize SD card first.");
      }
    }
    else if (!strcmp(comm, "dataOff&"))
    {
      logData = false;
      Serial.println("Data logging : off.");
    }
    else if (!strcmp(comm,"serialOn&"))
    {
      printSerialOut = true;
    }
    else if (!strcmp(comm,"serialOff&"))
    {
      printSerialOut = false;
    }
    else if (!strcmp(comm,"initSD&"))
    {
      // initialize SD card
      Serial.println("Initializing SD Card...");
      initSDCard(Serial,sdChipSelect);
    }
    else if (!strcmp(comm,"?&"))
    {
      Serial.println("Help menu");
      Serial.println("List of commands : ");
      Serial.println("dataOn :\tturn on data logging to SD card.");
      Serial.println("dataOff :\tturn off data logging to SD card.");
      Serial.println("initSD :\tinitialize SD card.");
      Serial.println("serialOn :\tturn on serial output.");
      Serial.println("serialOff :\tturn off serial output.");
      Serial.println("? :\t help menu.");
    }
  }
  else
  {
    Serial.print("Improprer serial command. Flushing data...  ");
    while (Serial.available()>0)
    {
      Serial.read();
    }
    Serial.println("Serial data flushed.");
  }
}








