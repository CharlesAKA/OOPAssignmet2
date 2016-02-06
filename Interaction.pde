class Interaction extends Tetris{
  Shape shape;
  int x, y;
  int final_row;
   
  Interaction(Shape shape) {
    this.shape = new Shape(shape);
    x = 3;
    y = -2;
    final_row = getFinalRow();
    game_over = !isLegal(this.shape.matrix, 3, -1);
  }
   
  color getColor() { return shape.c; }
  
  void left() {
    if (isLegal(shape.matrix, x - 1, y))
      x--;
    else if (isLegal(shape.matrix, x - 2, y))
      x -= 2;
    update();
  }
   
  void right() {
    if (isLegal(shape.matrix, x + 1, y))
      x++;
    else if (isLegal(shape.matrix, x + 2, y))
      x += 2;
    update();
  }
   
  void update() {
    final_row = getFinalRow();
    // reset the timer
    if (y == final_row)
      currTime = -20;
  }
   
  // used when player presses down.
  void down() {
    if (y >= final_row) {
      board.endTurn();
    } else {
      stepDown();
      score += 1;  
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
  
  int getFinalRow() {
    int start = max (0, y);
    for (int row = start; row <= board.rows; ++row)
      if (!isLegal(shape.matrix, x, row))
        return row - 1;
    return -1;
  }
   
  boolean isLegal(boolean[][] matrix, int col, int row) {
    for (int i = 0; i < matrix.length; ++i)
      for (int j = 0; j < matrix.length; ++j)
        if (matrix[i][j] && board.isOccupied(col + i, row + j))
          return false;
    return true;
  }
}