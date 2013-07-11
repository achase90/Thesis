byte comm[60];

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
while (!Serial);
  Serial.println("Serial port opened");

  Serial1.begin(9600);
while(!Serial1);
Serial.println("Serial1 open");
Serial1.print('*99C\r');
Serial.println();
Serial.println();
comm[0]=0x2a;
comm[1]= 0x39;
comm[2]=0x39;
comm[3]=0x43;
comm[4]=0x0D;
comm[5] = 0x0A;
Serial1.write(comm,6);
Serial.write(comm,6);
Serial1.println("*99C");
Serial1.print('*99C');
Serial1.print(comm[4]);
}

void loop() {
  int i=0;
  // put your main code here, to run repeatedly: 
  if (Serial.available()>0)
  {
    while (Serial.available()>0)
    {
      comm[i] = Serial.read();
      delay(5);
      i++;
    }
  }
  if (i>0)
  {
    Serial.write(comm,i-1);
    Serial.println();
    Serial1.write(comm,i-1);
    Serial1.println();
  }
delay(5);
//Serial1.print('*99C\r');
//Serial.print('*99C\r');
while (Serial1.available()>0)
{
  //Serial.println("Data was available");
 Serial.println(Serial1.read()); 
}
}









