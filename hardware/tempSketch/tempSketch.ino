#include <pwmInt.h>

pwmInt pwm1(30);
pwmInt pwm2(31);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("serial open");

}

void loop() {
  // put your main code here, to run repeatedly: 
  Serial.print("PWM1 = ");
  Serial.print(pwm1.pwm);
  
}
