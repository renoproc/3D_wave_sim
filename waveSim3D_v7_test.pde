// forked from https://github.com/BenTommyE/3D_wave_sim

import peasy.*;
PeasyCam cam;

float[][] particle;
float[][] particlesSpeed;
float[][] particlesNew;
float[][] particlesSpeedNew;

float particelGain = 0.00999;
float forceGain = 0.995;  // Speed factor
float visc = 150; // Viscosity
int funberOfPArticles = 100;
int zoom = 10;
float rayon = 300;

float offset = 0;
float waveOrNot = 0;
boolean lonFlag = true;
boolean latFlag = true;
boolean spherFlag = false;
boolean hairSphere = false;

void setup() {
  size(800,600,P3D);//1280, 780, P3D);
  //fullScreen(P3D);

  cam = new PeasyCam(this,500);
  
  // init arrays, z coords in [x][y] array
  // particles to draw
  particle = new float[funberOfPArticles][funberOfPArticles];
  particlesSpeed = new float[funberOfPArticles][funberOfPArticles];
  // moved particles
  particlesNew = new float[funberOfPArticles][funberOfPArticles];
  particlesSpeedNew = new float[funberOfPArticles][funberOfPArticles];
  
  // fill particles arrays with empty values
  for (int x = 1; x<funberOfPArticles; x++) {
    for (int y = 1; y<funberOfPArticles; y++) {
      particle[x][y] = 0.0;
      particlesNew[x][y] = 0.0;
      particlesSpeed[x][y] = 0.0;
      particlesSpeedNew[x][y] = 0.0;
    }
  }

  noFill();
  stroke(255);
}

void draw() {
  updateMesh();
  background(0);
  drawMesh();
}

void keyPressed() {  
  if (key==' ') { waveOrNot = (waveOrNot==0 ? -5 : 0);  }
  if (key=='K') { lonFlag = !lonFlag; }
  if (key=='L') { latFlag = !latFlag; }
  if(key=='H') { hairSphere = !hairSphere; }
  if(key=='S'){ spherFlag = !spherFlag; }
  
}
