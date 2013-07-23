byte comm[60];

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  while (!Serial);
  Serial.println("Serial port opened");

  Serial1.begin(9600);
  delay(1000);
  Serial.println("Serial1 open");
  //Serial1.print('*99C\r');
  // Serial.println();
  Serial.println();
  /*
  comm[0]=0x2a;
   comm[1]=0x39;
   comm[2]=0x39;
   comm[3] = 0x57;
   comm[4]=0x45;
   comm[5]=0x0d;
   Serial1.write(comm,6);
   Serial.write(comm,6);
   
   comm[0]=0x2a;
   comm[1]=0x39;
   comm[2]=0x39;
   comm[3] = 0x42;
   comm[4]=0x0d;
   Serial1.write(comm,5);
   Serial.write(comm,5);
   */
   /*
  comm[0]=0x2a;
  comm[1]= 0x39;
  comm[2]=0x39;
  comm[3]=0x43;
  comm[4]=0x0D;
  Serial1.write(comm,5);
  */
  //Serial.write(comm,6);

  //Serial1.println("*99C");
  //Serial1.print('*99C');
  //Serial1.print(comm[4]);

}

void loop() {
  comm[0]=0x2a;
   comm[1]= 0x39;
   comm[2]=0x39;
   comm[3]=0x50;
   comm[4]=0x0D;
   Serial1.write(comm,5);
  // delay(250);

  if (Serial1.available()>0)
  {
    byte buff[70];
    Serial.println();
    for (int i=0;i<7;i++)
    {
      buff[i]=Serial1.read(); 
      //Serial.print(buff[i],BIN);
      //Serial.print('\t');
    }
    int16_t val1= buff[1]  + (buff[0] << 8);
    int16_t val2 = buff[3] + (buff[2] << 8);
    int16_t val3 = buff[5] + (buff[4]  << 8);
    Serial.print('\t');

    Serial.print(val1);
    Serial.print('\t');
    Serial.print(val2);
    Serial.print('\t');
    Serial.print(val3);
    Serial.print('\t');
    Serial.println();
    
  }
}











