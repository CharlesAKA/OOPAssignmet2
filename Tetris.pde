import controlP5.*;//allows you to create a button
 int Azzur = color(0,255,255);
 int Blue = color(0,0,255);
 int Orange = color(255,165,0);
 int Green = color(0,255,0);
 int Purple = color(160,32,240);
 int Red = color(255,0,0);
 int Yellow = color(255,255,0);
 
ControlP5 cp5;
Grid board, preview;
Interaction curr;
Shape next;
Shape[] shapes = new Shape[7];
int timer = 20;
int currTime = 0;
int score = 0;
int lines = 0;
int level = 1;
boolean gameOver = false;
int Slow = 2;
 
void setup() {
  size(500, 690, P2D);
  textSize(20);
  cp5 = new ControlP5(this);
  cp5.addButton("play", 1, width/2 + 135, height/2, 70, 20).setLabel("play again");
  shapes[0] = new Shape(4, new int[] {8,9,10,11}, Orange);  
  shapes[1] = new Shape(3, new int[] {0,3,4,5}, Yellow);  
  shapes[2] = new Shape(3, new int[] {2,3,4,5}, Red);  
  shapes[3] = new Shape(2, new int[] {0,1,2,3}, Purple);  
  shapes[4] = new Shape(4, new int[] {5,6,8,9}, Green);  
  shapes[5] = new Shape(3, new int[] {1,3,4,5,}, Azzur);  
  shapes[6] = new Shape(4, new int[] {4,5,9,10}, Blue);  
  board = new Grid(20, 20, 321, 642, 20, 10);
  preview = new Grid(355, 20, 116, 58, 2, 4);
  next = shapes[(int)random(7)];
  loadNext();
}





void draw() {
  background(0);
  if (gameOver) {
    text("GAME OVER!!\bSCORE: " + score, width/2 - 200, height/2 + 20);
    cp5.draw();
    return;
  }//display the game over screen, your score and option to play again
  currTime++;
  if (currTime >= timer && board.animateCount == -1)
    curr.stepDown();
  preview.draw();
  board.draw();
  if (curr != null)
    curr.draw();
  next.preview();
  fill(255);
  text("LEVEL\n" + level, width - 150, 120);
  text("LINES\n" + lines, width - 150, 200);
  text("SCORE\n" + score, width - 150, 280);
  text("INSTRUCTIONS:\n\nW = roatate\nA = left\nD = right\nS = down\nSpace = drop\nZ = Pause\nC = Play", width - 150, 400);
}//displays functional game, information on score and level and instructions on how to play
 
void loadNext() {
  curr = new Interaction(next);
  next = shapes[(int)random(7)];
  currTime = 0;
}
 
void keyPressed() {
  if (key == 'z' || key == 'Z') {
    text("GAME PAUSED!!!", width/2 - 150, height/2);
    noLoop();   
   }
  if (key == 'c' || key == 'C') {
   loop();   
   }
 
  if (curr == null || gameOver)
    return;
  switch(keyCode) {
    case 'A' : curr.left(); break;
    case 'D' : curr.right(); break;
    case 'W' : curr.rotate(); break;
    case 'S' : curr.down(); break;
    case ' ' : curr.hardDown(); break;
  }
}

 
void play(int value) {
  board.clear();
  score = 0;
  level = 1;
  lines = 0;
  loadNext();
}