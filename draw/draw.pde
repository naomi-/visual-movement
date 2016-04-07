import processing.serial.*;

void setup(){
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
}

void draw(){
  if(myPort.available() > 0){
    val = myPort.readStringUntil('\n');
  }
  println(val);
}