


void setup() {
  Serial.begin(9600);
  Serial3.begin(57600);
  Serial3.flush();
  Serial3.setTimeout(200);
}

void loop() {
  char bytesIn[80] = {
    0x00    };
  int nchars;
  if (Serial3.available()>0)
  {
    if (Serial3.read() == '$')
    {
      char msgID[6]={0x00};
      uint32_t utcTime;
      char gpsStatus;
      int32_t gpsLat;
      char nsInd;
      int32_t gpsLong;
      char ewInd;
      int32_t gpsSpd;
      int32_t gpsCrs;
      uint32_t date;
      char mode;
      uint32_t CS;

      nchars = Serial3.readBytesUntil(0x0a,bytesIn,128);
      //process gps string
      char *s1=bytesIn;
      char *pt;
      pt = strsep(&s1,",*");
      for (int j=0;j<5;j++)
      {
        msgID[j] = pt[j];
      }
      //Serial.print(msgID);
      //Serial.print('\t'); 
      int i=0;
      while (pt = strsep( &s1,",*"))
      {
        //delay(5);
        // Serial.println(i);
        switch (i++)
        {
        case 0:
          {
            utcTime = 100*atof(pt);
            // Serial.print(utcTime);
            //Serial.print(pt);
            // Serial.print('\t');
            break;
          }
        case 1:
          {
            // Serial.print(pt);
            //Serial.print('\t'); 
            gpsStatus = *pt;
            break;
          }
        case 2:
          {                    
            //Serial.print(pt);
            //Serial.print('\t'); 
            gpsLat = 100000*atof(pt);
            break;
          }
        case 3:
          {                    
            //Serial.print(pt);
            //Serial.print('\t'); 
            nsInd = *pt;
            break;
          }
        case 4:
          {                    
            //Serial.print(pt);
            //Serial.print('\t'); 
            gpsLong = 100000*atof(pt);
            break;
          }
        case 5:
          {                    
            //Serial.print(pt);
            // Serial.print('\t'); 
            ewInd = *pt;
            break;
          }
        case 6:
          {                    
            // Serial.print(pt);
            // Serial.print('\t'); 
            gpsSpd = 1000*atof(pt);
            break;
          }
        case 7:
          {                    
            // Serial.print(pt);
            // Serial.print('\t'); 
            gpsCrs = 1000*atof(pt);
            break;
          }
        case 8:
          {                    
            // Serial.print(pt);
            // Serial.print('\t'); 
            date = atoi(pt);
            break;
          }
        case 9:
          {                    
            // Serial.print(pt);
            // Serial.print('\t'); 
            //magnetic variation, not available
            break;
          }
        case 10:
          {                    
            // Serial.print(pt);
            // Serial.print('\t'); 
            //magnetic variation indicator, not available
            break;
          }
        case 11:
          {                    
            // Serial.print(pt);
            // Serial.print('\t'); 
            mode = *pt;
            break;
          }
        case 12:
          {                    
            // Serial.print(pt);
            // Serial.print('\t'); 
            CS = atoi(pt);
            break;
          }
        }
        //Serial.print(pt);
        // Serial.print('\t'); 

        // pt = strsep(NULL,",*");
        //      Serial.write((byte *) bytesIn,nchars);
      }
      if (true)
      {
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

        Serial.println(CS);
      }
    }


    // if the character that was read then flush the rest of the data
    else
    {
      while (Serial3.available()>0)
      {
        Serial3.read(); 
      }
    }
  }
}

