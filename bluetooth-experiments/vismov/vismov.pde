float boxRotation = 0;

import ketai.net.bluetooth.*;

void setup() {
size(750, 1200);
smooth();
fill(255);
stroke(255);
rectMode(CENTER); //This sets all rectangles to draw from the center point
};

void draw() {
//Set background color, which gets more red as we move our finger down the screen.
background(mouseY * (255.0/800), 100, 0);
//Change the box rotation depending on how finger has moved right to left
boxRotation += (float)(pmouseX - mouseX)/100;
//Draw the ball-and-stick
line(width/2, height/2, mouseX, mouseY);
ellipse(mouseX, mouseY, 40, 40);
//Draw the box
pushMatrix();
translate(width/2, height/2);
rotate(boxRotation);
rect(0,0,150,150);
popMatrix();
};