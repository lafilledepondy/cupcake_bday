PFont f;
String userInput = "";
boolean inputEntered = false;
int size = 45;

float spiralTurns = 10;
float numSpiralSpheres = spiralTurns * 70;

void setup() {
  size(800, 800, P3D);

  f = createFont("Brush Script MT", size);
  println("Enter a name:");
}

void draw() {
  background(255, 192, 255);
  textFont(f);
  fill(0);

  textAlign(CENTER);
  text("Happy B'day", width/2, 70);
  if (inputEntered) {
    textAlign(CENTER);
    textSize(size + 20);
    fill(220, 20, 60);
    text(userInput, width/2, 140);
    textSize(size);
    fill(0);
    textAlign(CENTER);
    text("!!!", width/2, 195);
  }

  // Draw candle
  pushMatrix();
  translate(width/2 + 12, height/2 - 25, 75);
  rotateX(PI/3);

  noStroke();
  fill(192, 192, 192); // Gray color for candle body
  drawCylinder(10, 100); // Candle body


  noStroke();
  fill(255, 204, 0); // Yellow color for candle flame
  translate(0, 0, 115); // Move up to the top of the sphere
  drawCone(20); // Candle flame
  popMatrix();

  translate (width/2, height/2 + 75);
  rotateX(PI/3);
  stroke(0, 4);
  noStroke();
  strokeWeight(2);

  cup();

  pointLight(255, 255, 255, mouseX, mouseY, 400);
  // Brown sphere
  translate (-80, 0, 75);
  sphere(100, color (192, 128, 64), color (255, 192, 128));

  // Green sphere
  translate (170, 0, 0);
  sphere(95, color (194, 242, 208), color (192, 255, 244));

  // Purple sphere
  translate (-75, 100, 15);
  sphere(80, color (209, 209, 246), color (236, 223, 255));
}

void keyPressed() {
  if (key == '\n') { // If the Enter key is pressed
    println("User Input: " + userInput);
    inputEntered = true; // Set flag to indicate input is entered
  } else if (!inputEntered) { // If input is not entered yet
    userInput += key; // Append the key pressed to the userInput string
  }
}

void drawCylinder(float radius, float height) {
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= 360; i += 30) {
    float x = cos(radians(i)) * radius;
    float y = sin(radians(i)) * radius;
    vertex(x, y, 0);
    vertex(x, y, height);
  }
  endShape(CLOSE);

  // Draw the two end caps
  beginShape();
  for (int i = 0; i <= 360; i += 30) {
    float x = cos(radians(i)) * radius;
    float y = sin(radians(i)) * radius;
    vertex(x, y, 0);
  }
  endShape(CLOSE);
  beginShape();
  for (int i = 0; i <= 360; i += 30) {
    float x = cos(radians(i)) * radius;
    float y = sin(radians(i)) * radius;
    vertex(x, y, height);
  }
  endShape(CLOSE);
}


void drawCone(float radius) {
  beginShape();
  for (int i = 0; i <= 360; i += 30) {
    float x = cos(radians(i)) * radius;
    float y = sin(radians(i)) * radius;
    vertex(x, y, 0);
  }
  endShape(CLOSE);

  // Draw the base
  beginShape();
  for (int i = 0; i <= 360; i += 30) {
    float x = cos(radians(i)) * radius;
    float y = sin(radians(i)) * radius;
    vertex(x, y, 0);
  }
  endShape(CLOSE);
}

void cup() {
  // Single cup
  beginShape(QUAD_STRIP);
  for (int i=-250; i<=250; i++) {
    float a = i/250.0*2*PI;
    float R1 = 180+40*abs(cos(a*10));
    float R2 = 200+40*abs(cos(a*10));
    fill(128, 64, 0);
    vertex(R1*cos(a), R1*sin(a), -100);
    fill(255, 192, 128);
    vertex(R2*cos(a), R2*sin(a), 100);
  }
  endShape();

  // Double sided
  beginShape(QUAD_STRIP);
  for (int i=-250; i<=250; i++) {
    float a = i/250.0*2*PI;
    float R1 = 180+40*abs(cos(a*10));
    fill(128, 64, 0);
    vertex(R1*cos(a), R1*sin(a), -100);
    fill(255, 192, 128);
    vertex(R1*cos(a), R1*sin(a), 100);
  }
  endShape();

  // Cup bord
  fill(192, 128, 64);
  beginShape(QUAD_STRIP);
  for (int i=-250; i<=250; i++) {
    float a = i/250.0*2*PI;
    float R1 = 180+40*abs(cos(a*10));
    float R2 = 200+40*abs(cos(a*10));
    vertex(R1*cos(a), R1*sin(a), 100);
    vertex(R2*cos(a), R2*sin(a), 100);
  }
  endShape();

  // Bottom
  fill(192, 128, 64);
  beginShape(TRIANGLE_FAN);
  vertex(0, 0, -100);
  for (int i=-250; i<=250; i++) {
    float a = i/250.0*2*PI;
    float R1 = 180+40*abs(cos(a*10));
    vertex(R1*cos(a), R1*sin(a), -100);
  }
  endShape();
}

void sphere(float circleRadius, color cSphere, color cTore) {
  // Dessine le grand sphère
  fill(cSphere);
  noStroke();
  sphere(circleRadius);

  // Dessine la spirale de petites sphères autour du grand sphère
  for (int i = 0; i < numSpiralSpheres; i++) {
    float theta = map(i, 0, numSpiralSpheres, 0, spiralTurns * TWO_PI); // Angle autour de la spirale
    float spiralRadius = map(i, 0, numSpiralSpheres, 0, PI);

    float x = circleRadius * sin(spiralRadius) * cos(theta);
    float y = circleRadius * cos(spiralRadius);
    float z = circleRadius * sin(spiralRadius) * sin(theta);

    pushMatrix();
    rotateX(PI/2);
    translate(x, y, z);
    noStroke();
    fill(cTore);
    sphere(4);
    popMatrix();
  }
}
