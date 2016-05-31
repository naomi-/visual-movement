//!! This should let us use bluetooth to get Serial port info
#include <Arduino.h>
#include <SPI.h>
#if not defined (_VARIANT_ARDUINO_DUE_X_) && not defined (_VARIANT_ARDUINO_ZERO_)
  #include <SoftwareSerial.h>
#endif

#include "Adafruit_BLE.h"
#include "Adafruit_BluefruitLE_SPI.h"
#include "Adafruit_BluefruitLE_UART.h"

#include "bluefruitConfig.h"

Adafruit_BluefruitLE_SPI ble(BLUEFRUIT_SPI_CS, BLUEFRUIT_SPI_IRQ, BLUEFRUIT_SPI_RST);

    #define FACTORYRESET_ENABLE         1
    #define MINIMUM_FIRMWARE_VERSION    "0.6.6"
    #define MODE_LED_BEHAVIOUR          "MODE"

// A small helper
void error(const __FlashStringHelper*err) {
  Serial.println(err);
  while (1);
}

// end !! ---------------

char val;   // Data reecived from the serial port

// For pressure input
const int toePin = A9; // Analog input pin for toe pressure sensor
int toeValue = 0; // Value read from toe sensor

void setup() {
  pinMode(toePin, INPUT_PULLUP); // Set pin as INPUT
  
  Serial.begin(115200); //Initializes Serial communication at a 115200 baud rate
  
  if(!ble.begin(VERBOSE_MODE)){
    error(F("Couldn't find Bluefruit, make sure it's in command mode and check wiring."));
  }
  ble.echo(false); //Disables command echo from Bluefruit
  ble.info(); //Prints Bluefruit information
  //ble.begin(115200); //Initializes bluetooth communication
  //Serial.println("Serial initialized");
  //establishContact(); // Send a byte to establish contact until receiver responds
  ble.verbose(false);
  
  while(! ble.isConnected()){
    delay(500);
  }
}

void loop() {
  ble.println("AT+BLEUARTRX");
  ble.readline();
  if (strcmp(ble.buffer, "OK")==0) {
    //no data
    return;  
  }
  //if some data was found, it's in the buffer
  Serial.print(F("[Recv] "));
  Serial.println(ble.buffer);
  ble.waitForOK();
  
  // Read the values from the pressure sensors
  //toeValue = analogRead(toePin);
  // Print the results to the Serial communication
  //Serial.println(toeValue);
  //delay(50);

}

//this checks for user input via the Serial Monitor
bool getUserInput(char buffer[], uint8_t maxSize)
{
  // timeout in 100 milliseconds
  TimeoutTimer timeout(100);

  memset(buffer, 0, maxSize);
  while( (!Serial.available()) && !timeout.expired() ) { delay(1); }

  if ( timeout.expired() ) return false;

  delay(2);
  uint8_t count=0;
  do
  {
    count += Serial.readBytes(buffer+count, maxSize);
    delay(2);
  } while( (count < maxSize) && (Serial.available()) );

  return true;
}

// This is an old method
void establishContact() {
  while(Serial.available() <= 0) {
    Serial.println("A"); // Send a capital A
    delay(300);  
  } 
}
