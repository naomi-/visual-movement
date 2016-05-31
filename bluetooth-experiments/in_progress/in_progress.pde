//required for BT enabling on startup
import android.content.Intent;
import android.os.Bundle;

import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;

import oscP5.*;

KetaiBluetooth bt;
String info = "";
KetaiList klist;
PVector remoteMouse = new PVector();

ArrayList<String> devicesDiscovered = new ArrayList();
boolean isConfiguring = true;
String UIText;

//Serial myPort; // Create object from Serial class
String val; // Data received from the Serial port
float toeValue;

// The following code enables bluetooth at startup. 
void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  bt = new KetaiBluetooth(this);
  // so that screen doesn't go to sleep when app is active
 // getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
}

void onActivityResult(int requestCode, int resultCode, Intent data){
  bt.onActivityResult(requestCode, resultCode, data);
}
// End bluetooth startup code


void setup(){
  size(500,500); // Make our canvas
  
  //Start listening for BT connections
  bt.start();
  isConfiguring=true;
  
  bt.getPairedDeviceNames();
  
  bt.connectToDeviceByName("Adafruit Bluefruit LE");
    
  //String portName = Serial.list()[3]; // 0 connects to COM4 on my computer
  //myPort = new Serial(this, portName, 9600);
  //myPort.bufferUntil('\n');

}

void draw(){
  
    //ellipse(mouseX,mouseY,toeValue,toeValue);
    //text(UIText + "\n\n" + info, 5, 90);  
    
 //at app start select device
 if (isConfiguring) {
   ArrayList names;
   background(78, 93, 75);
   klist = new KetaiList(this, bt.getPairedDeviceNames());
   isConfiguring = false;
 } else {
   //print received data
   fill(255);
   noStroke();
   textAlign(LEFT);
   text(info, 20, 104);
 }
}

void onKetaiListSelection(KetaiList klist) {
  String selection = klist.getSelection();
  bt.connectToDeviceByName(selection);
  //dispose of list for now
  klist = null;
}

//Call back method to manage data received
void onBluetoothDataEvent(String who, byte[] data) {
  if (isConfiguring)
  return;
  //received
  info += new String(data);
  //clean if string to long
  if(info.length() > 150){
    info = "";
  }
}









//void serialEvent(Serial myPort){
//  // Put the incoming data into a String, the '\n' is our end delimiter indicating the end of a complete packet
//  val = myPort.readStringUntil('\n');
//  // Make sure our data isn't empty before continuing
//  if(val != null){
//    // Trim whitespace and formatting characters (like carriage return)
//    val = trim(val);
//    toeValue = float(val);
//    println(val);
//    println(toeValue);
    
//    // Look for our 'A' string to start the handshake
//    // If it's there, clear the buffer and send a request for data
//    if(firstContact == false){
//      if(val.equals("A")){
//        myPort.clear();
//        firstContact = true;
//        myPort.write("A");
//        println("contact");
//      }
//    } else { // If we've already established contact, keep getting and parsing data
//      println(val);
      
//      // When you've parsed the data you have, ask for more:
//      myPort.write("A");
//    }
//  }
//}