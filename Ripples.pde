void detRipple(int x,int y){
  offset += .1;
    int refX = int(map(x,0,width,2,(funberOfPArticles-2)));
    int refY = int(map(y,0,height,2,(funberOfPArticles-2)));
    // det la vitesse sur le point et son voisinage
    particlesSpeedNew[refX][refY] = waveOrNot;
    particlesSpeedNew[refX+1][refY+1] = waveOrNot;
    particlesSpeedNew[refX+1][refY] = waveOrNot;
    particlesSpeedNew[refX+1][refY-1] = waveOrNot;
    particlesSpeedNew[refX][refY-1] = waveOrNot;
    particlesSpeedNew[refX-1][refY+1] = waveOrNot;
    particlesSpeedNew[refX-1][refY] = waveOrNot;
    particlesSpeedNew[refX-1][refY-1] = waveOrNot;
    // det la position sur le point et son voisinage
    int wFact = 7;//10;
    int hFact = 5;
    particle[refX][refY] = waveOrNot*wFact;
    particle[refX+1][refY+1] = waveOrNot*hFact;
    particle[refX+1][refY] = waveOrNot*wFact;
    particle[refX+1][refY-1] = waveOrNot*hFact;
    particle[refX][refY-1] = waveOrNot*wFact;
    particle[refX-1][refY+1] = waveOrNot*hFact;
    particle[refX-1][refY] = waveOrNot*wFact;
    particle[refX-1][refY-1] = waveOrNot*hFact;
}
