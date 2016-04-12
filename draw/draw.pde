import processing.serial.*;

Serial myPort; //Create object from Serial class
String valString; // Data received from the serial port
int val;

// Since we're doing serial handshaking, we need to check if we've heard from the microcontroller
boolean firstContact = false;

void setup(){
  size(500,500); // Make our canvas
  String portName = Serial.list()[0]; // This connects to COM4 on my computer
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');

}

void draw(){
    fill(0,12);
    rect(0,0,width,height);
    fill(255);
    ellipse(width/2, val, 50,50);
    println("val= " + val);
  if(myPort.available()>0){
    serialEvent(myPort);
  }
}

void serialEvent(Serial myPort){
  // Put the incoming data into a String, the '\n' is our end delimiter indicating the end of a complete packet
  valString = myPort.readStringUntil('\n');
  // Make sure our data isn't empty before continuing
  if(valString != null){
    val = Integer.parseInt(valString);
    // Trim whitespace and formatting characters (like carriage return)
    //val = trim(val);
    //println(val);
    
    // Look for our 'A' string to start the handshake
    // If it's there, clear the buffer and send a request for data
    if(firstContact == false){
      if(valString.equals("A")){
        myPort.clear();
        firstContact = true;
        myPort.write("A");
        println("contact");
      }
    } else { // If we've already established contact, keep getting and parsing data
      println(valString);
      
      if(mousePressed==true){ // If we clicked in the window
        myPort.write('1'); // Send a 1
        println("1");
      }
      
      // When you've parsed the data you have, ask for more:
      myPort.write("A");
    }
  }
}