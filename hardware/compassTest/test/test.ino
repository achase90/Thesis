void setup() {
Serial1.begin(9600);
Serial.begin(9600);
Serial.println("Serial open");
}

void loop() {
  // put your main code here, to run repeatedly: 
  Serial1.write((byte) 10000001);
delay(256);
}
