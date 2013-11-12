


void setup() {
	Serial.begin(19200);
	Serial2.begin(57600);
	Serial2.flush();
	while(Serial2.available())
		Serial2.read();
	Serial2.setTimeout(200);
	}

void loop() {
	char bytesIn[100] = {0x00};
	int csCalc;
	int csSentHex;
	if (Serial2.available()>0)
		{
		//Serial.println("Was available");
		unsigned long now = millis();
		unsigned long timeOut = 10;
		int i=0;
		while(true)
			{
			if (Serial2.available()>0)
				{
				bytesIn[i] = Serial2.read();
				if (bytesIn[i] == '\n')
					break;
				if (millis()-now>timeOut)
					break;
				if (bytesIn[i] != '$') //overwrite the $ character
				i++;
				}
			}
		Serial.write(bytesIn);
		Serial.println();
		csCalc =  getCheckSum(bytesIn);
		int j=i-3;
		char csSent[3] = {0};
		for (int k=0;k<2;k++)
			{
			csSent[k] = bytesIn[j++];
			}
		csSentHex = strtol(csSent,NULL,HEX);
		}
	if (csSentHex == csCalc)
		{
		char msgID[6]={"?"};
		uint32_t utcTime,date,CS=0;
		int32_t gpsLat,gpsLong,gpsSpd,gpsCrs = 0;
		char gpsStatus,nsInd,ewInd,mode = {'?'};

		//process gps string
		char *s1=bytesIn,*pt;
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
					if (gpsStatus == 0)
						gpsStatus = '?';
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
					if (nsInd == 0)
						nsInd = '?';
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
					if (ewInd == 0)
						ewInd = '?';
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
					//Serial.print('\t'); 
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
		else
			{
			while(Serial2.available()>0)
				Serial2.read();
			}
	}

// Calculates the checksum for a given string returns as integer
int getCheckSum(char *string) {
	int i;
	int XOR;
	int c;
	// Calculate checksum ignoring any $'s in the string
	for (XOR = 0, i = 0; i < strlen(string); i++) {
		c = (unsigned char)string[i];
		if (c == '*') break;
		if (c != '$') XOR ^= c;
		}
	return XOR;
	}