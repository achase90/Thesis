void setup() {
  Serial.begin(9600);
  Serial3.begin(9600);
  Serial.println("Serial ports open");
}

void loop() {
  byte x;
  char comm[20];
  //  char bytesIn[20]={0x00};
  char bytesIn[80]={
    0x00  };

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
  Serial3.print("WC\r");
  //Serial3.write((byte *) '\r',1);
  delay(50);
     Serial3.print("U4F15-01-A213RC\r");
    nchars = Serial3.readBytesUntil('=',bytesIn,80);
    nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
    //Serial.write((byte *) bytesIn,nchars);
    //Serial.print('\t');
    pressure = (int16_t)strtol(bytesIn,NULL,16);
    Serial.print(pressure);
    Serial.print('\t');
    Serial3.print("UR10F30-04-A1RC\r");
    delay(10);
    nchars = Serial3.readBytesUntil('=',bytesIn,80);
    nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
    // Serial.write((byte *) bytesIn,nchars);
    // Serial.println();
    pressure = (int16_t)strtol(bytesIn,NULL,16);
    Serial.println(pressure);
    //nchars = Serial3.readBytesUntil('\r',bytesIn,20);
    /*Serial.write(bytesIn);
     Serial.println();*/
}





