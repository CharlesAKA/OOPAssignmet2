class Interaction extends Tetris{
  Shape shape;
  int x, y;
  int final_row;
   
  Interaction(Shape shape) {
    this.shape = new Shape(shape);
    x = 3;
    y = -2;
  }
   
  color getColor() { return shape.c; }
   
}