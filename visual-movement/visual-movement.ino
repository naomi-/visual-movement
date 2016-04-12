#include <Adafruit_NeoPixel.h>  // This lets us communicate with the NeoPixel on Flora (not using this yet)

char val;   // Data reecived from the serial port
int ledPin = 7; // Set the pin to digital I/O 7
boolean ledState = LOW; // To toggle our LED

// For pressure input
const int toePin = A9; // Analog input pin for toe pressure sensor
const int heelPin = A10; // Analog input pin for heel pressure sensor
int toeValue = 0; // Value read from toe sensor
int heelValue = 0; // Value read from heel sensor


void setup() {
  // put your setup code here, to run once:
  // Set pin modes
  pinMode(ledPin, OUTPUT); // Set pin as OUTPUT
  pinMode(toePin, INPUT_PULLUP); // Set pin as INPUT
  pinMode(heelPin, INPUT_PULLUP); // Set pin as INPUT
  Serial.begin(9600); // Initialize serial communications at a 9600 baud rate
  establishContact(); // Send a byte to establish contact until receiver responds
}

void loop() {
  // put your main code here, to run repeatedly:

  // Read the values from the pressure sensors
  // toeValue = analogRead(toePin);
  // heelValue = analogRead(heelPin);
  // Print the results to the serial monitor
  // Serial.println("toe");
//  Serial.println(toeValue);
//  Serial.println("heel");
//  Serial.println(heelValue);
//  delay(50);
  
  if (Serial.available() > 0) { // If data is available to read,
    val = Serial.read(); // Read it and store it in val

    if(val == '1') { // If we get a 1 
       ledState = !ledState; // Flip the ledState
       digitalWrite(ledPin, ledState); 
    }
    delay(100);
  } 
    else {
    // Read the values from the pressure sensors
    toeValue = analogRead(toePin);
    // Print the results 
    Serial.println("Hello World!");
    delay(50);
    }
}

void establishContact() {
  while(Serial.available() <= 0) {
    Serial.println("A"); // Send a capital A
    delay(300);  
  } 
}
