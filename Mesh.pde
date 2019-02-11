void updateMesh() {
  // en 1er det et applique une force en fonction du voisinage
  int max = funberOfPArticles-1;
  int min = 1;
  for (int x = min; x<max; x++) {
    for (int y = min; y<max; y++) {
      float force1 = 0.0;
      
      //under
      force1 += particle[x-1][y-1] - particle[x][y];
      force1 += particle[x-1][y] - particle[x][y];
      force1 += particle[x-1][y+1] - particle[x][y];
      //over
      force1 += particle[x+1][y-1] - particle[x][y];
      force1 += particle[x+1][y] - particle[x][y];
      force1 += particle[x+1][y+1] - particle[x][y];
      //sidene
      force1 += particle[x][y-1] - particle[x][y];
      force1 += particle[x][y+1] - particle[x][y];
      force1 -= particle[x][y+1] / 8;

      particlesSpeedNew[x][y] = forceGain * particlesSpeedNew[x][y] + force1/visc;
      particlesNew[x][y] = particle[x][y] + particlesSpeedNew[x][y];
    }
  }
  // met a jour les coords z des particules
  for (int x = 1; x<funberOfPArticles; x++) {
    for (int y = 1; y<funberOfPArticles; y++) {
      particle[x][y] = particlesNew[x][y];
    }
  }
  
  // det. l'influence du pointeur souris (influence de voisinage)
  if(waveOrNot != 0) {
    detRipple(mouseX,mouseY);
  }
}


void drawMesh() {
  strokeWeight(1);
  colorMode(HSB,360,100,100);
  stroke(180,100,100);
 
  if(!spherFlag){ // draw a plane rather than a sphere
    translate(-(width+funberOfPArticles)/2,-(height+funberOfPArticles)/2);
    for (int x = 0; x<funberOfPArticles; x++) {
      beginShape();
      for (int y = 0; y<funberOfPArticles; y++) {
        float mapH = map(particle[x][y],0,60,200,0);
        // particle[x][y] = 0 -> 150 +30
        stroke(mapH,100,100);
        vertex( (x)*zoom, (y)*zoom, particle[x][y] );
      }
      endShape();
    }
    for (int y = 0; y<funberOfPArticles; y++) {
      beginShape();
      for (int x = 0; x<funberOfPArticles; x++) {
        float mapH = map(particle[x][y],0,60,200,0);
        stroke(mapH,100,100);
        vertex( (x)*zoom, (y)*zoom, particle[x][y] );
      }
      endShape();
    }
  }else{// draw a sphere rather than a plane
    
    if(lonFlag){
      // dessin des longitudes (verticales)
      for (int i = 0; i<funberOfPArticles; i++) {
        float lat = map(i, 1, funberOfPArticles,-HALF_PI, HALF_PI);
        beginShape();
        for (int j = 0; j<funberOfPArticles; j++) {
          float lon = map(j, 1, funberOfPArticles, -PI, PI);
          float rA = rayon+particle[i][j];
          PVector A = sphericalToCartesian(new PVector(rA,lat,lon),null,null);

          float mapH = map(rA,(rayon-10),(rayon+30),270,0);
          //println("rA:"+rA+" mapH:"+mapH);
          stroke(mapH,100,100);
          vertex(A.x, A.y, A.z);
        }
        endShape();
      }
    }    
    if(latFlag){
      // dessin des latitudes (horizontales)
      for (int j = 0; j<funberOfPArticles; j++) {
        float lon = map(j, 1, funberOfPArticles, -PI, PI);
        beginShape();
        for (int i = 0; i<funberOfPArticles; i++) {
          float lat = map(i, 1, funberOfPArticles,-HALF_PI, HALF_PI);
          float rB = rayon+particle[i][j];
          PVector B  = sphericalToCartesian(new PVector(rB,lat,lon),null,null);

          float mapH = map(rB,(rayon-10),(rayon+30),270,0);
          stroke(mapH,100,100);
          vertex(B.x, B.y, B.z);
        }
        endShape();
      }
    }
    
    // second sphere option : "hair sphere"
    if(!latFlag && !lonFlag && hairSphere){
      for (int i = 0; i<funberOfPArticles; i++) {
        float lon2 = map(i, 1, funberOfPArticles, -PI, PI);
        float lat1 = map(i, 1, funberOfPArticles,-HALF_PI, HALF_PI);
        beginShape();
        for (int j = 0; j<funberOfPArticles; j++) {
          float lon1 = map(j, 1, funberOfPArticles, -PI, PI);
          float rA = rayon+particle[i][j];
          PVector A = sphericalToCartesian(new PVector(rA,lat1,lon1),null,null);
          
          float mapA = map(rA,(rayon-10),(rayon+30),270,0);
          stroke(mapA,100,100);
          vertex(A.x, A.y, A.z);
          
          float lat2 = map(i, 1, funberOfPArticles,-HALF_PI, HALF_PI);
          float rB = rayon+particle[j][i];
          PVector B  = sphericalToCartesian(new PVector(rB,lat2,lon2),null,null);
          
          float mapB = map(rB,(rayon-10),(rayon+30),270,0);
          stroke(mapB,100,100);
          vertex(B.x, B.y, B.z);
        }
        endShape();
      }
    }
  }
}

void remap(){
}
