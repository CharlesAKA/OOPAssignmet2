class Interaction {
  Shape shape;
  int x, y;
  int final_row;
   
  Interaction(Shape shape) {
    this.shape = new Shape(shape);
    x = 3;
    y = -2;
    final_row = getFinalRow();
    gameOver = !Correct(this.shape.matrix, 3, -1);
  }
   
  color getColor() 
  { 
    return shape.c; 
  }
   
  void left() //to move left
  {
    if (Correct(shape.matrix, x - 1, y))
      x--;
    else if (Correct(shape.matrix, x - 2, y))
      x -= 2;
    update();
  }
   
  void right() {//to move right
    if (Correct(shape.matrix, x + 1, y))
      x++;
    else if (Correct(shape.matrix, x + 2, y))
      x += 2;
    update();
  }
   
  void update() {//reset time of at the bottom
    final_row = getFinalRow();
    if (y == final_row)
      currTime = -20;
  }
   
  void down() {//to go done one step faster
    if (y >= final_row) {
      // if already at the bottom, down shortcuts to lock current and load next block
      board.endTurn();
    } else {
      stepDown();
      score += 1;  // get a point for manual down
    }
  }
   
  // used when automatically moving the block down.
  void stepDown() {
    if (y >= final_row) {
      board.endTurn();
    } else {
      y++;
      currTime = 0;
    }
  }
   
  // move block all the way to the bottom
  void hardDown() {
    score += (board.rows - y);
    y = final_row;
    board.endTurn();
  }
   
  void rotate() {
    boolean[][] ret = new boolean[shape.matrix.length][shape.matrix.length];
    for (int x = 0; x < ret.length; ++x)
        for (int y = 0; y < ret.length; ++y)
            ret[x][y] = shape.matrix[y][ret.length - 1 - x];
    if (Correct(ret, x, y)) {
      shape.matrix = ret;
      update();
    } else if (Correct(ret, x + 1, y) || Correct(ret, x + 2, y)) {
      shape.matrix = ret;
      right();
    } else if (Correct(ret, x - 1, y) || Correct(ret, x - 2, y)) {
      shape.matrix = ret;
      left();
    }
  }
   
  int getFinalRow() {
    int start = max (0, y);
    for (int row = start; row <= board.rows; ++row)
      if (!Correct(shape.matrix, x, row))
        return row - 1;
    return -1;
  }
   
  boolean Correct(boolean[][] matrix, int col, int row) {
    for (int i = 0; i < matrix.length; ++i)
      for (int j = 0; j < matrix.length; ++j)
        if (matrix[i][j] && board.isOccupied(col + i, row + j))
          return false;
    return true;
  }
   
  void draw() {
    for (int i = 0; i < shape.matrix.length; ++i) {
      for (int j = 0; j < shape.matrix.length; ++j) {
        if (shape.matrix[i][j]) {
          board.fillSquare(x + i, y + j, shape.c);
          board.outlineSquare(x + i, final_row + j);
        }
      }
    }
  }
}