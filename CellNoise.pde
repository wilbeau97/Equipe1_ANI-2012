class CellNoise extends Cell
{
  color colorFill;

  color colorFillA;
  color colorFillB;

  float sum;

  int average;

  CellNoise()
  {
    super();
    init();
  }

  void init()
  {
    colorFill = #FFFFFF;

    state = int((positionX / width * 255 + positionY / height * 255) / 2);

    statePrevious = state;
  }

  void update()
  {
    super.update();

    sum = 0;

    for (index = 0; index < 8; ++index)
    {
      sum += neighbors[index].state;
    }

    average = int(sum / 8.0f);

    stateNext = int(state + average - statePrevious);

    if (stateNext > 255)
      stateNext -= 255;
    else if (stateNext < 0)
      stateNext += 255;
  }

  void render()
  {
    colorFill = stateNext;

    fill(colorFill, system.alpha);

    rect(
      positionX,
      positionY,
      system.size,
      system.size);
  }
}