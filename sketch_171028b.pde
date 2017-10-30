import processing.video.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

float resolution = 5;
float frequency = 0.005f;
int alpha = 31;

int animation = 0;
PImage BackG;
PFont Font;

boolean Sequence = true;
int numFrames = 8;  
int frame = 0;
PImage[] images = new PImage[numFrames];

boolean mo=true;
boolean play = true;
boolean spr=false;

boolean start=false;
boolean game=false;

boolean coffre1=true;
boolean coffre2=true;
boolean coffre3=true;
boolean tv=true;
boolean stat = true;
boolean gicleur=true;

int lts = 0;
int timeCheck1;

int howManyLettersToShow() {
  return lts++;
}

String test = "FIN ";


Automaton ca;

Movie video;

ParticleSystem ps;

Minim minim;
AudioPlayer player1;
AudioPlayer player2;
AudioPlayer player3;

AudioOutput out;

void setup()
{
  size(1000, 1000);
  
  BackG = loadImage("6.jpeg");
  Font = loadFont("ArialNarrow-Bold-48.vlw");
  frameRate(2);
  minim = new Minim(this);
  minim.debugOn();
  if (mo == true) {
    video = new Movie(this, "video_1.mp4");
  }
 
  ps = new ParticleSystem(new PVector(width/2, 50));
  


  player1 = minim.loadFile("SprinklerSound.mp3");
  player2 = minim.loadFile("ChestOpening.wav");
  player3 = minim.loadFile("TVStatic.aiff");

  out = minim.getLineOut();



  images[0]  = loadImage("1.jpeg");
  images[1]  = loadImage("2.jpeg"); 
  images[2]  = loadImage("3.jpeg");
  images[3]  = loadImage("4.jpeg"); 
  images[4]  = loadImage("5.jpeg");
  images[5]  = loadImage("6.jpeg"); 
  images[6]  = loadImage("7.jpeg");
  images[7]  = loadImage("8.jpeg");
  
    strokeWeight(1);
  blendMode(BLEND);
  rectMode(CORNER);
  
 ca = new Automaton(Automaton.TYPE_CELL_NOISE, ceil(520 / resolution), ceil(325 / resolution), resolution, frequency, alpha);
}

void movieEvent(Movie video) {
  video.read();
}

void BG() {
  background(143, 188, 143);
 
  strokeWeight( 2 );
  fill( 160, 82, 45 );
  rect( 190, 777, 620, 100 );

  strokeWeight( 2 );
  fill( 204, 204, 0 );
  rect( 295, 725, 70, 50 );

  strokeWeight( 2 );
  stroke( 0 );
  line( 295, 726, 365, 726 );

  fill( 204, 204, 0 );
  rect( 295, 700, 70, 25);

  fill( 0 );
  triangle( 323, 720, 337, 720, 330, 740 );

  fill( 204, 204, 0 );
  rect( 465, 725, 70, 50 );

  strokeWeight( 2 );
  stroke( 0 );
  line( 465, 726, 535, 726 );

  fill( 204, 204, 0 );
  rect( 465, 700, 70, 25 );

  fill( 0 );
  triangle( 492, 720, 507, 720, 500, 740 );

  fill( 204, 204, 0 );
  rect( 635, 725, 70, 50 );

  strokeWeight( 2 );
  stroke( 0 );
  line( 635, 726, 705, 726 );

  fill( 204, 204, 0 );
  rect( 635, 700, 70, 25 );

  fill( 0 );
  triangle( 663, 720, 677, 720, 670, 740 );

  fill( 150 );
  rect(225, 200, 550, 350 );

  fill( 30 );
  rect( 240, 212, 520, 325 );

  fill( 170 );
  rect( 490, 0, 20, 35 );
  rect( 497, 35, 6, 10 );
  rect( 485, 45, 30, 5 );
  line( 500, 45, 500, 50 );
  line( 493, 45, 493, 50 );
  line( 507, 45, 507, 50 );

  fill(150);
  arc(500, 552, 150, 100, 0, PI);

  noFill();
  strokeWeight(4);
  ellipse(330, 825, 60, 60);

  strokeWeight(4);
  line(320, 815, 340, 815);
  line(340, 815, 320, 835);
  line(320, 835, 340, 835);
}

void TV(){
  fill( 30 );
  rect( 240, 212, 520, 325 );
}
  

