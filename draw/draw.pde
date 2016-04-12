import processing.serial.*;

Serial myPort; //Create object from Serial class
String val; // Data received from the serial port

// Since we're doing serial handshaking, we need to check if we've heard from the microcontroller
boolean firstContact = false;

void setup(){
  size(200,200); // Make 200 x 200 pixel canvas
  String portName = Serial.list()[0]; // This connects to COM4 on my computer
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');

}

void draw(){
  // We can leave the draw method empty for now, because all of our programming happens in the serialEvent method
}

void serialEvent(Serial myPort){
  // Put the incoming data into a String, the '\n' is our end delimiter indicating the end of a complete packet
  val = myPort.readStringUntil('\n');
  // Make sure our data isn't empty before continuing
  if(val != null){
    // Trim whitespace and formatting characters (like carriage return)
    val = trim(val);
    println(val);
    
    // Look for our 'A' string to start the handshake
    // If it's there, clear the buffer and send a request for data
    if(firstContact == false){
      if(val.equals("A")){
        myPort.clear();
        firstContact = true;
        myPort.write("A");
        println("contact");
      }
    } else { // If we've already established contact, keep getting and parsing data
      println(val);
      
      if(mousePressed==true){ // If we clicked in the window
        myPort.write('1'); // Send a 1
        println("1");
      }
      
      // When you've parsed the data you have, ask for more:
      myPort.write("A");
    }
  }
}