import controlP5.*;

ControlP5 cp5;

PVector offset = new PVector(0, 0);
PVector mouseOffset = new PVector(0, 0);
Slider horizontal;
Slider vertical;

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
  
  background(color(100));
  
  rect(mouseX, mouseY, 10, 10);
  
  int offsetX = int(offset.x);
  int offsetY = int(offset.y);
  
  for (int i = offsetX; i < offsetX + width + 50; i += 50) {
    line(snap(i, 50) - offset.x, 0, snap(i, 50) - offset.x, height);    
  }
  for (int i = -offsetY; i < -offsetY + height; i += 25) {
    line(0, snap(i, 25) + offset.y, width, snap(i, 25) + offset.y);    
  }
  
  
  rect(100 - offset.x, 100 + offset.y, 100, 100);
  
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
void mousePressed()
{
  if (mouseButton == CENTER) {
    dragging = true;
    dragOrigin = new PVector(mouseX + offset.x, offset.y - mouseY);
  }
}

void mouseDragged()
{
  if (dragging) {
    horizontal.setValue(-mouseX + dragOrigin.x);
    vertical.setValue(mouseY + dragOrigin.y);
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