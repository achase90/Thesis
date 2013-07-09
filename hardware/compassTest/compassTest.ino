int bitIn=0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  Serial.println("Serial port opened");

  Serial1.begin(9600,8,1,'N');
  Serial.println();
  Serial.println();
  Serial.println("Few lines added");
}

void loop() {
  // put your main code here, to run repeatedly: 
  while (Serial1.available())
  {
   /*
   int countByte = 0;
    bitIn = Serial1.read();
    if (bitIn == 0x0d)
    {
      Serial.println("Received 0x0d");
      while (!Serial1.available())
      {
       // Serial.println( "Waiting for data"); 
      }
      countByte +=bitIn;
      bitIn = Serial1.read();
      //Serial.println(bitIn);
      if (bitIn == 0x0a)
      {
        Serial.println("Received 0x0a");
        while (!Serial1.available())
        {
          Serial.println( "Waiting for data"); 
        }
        countByte +=bitIn;
        bitIn = Serial1.read();
        Serial.println(bitIn);

        if (bitIn == 0x7e)
        {
          countByte +=bitIn;
          int nBytesData = Serial1.read();
          Serial.print("Expected data bytes :   ");
          Serial.println(nBytesData);
          int data[80];
          //Serial.println("Data received");
          int i=0;
          while (i<nBytesData) //TODO: add timer here
          {
            if (Serial.available())
            {
              data[i]=Serial1.read();
              countByte +=data[i];
              i++;
            }
          }
          int checkSum = Serial1.read();
          i=0;
          if (i<nBytesData)
          {
            i++;
            Serial.print(data[i]);
            Serial.print(",");
          }
          else
          {
            Serial.print(data[i]);
            Serial.print(",");
            Serial.println(checkSum == countByte%256);
          }
        }
      }
    }
    */
    Serial.println(Serial1.read());
  }






  if (Serial.available())
  {
    while (Serial.available())
    {
      bitIn=Serial.read();
      if (bitIn == 'p')
      {
        byte MESSAGE_ID = 0x44;
        Serial.println("Print command received");
        Serial1.write((byte)0x0d); //start 1
        Serial1.write((byte)0x0a); //start 2
        Serial1.write((byte)0x7e); //start 3
        Serial1.write(MESSAGE_ID); //id
        int x = 5000;
        byte lsb = x;
        byte msb = (x >> 8);
        Serial1.write((byte)0); //number of data bytes
        //Serial1.write(lsb); //data byte 1
        // Serial1.write(msb); //data byte 2
        Serial.println(x,BIN);
        Serial.println(msb,BIN);
        Serial.println(lsb,BIN);
        int checkSum = 0x0d;
        checkSum += 0x0a;
        checkSum += 0x7e;
        checkSum += MESSAGE_ID;
        checkSum += 0x02;
        //checkSum += lsb;
        //checkSum += msb;
        checkSum = checkSum%256;
        Serial.println(checkSum,HEX);
        Serial1.write((byte) checkSum); //checksum 
        Serial.println("data supposedly written");
      }
    } 
  }
}








