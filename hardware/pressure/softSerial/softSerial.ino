#define baudRate 19200

#if (baudRate == 19200)
//const uint8_t spb = 52.0833333333;
const uint8_t spb = 52;
#elif (baudRate == 9600)
//const uint8_t spb = 104.1666666666;
const uint8_t spb = 104;
#endif

#define txPin 28
#define rxPin 29

serialBuff[128] = 0;
serialAvail = 0;

void intHandler0()
{
  serialBuff[serialAvail++] = readByte(rxPin, spb)
  }


  void setup(){
    pinMode(rxPin, INPUT);
    pinMode(txPin,OUTPUT);
    attachInterrupt(rxPin,intHandler0,FALLING);


    Serial.begin(19200);
    //Timer3.start(); // Calls every 50ms
  }

void loop()
{
  char x = 'r';

  writeByte(txPin, spb, x);
}

void writeByte(uint8_t pin, uint8_t spb, char x)
{
  boolean y = 0;

  digitalWrite(txPin,LOW); //start bit
  delayMicroseconds(spb); //spb is seconds per bit, 1/baudRate;
  for (int i=0;i<8;i++)
  {
    y = x & (1<<i);
    digitalWrite(txPin,y); //LSB
    delayMicroseconds(spb); //spb is seconds per bit, 1/baudRate;
  }
  digitalWrite(txPin,HIGH); //stop bit
}

byte readByte(uint8_t pin, uint8_t spb)
{
  byte x = 0;
  boolean y=0;

  y = digitalRead(txPin); //start bit
  delayMicroseconds(spb/2); //spb is seconds per bit, 1/baudRate. wait for half of the expected time
  delayMicroseconds(spb); //now wait entire time, so we're in the middle of a bit

  for(int i=0;i<8;i++)
  {
    y = digitalRead(txPin); //lsb
    x = (y << i) | x; //shift left one and set bit
    delayMicroseconds(spb); //spb is seconds per bit, 1/baudRate;
  }

  y = digitalRead(txPin); //stop bit
  if (y != 1)
  {
    x=0; 
  }
  return x;
}


