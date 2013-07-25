void setup() {
  Serial.begin(9600);
  Serial2.begin(9600);
}

void loop() {
  /*if (Serial2.available()>0)
   {
   char comm[128];
   int nchars;
   comm[1]  = Serial2.read();
   if (comm[1] == '$')
   {
   nchars = Serial2.readBytesUntil('$',comm,64);
   Serial.println(nchars);
   Serial.write((byte*) comm,nchars);
   Serial.println();
   
   }
   // put your main code here, to run repeatedly: 
   }
   */
  char temp[6];
  temp[0] = '1';
  temp[1] = '2';
  temp[2] = '3';
  temp[3] = '.';
  temp[4] = '4';
  temp [5] = '5';
int time = micros();
/* convert string float to fixed point without float (SLOWER THAN USING ATOF)
  int i=0;
  int sizeOfTemp = sizeof(temp)/sizeof(char);

  int decLoc;
  while (i < sizeOfTemp)
  {
    if (temp[i] == 0x2e)
    {
      decLoc = i;
      break;
    }
    i++;  
  }

  char tempOut[20] = {0x00};
  for (int i=0;i<sizeOfTemp-1; i++)
  {
    if (i >=decLoc)
    {
      tempOut[i] = temp[i+1];
    }
    else
      tempOut[i] = temp[i];
  }
  int32_t tempOutInt = pow(10,8-(sizeOfTemp-decLoc))*atoi(tempOut);
  */
  int32_t tempOutInt = 100000*atof(temp);
  //Serial.println(tempOutInt);
  Serial.println(micros()-time);
}







