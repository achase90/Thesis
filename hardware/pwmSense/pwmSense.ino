volatile unsigned long trig0=0;
volatile unsigned long pwm0 = 0;
#define pwmPin0 38
volatile unsigned long trig1=0;
volatile unsigned long pwm1 = 0;
#define pwmPin1 39
volatile unsigned long trig2=0;
volatile unsigned long pwm2 = 0;
#define pwmPin2 40
volatile unsigned long trig3=0;
volatile unsigned long pwm3 = 0;
#define pwmPin3 41
volatile unsigned long trig4=0;
volatile unsigned long pwm4 = 0;
#define pwmPin4 42
volatile unsigned long trig5=0;
volatile unsigned long pwm5 = 0;
#define pwmPin5 43
volatile unsigned long trig6=0;
volatile unsigned long pwm6 = 0;
#define pwmPin6 44
volatile unsigned long trig7=0;
volatile unsigned long pwm7 = 0;
#define pwmPin7 45

void intHandler0()
{
    if(digitalRead(pwmPin0))
  {
    trig0 = micros();
  }
  else
  {
    pwm0 = micros()-trig0;
  }
}

void intHandler1()
{
    if(digitalRead(pwmPin1))
  {
    trig1 = micros();
  }
  else
  {
    pwm1 = micros()-trig1;
  }
}

void intHandler2()
{
    if(digitalRead(pwmPin2))
  {
    trig2 = micros();
  }
  else
  {
    pwm2 = micros()-trig2;
  }
}

void intHandler3()
{
    if(digitalRead(pwmPin3))
  {
    trig3 = micros();
  }
  else
  {
    pwm3 = micros()-trig3;
  }
}

void intHandler4()
{
  
    if(digitalRead(pwmPin4))
  {
    trig4 = micros();
  }
  else
  {
    pwm4 = micros()-trig4;
  }
}

void intHandler5()
{
    if(digitalRead(pwmPin5))
  {
    trig5 = micros();
  }
  else
  {
    pwm5 = micros()-trig5;
  }
}

void intHandler6()
{
    if(digitalRead(pwmPin6))
  {
    trig6 = micros();
  }
  else
  {
    pwm6 = micros()-trig6;
  }
}

void intHandler7()
{
    if(digitalRead(pwmPin7))
  {
    trig7 = micros();
  }
  else
  {
    pwm7 = micros()-trig7;
  }
}




void setup(){
  pinMode(pwmPin0, INPUT);
  pinMode(pwmPin1, INPUT);
  pinMode(pwmPin2, INPUT);
  pinMode(pwmPin3, INPUT);
  pinMode(pwmPin4, INPUT);
  pinMode(pwmPin5, INPUT);
  pinMode(pwmPin6, INPUT);
  pinMode(pwmPin7, INPUT);

  attachInterrupt(pwmPin0,intHandler0,CHANGE);
  attachInterrupt(pwmPin1,intHandler1,CHANGE);
  attachInterrupt(pwmPin2,intHandler2,CHANGE);
  attachInterrupt(pwmPin3,intHandler3,CHANGE);
  attachInterrupt(pwmPin4,intHandler4,CHANGE);
  attachInterrupt(pwmPin5,intHandler5,CHANGE);
  attachInterrupt(pwmPin6,intHandler6,CHANGE);
  attachInterrupt(pwmPin7,intHandler7,CHANGE);

  Serial.begin(19200);
  //Timer3.start(); // Calls every 50ms
}

void loop()
{

  Serial.print("PWM = ");// I'm stuck in here! help me...	
  Serial.print(pwm0);
  Serial.print('\t');
    Serial.print(pwm1);
  Serial.print('\t');
    Serial.print(pwm2);
  Serial.print('\t');
    Serial.print(pwm3);
  Serial.print('\t');
    Serial.print(pwm4);
  Serial.print('\t');
    Serial.print(pwm5);
  Serial.print('\t');
    Serial.print(pwm6);
  Serial.print('\t');
    Serial.print(pwm7);
  Serial.print('\n');
}
