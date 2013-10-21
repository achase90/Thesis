void setup() {
  Serial.begin(9600);
  Serial.println("Serial port opened");

  Serial1.begin(1920001);
  Serial.println("Serial1 open");
  Serial.println();
}

void loop() {
  Serial1.print("*99P\r");
  if (Serial1.available()>0)
  {
    byte buff[70];
    Serial.println();
    for (int i=0;i<7;i++)
    {
      buff[i]=Serial1.read(); 
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
    Serial.println();
  }
}
