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

  Serial3.print("U4F15-01-A213RC\r");
  nchars = Serial3.readBytesUntil('=',bytesIn,80);
  nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
  pressure = (int16_t)strtol(bytesIn,NULL,16);
  Serial.print(pressure);
  Serial.print('\t');

  Serial3.print("UR10F30-04-A1RC\r");
  nchars = Serial3.readBytesUntil('=',bytesIn,80);
  nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
  pressure = (int16_t)strtol(bytesIn,NULL,16);
  Serial.println(pressure);
}






