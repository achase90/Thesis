void setup() {
  Serial.begin(9600);
  Serial2.begin(9600);
}

void loop() {
  if (Serial2.available()>0)
  {
  char comm[128];
  int nchars;
  comm[1]  = Serial2.read();
  if (comm[1] == '$')
  {
    nchars = Serial2.readBytesUntil('$',comm,64);
  Serial.println(nchars);
  Serial.write((byte*) comm,nchars);
  Serial.println();

  }
  // put your main code here, to run repeatedly: 
  }
}


