char val;   // Data reecived from the serial port
int ledPin = 7; // Set the pin to digital I/O 7
boolean ledState = LOW; // To toggle our LED

void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT); // Set pin as OUTPUT
  Serial.begin(9600); // Initialize serial communications at a 9600 baud rate
  establishContact(); // Send a byte to establish contact until receiver responds
}

void loop() {
  // put your main code here, to run repeatedly:
  if (Serial.available() > 0) { // If data is available to read,
    val = Serial.read(); // Read it and store it in val

    if(val == '1') { // If we get a 1 
       ledState = !ledState; // Flip the ledState
       digitalWrite(ledPin, ledState); 
    }
    delay(100);
  } 
    else {
    Serial.println("Hello, world!"); // Send back a hello world
    delay(50);
    }
}

void establishContact() {
  while(Serial.available() <= 0) {
    Serial.println("A"); // Send a capital A
    delay(300);  
  } 
}
