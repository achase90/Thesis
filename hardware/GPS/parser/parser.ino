uint16_t multFact = 10000;
void setup() {
  Serial.begin(9600);
  Serial2.begin(9600);
}

void loop() {

  if (Serial2.available()>0)
  {
    char bytesIn[64] = {0x00};
    char msgID[5] = {0x00};
    char utcTime[9] = {0x00};
    char gpsStatus[1] = {0x00};
    char lat[9] = {0x00};
    char nsInd[1] = {0x00};
    char gpsLong[10] = {0x00};
    char ewInd[1] = {0x00};
    char spd[10] = {0x00};
    char cog[10] = {0x00};
    char date[6] = {0x00};
    char mode[1] = {0x00};
    char CS[3] = {0x00}
    ;

    int nchars;
    nchars = Serial2.readBytesUntil('$',bytesIn,64); //read until beginning of GPS string
    nchars = Serial2.readBytesUntil(',',msgID,64);
    Serial.write((byte *)msgID,nchars);
    Serial.print('\t');
    nchars = Serial2.readBytesUntil(',',utcTime,64);
    Serial.print(int32_t (1000*atof(utcTime)));
    Serial.print('\t');
    nchars = Serial2.readBytesUntil(',',gpsStatus,64);
    Serial.write((byte *)gpsStatus,nchars);
    Serial.print('\t');
    nchars = Serial2.readBytesUntil(',',lat,64);
    Serial.print(int32_t (100000*atof(lat)));
    Serial.print('\t');
    nchars = Serial2.readBytesUntil(',',nsInd,64);
    Serial.write((byte *)nsInd,nchars);
    Serial.print('\t');
    nchars = Serial2.readBytesUntil(',',gpsLong,64);
    Serial.print(int32_t (100000*atof(gpsLong)));
    Serial.print('\t');
    nchars = Serial2.readBytesUntil(',',ewInd,64);
    Serial.write((byte *)ewInd,nchars);
    Serial.print('\t');
    nchars = Serial2.readBytesUntil(',',spd,64);
    Serial.print(int32_t (100000*atof(spd)));
    Serial.print('\t');
    nchars = Serial2.readBytesUntil(',',cog,64);
    Serial.print(int32_t (100000*atof(cog)));
    Serial.print('\t');
    nchars = Serial2.readBytesUntil(',',date,64);
    Serial.print(int32_t (atoi(date)));
    Serial.print('\t');
    nchars = Serial2.readBytesUntil(',',bytesIn,64);
    nchars = Serial2.readBytesUntil(',',bytesIn,64);
    nchars = Serial2.readBytesUntil('*',mode,64);
    Serial.write((byte *)mode,nchars);
    Serial.print('\t');
    nchars = Serial2.readBytesUntil('\r',CS,64);
    Serial.println(int32_t (atoi(CS)));

    Serial2.read(); //remove line feed character

    //Serial.println(nchars);
    //Serial.write((byte*) comm,nchars);

    //int32_t tempOutInt = 100000*atof(temp);
    //Serial.println(tempOutInt);

  }
}












