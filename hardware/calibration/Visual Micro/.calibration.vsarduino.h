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
void readAccelData(UARTClass &Serial,unsigned long timeOut,int16_t &accelX,int16_t &accelY,int16_t &accelZ, int16_t &accelT, float &fDesired, int16_t desired);
void readGyroData(int16_t &gyroX,int16_t &gyroY,int16_t &gyroZ);
void readAllPress (USARTClass &pressureSerial,char add0[], char add1[], char add2[], char add3[], int16_t *pressure);
int16_t readUniquePress(USARTClass &pressureSerial,char address[]);

#include "C:\Users\mufasa\Documents\arduino-nightly\hardware\arduino\sam\variants\arduino_due_x\pins_arduino.h" 
#include "C:\Users\mufasa\Documents\arduino-nightly\hardware\arduino\sam\variants\arduino_due_x\variant.h" 
#include "C:\Users\mufasa\Documents\arduino-nightly\hardware\arduino\sam\cores\arduino\arduino.h"
#include "c:\Users\mufasa\Documents\Thesis\hardware\calibration\calibration.ino"
#endif
