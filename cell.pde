class Cell
{
  final static int CELL_STATE_NONE = 0;

  Cell[] neighbors;

  int count;

  int index;

  int indexX;
  int indexY;

  float positionX;
  float positionY;

  boolean isActive;

  int state;
  int statePrevious;
  int stateNext;

  float probability;

  float timeStart;
  float timeFrame;
  float timeElapsed;
  float timeActive;

  Automaton system;

  Cell()
  {
    neighbors = new Cell[8];
    init();
  }

  void init()
  {
    state = statePrevious = stateNext = 0;
    isActive = true;
  }

  void update()
  {
    timeElapsed = (millis() - timeFrame) / 1000;
    timeFrame = millis();
    timeActive = timeFrame - timeStart;
  }

  void evolve()
  {
    statePrevious = state;
    state = stateNext;
  }

  void render(){}

  void print(String tag)
  {
    println("cell " + tag + " (" + indexX + " " + indexY + " " + positionX + " " + positionY + " " + state + ")");
  }
}