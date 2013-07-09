#include <Wire.h> // I2C library, gyroscope
#include <SPI.h>
#include <SD.h>
const int chipSelect = 4;

// Accelerometer ADXL345
#define ACC (0x53)    //ADXL345 ACC address
#define A_TO_READ (6)        //num of bytes we are going to read each time (two bytes for each axis)


// Gyroscope ITG3200 
#define GYRO 0x69 // gyro address, binary = 11101001 when AD0 is connected to Vcc (see schematics of your breakout board)
#define G_SMPLRT_DIV 0x15
#define G_DLPF_FS 0x16
#define G_INT_CFG 0x17
#define G_PWR_MGM 0x3E

#define G_TO_READ 8 // 2 bytes for each axis x, y, z

// offsets are chip specific. 
int g_offx = 120;
int g_offy = 20;
int g_offz = 93;

char str[512]; 

void initAcc() {
  //Turning on the ADXL345
  writeTo(ACC, 0x2D, 0);      
  writeTo(ACC, 0x2D, 16);
  writeTo(ACC, 0x2D, 8);
  //by default the device is in +-2g range reading
}

void getAccelerometerData(int * result) {
  int regAddress = 0x32;    //first axis-acceleration-data register on the ADXL345
  byte buff[A_TO_READ];

  readFrom(ACC, regAddress, A_TO_READ, buff); //read the acceleration data from the ADXL345

  //each axis reading comes in 10 bit resolution, ie 2 bytes.  Least Significat Byte first!!
  //thus we are converting both bytes in to one int
  result[0] = (((int)buff[1]) << 8) | buff[0];   
  result[1] = (((int)buff[3])<< 8) | buff[2];
  result[2] = (((int)buff[5]) << 8) | buff[4];
}

//initializes the gyroscope
void initGyro()
{
  /*****************************************
   * ITG 3200
   * power management set to:
   * clock select = internal oscillator
   *     no reset, no sleep mode
   *   no standby mode
   * sample rate to = 125Hz
   * parameter to +/- 2000 degrees/sec
   * low pass filter = 5Hz
   * no interrupt
   ******************************************/
  writeTo(GYRO, G_PWR_MGM, 0x00);
  writeTo(GYRO, G_SMPLRT_DIV, 0x07); // EB, 50, 80, 7F, DE, 23, 20, FF
  writeTo(GYRO, G_DLPF_FS, 0x1E); // +/- 2000 dgrs/sec, 1KHz, 1E, 19
  writeTo(GYRO, G_INT_CFG, 0x00);
}


void getGyroscopeData(int * result)
{
  /**************************************
   * Gyro ITG-3200 I2C
   * registers:
   * temp MSB = 1B, temp LSB = 1C
   * x axis MSB = 1D, x axis LSB = 1E
   * y axis MSB = 1F, y axis LSB = 20
   * z axis MSB = 21, z axis LSB = 22
   *************************************/

  int regAddress = 0x1B;
  int temp, x, y, z;
  byte buff[G_TO_READ];

  readFrom(GYRO, regAddress, G_TO_READ, buff); //read the gyro data from the ITG3200

  result[0] = ((buff[2] << 8) | buff[3]) + g_offx;
  result[1] = ((buff[4] << 8) | buff[5]) + g_offy;
  result[2] = ((buff[6] << 8) | buff[7]) + g_offz;
  result[3] = (buff[0] << 8) | buff[1]; // temperature

}


void setup()
{
  Serial.begin(9600);
  Wire.begin();
  initAcc();
  initGyro();
  pinMode(8, OUTPUT);
  if (!SD.begin(chipSelect)) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    return;
  }
  Serial.println("card initialized.");
  SD.remove("datalog.txt");
}


void loop()
{
  int acc[3];
  int gyro[4];
  getAccelerometerData(acc);
  getGyroscopeData(gyro);
  File dataFile = SD.open("datalog.txt", FILE_WRITE);

  if (dataFile){
    byte buf[20]={
      0    };
    buf[0]= byte( acc[0]);
    buf[1] = byte(acc[0]  >> 8);
    buf[2]= byte( acc[1]);
    buf[3] = byte(acc[1]  >> 8);
    buf[4]= byte( acc[2]);
    buf[5] = byte(acc[2]  >> 8);
    buf[6]= byte( gyro[0]);
    buf[7] = byte(gyro[0]  >> 8);
    buf[8]= byte( gyro[1]);
    buf[9] = byte(gyro[1]  >> 8);
    buf[10]= byte( gyro[2]);
    buf[11] = byte(gyro[2]  >> 8);
    buf[12]= byte( gyro[3]);
    buf[13] = byte(gyro[3]  >> 8);


    sprintf(str, "%d,%d,%d,%d,%d,%d,%d", acc[0], acc[1], acc[2], gyro[0], gyro[1], gyro[2], gyro[3]);  
    Serial.print(str);
    Serial.write(10);
    dataFile.write(buf,14);
    dataFile.close();
    //delay(50);
  }
  else{
    Serial.println("error opening datalog.txt");
  }
}


//---------------- Functions
//Writes val to address register on ACC
void writeTo(int DEVICE, byte address, byte val) {
  Wire.beginTransmission(DEVICE); //start transmission to ACC 
  Wire.write(address);        // send register address
  Wire.write(val);        // send value to write
  Wire.endTransmission(); //end transmission
}


//reads num bytes starting from address register on ACC in to buff array
void readFrom(int DEVICE, byte address, int num, byte buff[]) {
  Wire.beginTransmission(DEVICE); //start transmission to ACC 
  Wire.write(address);        //sends address to read from
  Wire.endTransmission(); //end transmission

    Wire.beginTransmission(DEVICE); //start transmission to ACC
  Wire.requestFrom(DEVICE, num);    // request 6 bytes from ACC

  int i = 0;
  while(Wire.available())    //ACC may send less than requested (abnormal)
  { 
    buff[i] = Wire.read(); // receive a byte
    i++;
  }
  Wire.endTransmission(); //end transmission
}




