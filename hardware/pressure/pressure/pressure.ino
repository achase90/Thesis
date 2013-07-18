void setup() {
Serial.begin(9600);
Serial2.begin(9600);
Serial.println("Serial ports open");
}

void loop() {
char x;
int nchars;
  // put your main code here, to run repeatedly: 
  Serial2.print('RH\r');
  if (Serial2.available()>0)
  {
    while (Serial2.available()>0)
    {
 x=Serial2.read();
 Serial.println(x,HEX);

}
  }

  delay(10);
}
