///////////////////////////////////////////////////////////////////////////////////
//                                                                               //
//                                                                               //
//                             by Gerard Walsh 2015                              //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////

//********** Global Variables **********//

char state = 'B';                           // A = Unpressed, B = Pressed - attempted checker pattern, buttons Q + E
boolean isAltPressed = false;               // Checks if alt is pressed, for keybindings

PImage img;
float dotSize = 2;                          //default dot size = 2 px
float scale = 2;                            //depreciated
int incr = 4;                               // distance (in px) between centers, default: 4 px
int e = 2;                                  // constrain for top output radius
int Count, xCount, yCount;

//********** Setup **********//

void setup() {
  size(1200, 800, P3D);                      //start at image size
  surface.setResizable(true);

  img = loadImage("Mountain.jpg");
  img.get();
  ellipseMode(CENTER);

  noStroke();
}

//********** Draw **********//

void draw() {
  background(255);
  fill(0, 0, 225);                          //the circles are blue

  if (img != null) {
    surface.setSize(2*img.width, 2*img.height);
    for (int y = 0; y < img.height; y += incr) {
      for (int x = 0; x < img.width; x += incr) {
        float val = (red(img.get(x, y)) + green(img.get(x, y)) + blue(img.get(x, y)))/3;
        float s = map(val, 0, 255, 1, e*scale);         //'s' is the individual radii of each circle in the array, ranging from "1" to "e"

        if (state == 'A') {       
          if ((x+y)%2==0) {                   //if checkered is on, and x + y is even
            ellipse(x*scale, y*scale, s*dotSize, s*dotSize);
          }
        }
        if (state == 'B') {
          ellipse(x*scale, y*scale, s*dotSize, s*dotSize);
        }
      }
    }
  }

//********** Show Element Count **********//
    
    xCount = ceil(float(img.width)/float(incr));
    yCount = ceil(float(img.height)/float(incr));
    Count = xCount * yCount;
    
    println("x count = " + xCount);
    println("y count = " + yCount);
    println("element count = " + Count);
    
  textAlign(LEFT, TOP);
  textSize(40);
  fill(255, 150);

  rect(0, 10, 2*img.width, 50);

  fill(0);
  text(Count + " elements, " + xCount + " xpx, " + yCount + " ypx.", 10, 10);
}

//********** Key Bindings **********//

void keyPressed() {
  switch(keyCode) {
  case UP:
    scale *= 1.0;                            //default 1.2
    scale = constrain(scale, 0.5, 100000);
    break;

  case DOWN:
    scale /= 1.0;                            //default 1.2
    scale = constrain(scale, 0.5, 100000);
    break;

  case RIGHT:
    incr+=1;
    incr = constrain(incr, 1, 100000);

    break;

  case LEFT:
    incr-=1;
    incr = constrain(incr, 1, 100000);
    break;
  }  
  switch(key) {

    case('w'):              //"w" increases radius of circles
    dotSize+=0.3;  
    dotSize = constrain(dotSize, 0, 100000);
    break;

    case('s'):              //"s" decreases radius of circles
    dotSize-=0.3;  
    dotSize = constrain(dotSize, 0, 100000);
    break;

    case('d'):              //"d" increases "e", max radius
    e+=1;       
    e = constrain(e, 1, 100000);
    break;

    case('a'):              //"a" decreases "e", max radius
    e-=1;       
    e = constrain(e, 1, 100000);
    break;

    case('x'):              //"x" to export dxf, "alt + x" to export svg
    if (isAltPressed == false) export("dxf");
    if (isAltPressed == true) export("svg");
    delay(1500);            //holds for 1.5 secs before closing
    exit();
    break;
  }
  
  if (keyCode == ALT && isAltPressed == false) isAltPressed = true;
}

void keyReleased() {
  if (keyCode == ALT) isAltPressed = false;
}

//********** Functions **********//

void export(String kind) {

  println("generating pattern ... ");
  
  if (kind == "dxf") {
    dxfHeader();

    for (int y = 0; y < img.height; y += incr) {
      for (int x = 0; x < img.width; x += incr) {
        float val = (red(img.get(x, y))+green(img.get(x, y)) + blue(img.get(x, y)))/3;
        float s = map(val, 0, 255, 1, e*scale);
        dxfCircle(x*scale, y*scale, 1, 1, s*dotSize, "Layer 1");
      }
    }
    dxfEnd();

    println("exporting dxf ... ");
    saveStrings("export2.dxf", expDxf);
  }

  if (kind == "svg") {
    //svgHeader();
    
    //loop this:
    //svgEllipse(int cx, int cy, int rx, int ry)
    
    //svgEnd();
    println("exporting svg ... ");
    //saveXML(expSVG, "export.svg");
  }

  println("... done exporting.");
}


void delay(int delay)
{
  int time = millis();
  while (millis() - time <= delay);
}
