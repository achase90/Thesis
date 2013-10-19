void setup() {
  Serial.begin(9600);
  Serial3.begin(9600);
  Serial.println("Serial ports open");
}

void loop() {
  char bytesIn[80] = {
    0x00
  };
  int nchars;
  char trash[80] = {0x00};
  int16_t pressure;
  
  Serial3.print("WC\r");

  
  Serial3.print("U4F15-01-A213RC\r");
  nchars = Serial3.readBytesUntil('=',trash,80);
  nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
  pressure = (int16_t)strtol(bytesIn,NULL,16);
  Serial.print(pressure);
  Serial.print('\t');

  Serial3.print("UR11L07-20-A4RC\r");
  nchars = Serial3.readBytesUntil('=',trash,80);
  nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
  pressure = (int16_t)strtol(bytesIn,NULL,16);
  Serial.print(pressure);
  Serial.print('\t');

  Serial3.print("U4F15-01-A213RC\r");
  nchars = Serial3.readBytesUntil('=',trash,80);
  nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
  pressure = (int16_t)strtol(bytesIn,NULL,16);
  Serial.print(pressure);
  Serial.print('\t');


  Serial3.print("UR11L07-20-A5RC\r");
  nchars = Serial3.readBytesUntil('=',trash,80);
   nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
   pressure = (int16_t)strtol(bytesIn,NULL,16);
   Serial.print(pressure);
   /*
  if (Serial3.available() > 0)
  {
    int i = 0;
    while (Serial3.available() > 0)
    {
      bytesIn[i++] = Serial3.read();
    }
    Serial.println(bytesIn);
  }*/
  Serial.println();
}



