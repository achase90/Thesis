/*
  SD card datalogger
 
 This example shows how to log data from three analog sensors 
 to an SD card using the SD library.
 	
 The circuit:
 * analog sensors on analog ins 0, 1, and 2
 * SD card attached to SPI bus as follows:
 ** MOSI - pin 11
 ** MISO - pin 12
 ** CLK - pin 13
 ** CS - pin 4
 
 this is an edit
 created  24 Nov 2010
 modified 9 Apr 2012
 by Tom Igoe
 
 This example code is in the public domain.
 	 
 */

#include <SPI.h>
#include <SD.h>

// On the Ethernet Shield, CS is pin 4. Note that even if it's not
// used as the CS pin, the hardware CS pin (10 on most Arduino boards,
// 53 on the Mega) must be left as an output or the SD library
// functions will not work.

const int chipSelect = 51;
boolean saveData = false;
int nBytesIn = 4;

char command[4];

unsigned long max_serial_wait_time = 500;
unsigned long starttime;
unsigned int maxSerialWaitTime = 500;


void setup()
{
  // Open serial communications and wait for port to open:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

  Serial.print("Initializing SD card...");
  // make sure that the default chip select pin is set to
  // output, even if you don't use it:
  pinMode(52, OUTPUT);
  // see if the card is present and can be initialized:
  if (!SD.begin(chipSelect)) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    return;
  }
  Serial.println("Card initialized.");
  SD.remove("datalog.txt");
  Serial.println("Waiting for a command...");
}

void loop()
{

  if (Serial.available())
  {    
    char *oldCommand = command;
    unsigned long startTime = millis();
    int diff = 0;
    while (Serial.available() < nBytesIn && diff < maxSerialWaitTime)
    {
      diff = millis() - startTime;
    }
    if (Serial.available() < nBytesIn)
    {
      Serial.println("Did not receive 4 bytes of data.");
      Serial.println("Flushing Serial data and re-setting command.");
      Serial.flush();
      char * command = oldCommand;
      Serial.println("Waiting for a command...");
    }

    for (int i = 0; i<nBytesIn;i++)
    {
      command[i] = Serial.read();
    }
  }

  if (!strcmp(command,"strt"))
  {
    //Serial.println("This worked");
    saveData = true;
  }

  else if (!strcmp(command,"stop"))
  {
    saveData  = false;
  }

  else if (!strcmp(command,"rmfl"))
  {
    SD.remove("datalog.txt");
  }

  // make a string for assembling the data to log:
  int x=3;

  long y = 5555;

  unsigned long z = 65165515;

  // open the file. note that only one file can be open at a time,
  // so you have to close this one before opening another.

  File dataFile = SD.open("datalog.txt", FILE_WRITE);

  // if the file is available, write to it:
  if (dataFile && saveData) {
    byte buf[20]={0};
    
    buf[0]= byte( x);
    buf[1] = byte(x  >> 8);
    buf[2] = byte(x  >> 8);
    buf[3] = byte(x  >> 8);
    buf[4] = byte(y);
    buf[5] = byte( y >> 8);
    buf[6] = byte ( y >> 16);
    buf[7] = byte (y >> 24);
    buf[8] = byte (z);
    buf[9] = byte (z >> 8);
    buf[10] = byte (z >> 16);
    buf[11] = byte (z >> 24);

    dataFile.write(buf,12);
    // print to the serial port too:3
    Serial.println("Printing Data.");
  }  
  if (dataFile)
  {
    dataFile.close();
  }
  // if the file isn't open, pop up an error:
  else if (saveData)//if saveData is true but the last if didn't trigger then the file couldn't be opened
  {
    Serial.println("error opening datalog.txt");
  }
  delay(5);
}















