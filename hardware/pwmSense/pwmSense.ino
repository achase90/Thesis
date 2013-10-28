int servoPin = 38;
unsigned long trig1=0;
unsigned long deltaT = 0;
//bool ledOn = false;
void myHandler(){
  if(digitalRead(servoPin))
  {
    trig1 = micros();
  }
  else
  {
    deltaT = micros()-trig1;
  }
}

void setup(){
  pinMode(servoPin, INPUT);
  Serial.begin(19200);
  attachInterrupt(servoPin,myHandler,CHANGE);
  //Timer3.start(); // Calls every 50ms
}

void loop()
{

  Serial.print("PWM = ");// I'm stuck in here! help me...	
  Serial.println(deltaT);
}
