class Automaton
{
  final static int TYPE_CELL_NONE    = 0;
  final static int TYPE_CELL_NOISE   = 1;

  int type;

  int alpha;

  int sizeX;
  int sizeY;

  int count;
  int index;

  int frame;

  float size;

  float timeFrame;
  float timeElapsed;
  float timeDelay;
  float timeDuration;

  ArrayList<Cell> system;

  Cell[][] grid;

  Cell cell;

  Automaton()
  {
    type  = TYPE_CELL_NOISE;

    sizeX = 10;
    sizeY = 10;

    size = width/resolution;

    timeDuration = 1.0f;

    init();
  }

  Automaton(int t, int x, int y, float s, float f, int a)
  {
    type = t;

    sizeX = x;
    sizeY = y;

    size = s;

    timeDuration = f;

    alpha = a;

    init();
  }

  void init()
  {
    system = new ArrayList<Cell>();
    grid = new Cell[sizeX][sizeY];

    count = sizeX * sizeY;

    for (index = 0; index < count; ++index)
    {
      switch (type)
      {
        case TYPE_CELL_NOISE:
          cell = new CellNoise();
          break;
      }

      cell.indexX = index % sizeX;
      cell.indexY = index / sizeX;

      cell.positionX = cell.indexX * size;
      cell.positionY = cell.indexY * size;

      cell.system = this;

      system.add(cell);

      grid[cell.indexX][cell.indexY] = cell;
    }

    computeNeighborhood();

    timeFrame = millis();
    timeDelay = 0;

    frame = 0;

    print("ready");
  }

  void update()
  {
    timeElapsed = (millis() - timeFrame) / 1000;
    timeDelay += timeElapsed;
    timeFrame = millis();

    if (timeDelay > timeDuration)
    {
      timeDelay = 0;

      for (index = 0; index < count; ++index)
      {
        cell = system.get(index);
        cell.update();
      }

      for (index = 0; index < count; ++index)
      {
        cell = system.get(index);
        cell.evolve();
      }
    }

    for (index = 0; index < count; ++index)
    {
      cell = system.get(index);
      cell.render();
    }

    if (frame % 100 == 0)
    {
      if (systemIsStable())
      {
        println("system is now stable > restart");
        restart();
      }
    }

    ++frame;
  }

  void computeNeighborhood()
  {
    for (int x = 0; x < sizeX; ++x)
    {
      for (int y = 0; y < sizeY; ++y)
      {
        int up    = y-1;
        int down  = y+1;
        int left  = x-1;
        int right = x+1;

        up    = up    <  0     ? sizeY -1 : up;
        down  = down  >= sizeY ? 0        : down;
        left  = left  <  0     ? sizeX -1 : left;
        right = right >= sizeX ? 0        : right;

        grid[x][y].neighbors[0] = grid[left ][up];
        grid[x][y].neighbors[1] = grid[x    ][up];
        grid[x][y].neighbors[2] = grid[right][up];
        grid[x][y].neighbors[3] = grid[left ][y];
        grid[x][y].neighbors[4] = grid[right][y];
        grid[x][y].neighbors[5] = grid[left ][down];
        grid[x][y].neighbors[6] = grid[x    ][down];
        grid[x][y].neighbors[7] = grid[right][down];
      }
    }
  }

  boolean systemIsStable()
  {
    int cellStateCurrent;
    int cellStatePrevious = system.get(0).state;

    for (index = 1; index < count; ++index)
    {
      cell = system.get(index);
      cellStateCurrent = cell.state;

      if (cellStateCurrent != cellStatePrevious)
        return false;
      else
        cellStatePrevious = cellStateCurrent;
    }
    return true;
  }

  void restart()
  {
    for (index = 0; index < count; ++index)
    {
      cell = system.get(index);
      cell.init();
    }
  }

  void print(String tag)
  {
    println("cellular automaton " + tag + " (size x: " + sizeX + " size y: " + sizeY + " cell count: " + count + ")");
  }
}