import controlP5.*;

ControlP5 cp5;

PVector offset = new PVector(0, 0);
PVector mouseOffset = new PVector(0, 0);
Slider horizontal;
Slider vertical;

int data[][] = new int[1000][1000];

void setup()
{
  size(700, 400);
  cp5 = new ControlP5(this);
  horizontal = cp5.addSlider("H")
    .setPosition(0, height - 20)
    .setSize(width - 20, 20)
    .setRange(0, 1000)
    ;
  vertical = cp5.addSlider("V")
    .setPosition(width - 20, 0)
    .setRange(0, 1000)
    .setSize(20, height - 20)
    .setValue(0)
    ;
}

void draw()
{
  offset = new PVector(horizontal.getValue(), vertical.getValue()); 
  mouseOffset = new PVector(mouseX + offset.x, mouseY + offset.y);
  
  background(color(50));
  
  rect(mouseX, mouseY, 10, 10);
  
  int offsetX = int(offset.x);
  int offsetY = int(offset.y);
  
  stroke(color(140));
  for (int i = offsetX; i < offsetX + width + 50; i += 50) {
    line(snap(i, 50) - offset.x, 0, snap(i, 50) - offset.x, height);    
  }
  for (int i = -offsetY; i < -offsetY + height; i += 25) {
    line(0, snap(i, 25) + offset.y, width, snap(i, 25) + offset.y);    
  }

  
  for (int i = offsetX; i < offsetX + width + 50; i += 50) {
    int cellX = max(i / 50, 0);

    for (int j = -offsetY; j < -offsetY + height; j+= 25) {
      int cellY = max(j / 25, 0);
      if (data[cellX][cellY] != 0) {
        fill(color(data[cellX][cellY]));
        rect(snap(i, 50) - offset.x, snap(j, 25) + offset.y, 50, 25);
      }

      fill(color(90));
      text(cellX + ", " + cellY, snap(i, 50) - offset.x, snap(j, 25) + offset.y, 0);
    }
  }

  
  rect(100 - offset.x, 100 + offset.y, 100, 100);
  
  //rect(snap(mouseX + offsetX, 50) - offsetX, snap(mouseY - offsetY, 25) + offsetY, 50, 25);
  
  int selectedX = mouseX + offsetX;
  int selectedY = mouseY - offsetY;
  
  text(selectedX / 50 + ", " + selectedY / 25, 10, 10, 70, 80);
  

}

int snap(int val, int snap) {
  return int(val / snap) * snap;
}

void mouseWheel(MouseEvent event)
{
  
  vertical.setValue(vertical.getValue() - event.getCount() * 10);
}

boolean dragging = false;
PVector dragOrigin;

void mouseClicked()
{
}

void mousePressed()
{
  if (mouseButton == CENTER) {
    dragging = true;
    dragOrigin = new PVector(mouseX + offset.x, offset.y - mouseY);
  }
  else if (mouseButton == LEFT) {
    int clickX = int((mouseX + offset.x) / 50);
    int clickY = int((mouseY - offset.y) / 25);
    data[clickX][clickY] = 0xFF; 
  }
}

void mouseDown()
{

}

void mouseDragged()
{
  if (mouseButton == CENTER && dragging) {
    horizontal.setValue(-mouseX + dragOrigin.x);
    vertical.setValue(mouseY + dragOrigin.y);
  }
  else if (mouseButton == LEFT) {
    int clickX = int((mouseX + offset.x) / 50);
    int clickY = int((mouseY - offset.y) / 25);
    data[clickX][clickY] = 0xFF;    
  }
}

void mouseReleased()
{
  if (mouseButton == CENTER) {
    dragging = false; 
  }
}


PVector toOffset(PVector pos)
{
  return new PVector(pos.x - offset.x, pos.y + offset.y);
}

void loop()
{
  
}