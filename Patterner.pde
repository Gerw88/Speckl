///////////////////////////////////////////////////////////////////////////////////
//                                                                               //
//                                                                               //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////

//import processing.svg.*;
//import processing.dxf.*;                     //library for exporting dxfs (will update with SVG library soon...)

char state = 'B';                            // A = Unpressed, B = Pressed - attempted checker pattern, buttons Q + E

PImage img;
float dotSize = 2;                          //default dot size = 2 px
float scale = 2;                            //depreciated
int incr = 4;                               // distance (in px) between centres
int e = 2;                                  // constrain for top output radius

void setup() {
  size(1190, 790, P3D);                      //start at image size
  surface.setResizable(true);

  img = loadImage("Mountain.jpg");
  img.get();
  ellipseMode(CENTER);

  noStroke();
}

void draw() {
  background(255);
  fill(0, 0, 225);  //the circles are blue

  if (img != null) {
    surface.setSize(2*img.width, 2*img.height);
    for (int y = 0; y < img.height; y += incr) {
      for (int x = 0; x < img.width; x += incr) {
        float val = (red(img.get(x, y)) + green(img.get(x, y)) + blue(img.get(x, y)))/3;
        float s = map(val, 0, 255, 1, e*scale);         //'s' is the individual radii of each circle in the array, ranging from "1" to "e"

        if (state == 'A') {       
          if ((x+y)%2==0) {                                    //if checkered is on, and x + y is even
            ellipse(x*scale, y*scale, s*dotSize, s*dotSize);
          }
        }
        if (state == 'B') { 
          //        fill(0);
          ellipse(x*scale, y*scale, s*dotSize, s*dotSize);
        }
      }
    }
  }
}

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

    case('x'):              //"x" to export
    export("output.dxf", "dxf");
    delay(1500);            //holds for 1.5 secs before closing
    exit();
    break;

    case('z'):              //"z" to export dxf
    expor();
    delay(1500);            //holds for 1.5 secs before closing
    exit();
    break;
  }
}

void export(String f, String kind) {
  if (kind == "dxf") {
    println("generating pattern ... ");  
    beginRaw(DXF, f);

    noFill();
    stroke(0);

    for (int y=0; y<img.height; y+=incr) {
      for (int x=0; x<img.width; x+=incr) {
        float val = (red(img.get(x, y)) + green(img.get(x, y)) + blue(img.get(x, y)))/3;        // average of RGB values
        float s = map(val, 0, 255, 1, e*scale);                                              //'s' is the individual radii of each circle in the array, ranging from "1" to "e"
        ellipse(x*scale, y*scale, s*dotSize, s*dotSize );
      }
    }

    endRaw();                                                                               // stop and save dxf
    dispose();
    println("... done exporting.");
  }

  //
  //if (kind == "svg") {
  //
  //}
}

void expor() {
  dxfHeader();

  for (int y = 0; y < img.height; y += incr) {
    for (int x = 0; x < img.width; x += incr) {
      float val = (red(img.get(x, y))+green(img.get(x, y)) + blue(img.get(x, y)))/3;
      float s = map(val, 0, 255, 1, e*scale);
      dxfCircle(x*scale, y*scale, 1, 1, s*dotSize, "Layer 1");
    }
  }
  dxfEnd();

  saveStrings("export2.dxf", expDxf);
}



void delay(int delay)
{
  int time = millis();
  while (millis() - time <= delay);
}
