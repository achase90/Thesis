void setup() {
  Serial.begin(9600);
  Serial3.begin(9600);
  Serial.println("Serial ports open");
}

void loop() {
  byte x;
  byte comm[3];
  char bytesIn[10];
  int nchars;
  int16_t pressure;
  /*comm[0] = 0x57;
   comm[1] = 0x43;
   comm[2] = 0x0d;
   Serial3.write(comm,3);
   delay(10);
   */
  comm[0] = 0x52;
  comm[1] = 0x48;
  comm[2] = 0x0d;

  Serial3.write(comm,3);
  delay(10);

  // put your main code here, to run repeatedly: 
  if (Serial3.available()>0)
  {
    nchars = Serial3.readBytesUntil('=',bytesIn,10);
    nchars = Serial3.readBytesUntil(0x20,bytesIn,10);
    pressure = (int16_t)strtol(bytesIn,NULL,16);
    Serial.println(pressure);
  }
}




