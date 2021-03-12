import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public static final int NUM_ROWS = 30;
public static final int NUM_COLS = 40;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program
int widthScreen = 1200;
int heightScreen = 900;

public void setup () {
  size(1200, 900);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  buttons = new Life[NUM_ROWS][NUM_COLS];
  
  for(int r = 0; r < NUM_ROWS; r++) {
    for(int c = 0; c < NUM_COLS; c++) {
        buttons[r][c] = new Life(r,c);
    }
  }
  buffer = new boolean[NUM_ROWS][NUM_COLS];
}

public void draw () {
  background( 0 );
  for(int i = 0; i < NUM_ROWS; i++) {
    stroke(20);
    fill(255);
    line((widthScreen/NUM_ROWS)*i,0,(widthScreen/NUM_ROWS)*i, 1600);
  }
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  for(int r = 0; r < NUM_ROWS; r++) {
    for(int c = 0; c < NUM_COLS; c++) {
        if(countNeighbors(r,c) == 3) {
          buffer[r][c] = true;
        }
        else if(countNeighbors(r,c) == 2 && buttons[r][c].getLife()) {
          buffer[r][c] = true;
        }
        else {
          buffer[r][c] = false;
        }
        
     }
  }
  copyFromBufferToButtons();
  

}

public void keyPressed() {
  if(key == 'r' || key == 'R') {
     running = !running; 
  }
  if(key == 'e' || key == 'E') {
    running = !running;
    for(int r = 0; r < NUM_ROWS; r++) {
      for(int c = 0; c < NUM_COLS; c++) {
        buttons[r][c].setLife(false);  
      }
    }
    running = false;
  }
}

public void copyFromBufferToButtons() {
  for(int r = 0; r < NUM_ROWS; r++) {
    for(int c = 0; c < NUM_COLS; c++) {
      if(buffer[r][c] == true) {
         buttons[r][c].setLife(true); 
      }
      else {
        buttons[r][c].setLife(false);
    }
    }
  }
}

public void copyFromButtonsToBuffer() {
for(int r = 0; r < NUM_ROWS; r++) {
    for(int c = 0; c < NUM_COLS; c++) {
      if(buttons[r][c].getLife() == true) {
         buffer[r][c] = true; 
      }
      else {
        buffer[r][c] = false;
    }
    }
  }
}

public boolean isValid(int r, int c) {
   if(r >=  0 && r < NUM_ROWS) {
     if(c >= 0 && c < NUM_COLS) { 
       return true;
     }
    }
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbor = 0;
  if(isValid(row + 1, col) == true && buttons[row + 1][col].getLife() == true) {
    neighbor ++;
  }
  if(isValid(row - 1, col) == true && buttons[row - 1][col].getLife() == true) {
    neighbor ++;
  }
  if(isValid(row, col - 1) == true && buttons[row][col - 1].getLife() == true) {
    neighbor ++;
  }
  if(isValid(row, col + 1) == true && buttons[row][col + 1].getLife() == true) {
    neighbor ++;
  }
   if(isValid(row + 1, col + 1) == true && buttons[row + 1][col + 1].getLife() == true) {
    neighbor ++;
  }
   if(isValid(row + 1, col - 1) == true && buttons[row + 1][col - 1].getLife() == true) {
    neighbor ++;
  }
   if(isValid(row - 1, col + 1) == true && buttons[row - 1][col + 1].getLife() == true) {
    neighbor ++;
  }
   if(isValid(row - 1, col - 1) == true && buttons[row - 1][col - 1].getLife() == true) {
    neighbor ++;
  }
  return neighbor;
}



public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = widthScreen/NUM_COLS;
    height = heightScreen/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < 0.5; // 50% chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill( 150 );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    return alive;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
