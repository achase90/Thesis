void setup() {
  Serial.begin(9600);
  Serial3.begin(19200);
  Serial.println("Serial ports open");
}

void loop() {
  char bytesIn[100]={0x00};
    char trash[100]={0x00};
  int nchars;
  int16_t pressure;
  //Serial3.print("RS\r");
 Serial3.print("WC\r");

//Pressure 1
  Serial3.print("UR11L07-20-A5RH\r"); //press 2
  nchars = Serial3.readBytesUntil('=',trash,80);
  nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
  pressure = (int16_t)strtol(bytesIn,NULL,16);
  Serial.print(pressure);
  Serial.print('\t');
    /*nchars = Serial3.readBytesUntil('\r',trash,80);
    Serial.println(trash);
    */
    
//Pressure 2
bytesIn = {0x00};
pressure = 0;
trash = {0x00};

  Serial3.print("UR11L07-20-A4RH\r"); //press 1
  nchars = Serial3.readBytesUntil('=',trash,80);
  nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
  pressure = (int16_t)strtol(bytesIn,NULL,16);
  Serial.print(pressure);
  Serial.print('\t');
    /*nchars = Serial3.readBytesUntil('\r',trash,80);
    Serial.println(trash);
    */
    
    //Pressure 4 - BARO
bytesIn = {0x00};
pressure = 0;
trash = {0x00};

  Serial3.print("U4F15-01-A213RH\r"); //press 1
  nchars = Serial3.readBytesUntil('=',trash,80);
  nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
  pressure = (int16_t)strtol(bytesIn,NULL,16);
  Serial.print(pressure);
    Serial.print('\t');

   /* nchars = Serial3.readBytesUntil('\r',trash,80);
    Serial.println(trash);
Serial.println();
Serial.println();*/

//Pressure 3
bytesIn = {0x00};
pressure = 0;
trash = {0x00};

  Serial3.print("UR10F30-04-A1RH\r"); //press 1
  nchars = Serial3.readBytesUntil('=',trash,80);
  nchars = Serial3.readBytesUntil(0x20,bytesIn,20);
  pressure = (int16_t)strtol(bytesIn,NULL,16);
  Serial.println(pressure);
    /*  nchars = Serial3.readBytesUntil('\r',trash,80);
    Serial.println(trash);*/
}