void draw() {

  if (Sequence) {
    frame = (frame+1)%numFrames; 
    image(images[frame], 0, 0);
    if (frame == 7) {
      Sequence = false;
      textFont(Font, 32);
      text("Cliquez pour continuer", 365, 400);
    }
  }
  
  image(video, 240, 212, 520, 325 );
  
  float vd = video.duration();
  float vt = video.time();
   if(vd == vt){
    mo = false;
    tv = false;
    }
    if (mo == false){
    player3.play();
    frameRate(60);
    translate(240, 212);
    ca.update();
    ca.update();
    ca.update();
    ca.update();
    stat = false;
    }
   
   
  if(spr == true && coffre3 == true){
  BG();
  frameRate(60);
  ps.addParticle();
  ps.run();
  fill(0);
  text("Pas de chance, encore rien. Appuyer sur 'C' pour ouvrir le troisième coffre. ", 50, 660);
  gicleur = false;
  }
  if (coffre1 == false && coffre2 == false && coffre3 == false && tv == false && stat == false && gicleur == false){
   frameRate(5);
   textSize(150);
   fill(255);
   howManyLettersToShow();
   typeIt(test, 160, 158);
   while (play == true){
   out.playNote( 0.0, 0.1, "Ab" );
   out.playNote( 0.2, 0.1, "Ab" );
   out.playNote( 0.4, 0.1, "Ab" );
   out.playNote( 1.0, 1.5, "A#" );
   out.playNote( 1.0, 1.5, "D#" );
   play = false;
  }
}
}

void mousePressed() {
  if (Sequence == false){
  fill(0);
  rect(50, 50, 900, 900);
  textFont(Font, 32);
  fill(255);
  text("Bienvenue dans notre petit jeu interactif animé. ", 220, 400); 
  text("Pour faire progresser l'interactivité,", 290, 450);
  text("il suffit d'appuyer sur les touches affichées", 240, 500);
  text("en dessous de chaque éléments.", 310, 550);
  text("Appuyez sur “D” pour débuter", 360, 625);
  start = true;
  }
}



void keyPressed() {
  if ((key == 'd' || key == 'D') && Sequence == false && start == true) {
    BG();
    game = true;
  }

  while ((key == 'z'|| key == 'Z') && coffre1 == true && game == true) {
    player2.play(0);
    delay(750);
    player2.pause();
    strokeWeight(2);
    fill(51, 51, 0);
    rect( 295, 675, 70, 50 );
    fill(0);
    text("Il n'y a rien ici, appuyez sur 'X' pour ouvrir le deuxième coffre. ", 100, 660);
    coffre1 = false;
    break;
  }
  while ((key == 'x' || key == 'X') && coffre1 == false && coffre2 == true) {
    BG();
    player2.play(0);
    delay(750);
    player2.pause();
    strokeWeight(2);
    fill(51, 51, 0);
    rect(465, 675, 70, 50 );
    fill(0);
    text("Il n'y a rien ici non plus, appuyer sur 'B' pour ouvrir le gicleur. ", 105, 660);
    coffre2 = false;
    break;
  }
  while ((key == 'c' || key == 'C') && gicleur == false && coffre3 == true) {
    BG();
    player2.play(0);
    delay(750);
    player2.pause();
    strokeWeight(2);
    fill(51, 51, 0);
    rect(635, 675, 70, 50 );
    fill(0);
    text("Vous avez trouvé! Appuyer sur 'V' pour jouer la vidéo ", 160, 628);
    coffre3 = false;
    break;
  }
  if ((key == 'v' || key == 'V') &&  coffre3 == false && tv == true) {
    frameRate(30);
    video.play();
    tv = false;
  }
  if(tv == false && coffre3 == false && stat == false){
    player3.pause();
  }
    
  if ((key == 'b' || key =='B') && coffre3 == true && coffre2 == false && gicleur == true){
    player1.play();
    spr = true;
  }
  if (coffre3 == false){
    player1.pause();
  }
}
  void typeIt(String s, int x, int y) {
  if (coffre1 == false && coffre2 == false && coffre3 == false && tv == false && stat == false && gicleur == false){
      if (lts<=s.length()) {
    text(s.substring(0, lts), x, y, 700, 300);
  } else {
    text(s, x, y, 700, 300);
  }
  }
}