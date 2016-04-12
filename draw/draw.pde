import processing.serial.*;

Serial myPort; //Create object from Serial class
//String valString; // Data received from the serial port
String val;

// Since we're doing serial handshaking, we need to check if we've heard from the microcontroller
boolean firstContact = false;

void setup(){
  size(500,500); // Make our canvas
  String portName = Serial.list()[0]; // This connects to COM4 on my computer
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');

}

void draw(){
  ellipse(mouseX, mouseY, 80, 80);
  if(myPort.available()>0){
    serialEvent(myPort);
  }
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