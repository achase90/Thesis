#ifndef _VSARDUINO_H_
#define _VSARDUINO_H_
//Board = Arduino Due (Programming Port)
#define __SAM3X8E__
#define USB_PID 0x003e
#define USB_VID 0x2341
#define USBCON
#define 
#define ARDUINO 150
#define ARDUINO_MAIN
#define printf iprintf
#define __SAM__
#define F_CPU 84000000L
#define __cplusplus
#define __inline__
#define __asm__(x)
#define __extension__
#define __ATTR_PURE__
#define __ATTR_CONST__
#define __inline__
#define __asm__ 
#define __volatile__

#define __ICCARM__
#define __ASM
#define __INLINE
#define __GNUC__ 0
#define __ICCARM__
#define __ARMCC_VERSION 400678
#define __attribute__(noinline)

#define prog_void
#define PGM_VOID_P int
            
typedef unsigned char byte;
extern "C" void __cxa_pure_virtual() {;}




//
//
void readMagnetometer(USARTClass &magSerial,int16_t *magReading);
void readGyroData(int16_t &gyroX,int16_t &gyroY,int16_t &gyroZ);
void readAccelData(int16_t &accelX,int16_t &accelY,int16_t &accelZ);
void readAllPress (USARTClass &pressureSerial,char add0[], char add1[], char add2[], char add3[], int16_t *pressure);
int16_t readUniquePress(USARTClass &pressureSerial,char address[]);
void readGPS(USARTClass &gpsSerial,char *msgID,uint32_t &utcTime,char **gpsStatus, int32_t &gpsLat,char **nsInd,int32_t &gpsLong,char **ewInd,int32_t &gpsSpd,int32_t &gpsCrs,uint32_t &date,char **mode,uint32_t &CS);
void serialDeviceInit(UARTClass& mainSerial, USARTClass& deviceSerial, int deviceBaud,char ID[]);
void initSDCard(UARTClass &serial,uint8_t sdCardChipSelect);
void parseToBinInt16(byte buff[],int16_t var,uint16_t &loc);
void parseToBinInt32(byte buff[],int32_t var,uint16_t &loc);
void parseToBinUInt32(byte buff[],uint32_t var,uint16_t &loc);
void parseInput();
void intHandler0();
void intHandler1();
void intHandler2();
void intHandler3();
void intHandler4();
void intHandler5();
void intHandler6();
void intHandler7();
int getCheckSum(char *string);

#include "C:\Users\mufasa\Documents\arduino-nightly\hardware\arduino\sam\variants\arduino_due_x\pins_arduino.h" 
#include "C:\Users\mufasa\Documents\arduino-nightly\hardware\arduino\sam\variants\arduino_due_x\variant.h" 
#include "C:\Users\mufasa\Documents\arduino-nightly\hardware\arduino\sam\cores\arduino\arduino.h"
#include "c:\Users\mufasa\Documents\Thesis\hardware\mainScript\mainScript.ino"
#include "c:\Users\mufasa\Documents\Thesis\hardware\mainScript\template.h"
#endif
