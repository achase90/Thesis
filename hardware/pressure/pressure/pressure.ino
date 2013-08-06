void setup() {
  Serial.begin(9600);
  Serial3.begin(19200);
  Serial.println("Serial ports open");
}

void loop() {
  char bytesIn[80]={0x00}; 
  int nchars;
  int16_t pressure;
  
  Serial3.print("WC\r");
//Serial3.print("RC\r");
Serial3.print("UR11L07-20-A5RC\r"); //press 2
  nchars = Serial3.readBytesUntil('=',bytesIn,80);
  nchars = Serial3.readBytesUntil(0x0d,bytesIn,20);
  pressure = (int16_t)strtol(bytesIn,NULL,16);
  Serial.println(pressure);
  //Serial.write((byte*) bytesIn,nchars);
 /*Serial.print('\t');

  Serial3.print("UR11L07-20-A5RC\r"); //press 1
  nchars = Serial3.readBytesUntil('=',bytesIn,80);
  nchars = Serial3.readBytesUntil(0x0d,bytesIn,20);
  pressure = (int16_t)strtol(bytesIn,NULL,16);
  Serial.println(pressure);
//Serial.write((byte*) bytesIn,nchars);*/
}



