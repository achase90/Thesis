void setup() {
  Serial.begin(9600);
  Serial3.begin(9600);
  Serial.println("Serial ports open");
}

void loop() {
  byte x;
  byte comm[20];
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

  // put your main code here, to run repeatedly: 
  if (Serial3.available()>0)
  {
    while (Serial3.available()>0)
    {
      x=Serial3.read();
      Serial.write(x);
    }
    Serial.println();
  }

  delay(20);
}


