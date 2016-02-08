 
 int CYAN = color(0,255,255);
 int ORANGE = color(255,165,0);
 int YELLOW = color(255,255,0);
 int PURPLE = color(160,32,240);
 int BLUE = color(0,0,255);
 int RED = color(255,0,0);
 int GREEN = color(0,255,0);
 
Grid board, preview;
Interaction curr;
Shape next;
Shape[] shapes = new Shape[7];
int timer = 20;
int currTime = 0;
int score = 0;
int lines = 0;
int level = 1;
final int SPEED_DECREASE = 2;
boolean game_over = false;
 
void setup() {
  size(500, 690, P2D);
  textSize(25);
  shapes[0] = new Shape(4, new int[] {8,9,10,11}, CYAN);  // I
  shapes[1] = new Shape(3, new int[] {0,3,4,5}, BLUE);  // J
  shapes[2] = new Shape(3, new int[] {2,3,4,5}, ORANGE);  // L
  shapes[3] = new Shape(2, new int[] {0,1,2,3}, YELLOW);  // O
  shapes[4] = new Shape(4, new int[] {5,6,8,9}, GREEN);  // S
  shapes[5] = new Shape(3, new int[] {1,3,4,5,}, PURPLE);  // T
  shapes[6] = new Shape(4, new int[] {4,5,9,10}, RED);  // Z
  board = new Grid(20, 20, 321, 642, 20, 10);
  preview = new Grid(355, 20, 116, 58, 2, 4);
  next = shapes[(int)random(7)];
  loadNext();
}
 
void draw() {
  background(0);
  if (game_over) {
    text("GAME OVER\nSCORE: " + score, width/2 - 70, height/2 - 50);
    return; 
  }
  currTime++;
  if (currTime >= timer && board.animateCount == -1)
    curr.stepDown();
  preview.draw();
  board.draw();
  if (curr != null)
    curr.draw();
  next.preview();
  fill(0, 0, 255);
  text("LEVEL\n" + level, width - 150, 120);
  text("LINES\n" + lines, width - 150, 200);
  text("SCORE\n" + score, width - 150, 280);
}
 
void loadNext() {
  curr = new Interaction(next);
  next = shapes[(int)random(7)];
  currTime = 0;
}
 
void keyPressed() {
  if (curr == null || game_over)
    return;
  switch(keyCode) {
    case LEFT : curr.left(); break;
    case RIGHT : curr.right(); break;
    case UP : curr.rotate(); break;
    case DOWN : curr.down(); break;
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