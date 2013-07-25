void setup() {
  Serial.begin(9600);
  Serial3.begin(9600);
  Serial.println("Serial ports open");
}

void loop() {
  byte x;
  char comm[20];
//  char bytesIn[20]={0x00};
  char bytesIn[50]={0x00};

  int nchars;
  int16_t pressure;
  /*comm[0] = 0x57;
   comm[1] = 0x43;
   comm[2] = 0x0d;
   Serial3.write(comm,3);
   delay(10);
   */
  /*comm[0] = 0x52;
  comm[1] = 0x53;
  comm[2] = 0x0d;
*/
  //Serial3.write((byte *)comm,3);
  comm[0] = 0x55;
  comm[1] = 0x34;
  comm[2] = 0x46;
  comm[3] = 0x31;
  comm[4] = 0x35;
  comm[5] = 0x2d;
  comm[6] = 0x30;
  comm[7] = 0x31;
  comm[8] = 0x2d;
  comm[9] = 0x41;
  comm[10] = 0x32;
  comm[11] = 0x31;
  comm[12] = 0x33;
  comm[13] = 0x52;
  comm[14] = 0x48;
  comm[15] = 0x0d;
  //char comm[] = {"U4F15-01-A213RH"};
  //Serial3.write((byte*)comm,16);
  Serial3.println("U4F15-01-A213RH");
  //Serial3.write((byte *) '\r',1);
  delay(50);

  // put your main code here, to run repeatedly: 
  if (Serial3.available()>0)
  {
    /*
    int i=0;
    while (Serial3.available()>0)
    {
      bytesIn[i] = Serial3.read();
      i++;
      //delay(5);
    }*/
        //Serial.write((byte *)bytesIn,nchars);
    nchars = Serial3.readBytesUntil('=',bytesIn,20);
    nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
    pressure = (int16_t)strtol(bytesIn,NULL,16);
    Serial.println(pressure);
        nchars = Serial3.readBytesUntil('\r',bytesIn,20);
  //Serial.write(bytesIn);
  //Serial.println();
}
  delay(500);
}




