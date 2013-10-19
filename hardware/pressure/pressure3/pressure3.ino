void setup() {
  Serial.begin(9600);
  Serial3.begin(9600);
  Serial.println("Serial ports open");
  pinMode(15,INPUT);
  digitalWrite(15,LOW);
}

void loop() {
  char bytesIn[80] = {
    0x00
  };
  int nchars;
  char trash[80] = {0x00};
  int16_t pressure;
    /*

  Serial3.print("RH\r");

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

*/
  Serial3.print("UR11L07-20-A5RH\r");
  /*
  nchars = Serial3.readBytesUntil('=',trash,80);
   nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
   pressure = (int16_t)strtol(bytesIn,NULL,16);
   Serial.print(pressure);
   */
   delay(1000);
      Serial.print("#1 Serial3 available = ");
   Serial.println(Serial3.available());
  if (Serial3.available() > 0)
  {
    Serial.println("Data was available #1");
    int i = 0;
    while (Serial3.available() > 0)
    {
      bytesIn[i++] = Serial3.read();
      delay(1);
    }
    Serial.println(bytesIn);
  }
delay(1000);
bytesIn = {0x00};
  Serial3.print("UR11L07-20-A4RH\r");
  /*
  nchars = Serial3.readBytesUntil('=',trash,80);
   nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
   pressure = (int16_t)strtol(bytesIn,NULL,16);
   Serial.print(pressure);
   */
   delay(1000);
   Serial.print("#2 Serial3 available = ");
   Serial.println(Serial3.available());
  if (Serial3.available() > 0)
  {
        Serial.println("Data was available #2");
    int i = 0;
    while (Serial3.available() > 0)
    {
      bytesIn[i++] = Serial3.read();
      delay(1);
    }
    Serial.println(bytesIn);
  }
  
  bytesIn = {0x00};
  Serial3.print("UR10F30-04-A1RH\r");
  /*
  nchars = Serial3.readBytesUntil('=',trash,80);
   nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
   pressure = (int16_t)strtol(bytesIn,NULL,16);
   Serial.print(pressure);
   */
   delay(1000);
      Serial.print("#3 Serial3 available = ");
   Serial.println(Serial3.available());
  if (Serial3.available() > 0)
  {
        Serial.println("Data was available #3");
    int i = 0;
    while (Serial3.available() > 0)
    {
      bytesIn[i++] = Serial3.read();
      delay(1);
    }
    Serial.println(bytesIn);
  }
  
  
    bytesIn = {0x00};
  Serial3.print("U4F15-01-A213RH\r");
  /*
  nchars = Serial3.readBytesUntil('=',trash,80);
   nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
   pressure = (int16_t)strtol(bytesIn,NULL,16);
   Serial.print(pressure);
   */
   delay(1000);
      Serial.print("#4 Serial3 available = ");
   Serial.println(Serial3.available());
  if (Serial3.available() > 0)
  {
        Serial.println("Data was available #4");
    int i = 0;
    while (Serial3.available() > 0)
    {
      bytesIn[i++] = Serial3.read();
      delay(1);
    }
    Serial.println(bytesIn);
  }
  //Serial.println();
}



