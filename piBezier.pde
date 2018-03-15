
import processing.pdf.*;

boolean exportPDF = false;
int frames = 1000;
float beziMultiplier = 0.5;
float sizeMultiplier = 0.8;

String pi;
int[] digits;
int index = 0;
int minScreenDim;

void setup() {
  size(1200, 800);
  minScreenDim = min(height, width);
  if(exportPDF) {
    println("Exporting to pdf...");
    beginRecord(PDF, "piBezier.pdf");
  }
  pi = loadStrings("pi1000000.txt")[0];
  digits = int(pi.split(""));
  background(0);
  noFill();
  stroke(255, 120);
  strokeWeight(10);
  //ellipse(width / 2, height / 2, minScreenDim * sizeMultiplier, minScreenDim * sizeMultiplier);
  ellipse(width / 2, height / 2, minScreenDim * sizeMultiplier, minScreenDim * sizeMultiplier);
  strokeWeight(0.1);
}

void draw() {
  if(index % frames == 0 && index != 0) {
    println(index / 1000 + "k digits");
    text("2018 © olback.net", 10, height - 12);
    println("Drawing complete.");
    noLoop();
    if(exportPDF) {
      println("Export complete.");
      endRecord();
    }
  }

  int digit = digits[index];
  int nextDigit = digits[index+1];
  index++;

  /* Don't draw a line to yourself */
  if(digit == nextDigit) {
    return;
  }

  if(max(digit, nextDigit) - min(digit, nextDigit) == 5) {
    return;
  }

  float a1 = map(digit, 0, 10, 0, TWO_PI);
  float a2 = map(nextDigit, 0, 10, 0, TWO_PI);
  a1 += random(-0.27, 0.27);

  switch(digit) {
    case 0:
      stroke(28, 68, 89);
      break;

    case 1:
      stroke(75, 163, 224);
      break;

    case 2:
      stroke(72, 117, 32);
      break;

    case 3:
      stroke(102, 211, 95);
      break;

    case 4:
      stroke(102, 5, 4);
      break;

    case 5:
      stroke(229, 28, 30);
      break;

    case 6:
      stroke(144, 82, 2);
      break;

    case 7:
      stroke(255, 127, 0);
      break;

    case 8:
      stroke(65, 41, 77);
      break;

    case 9:
      stroke(146, 101, 194);
      break;

    default:
      stroke(255);
  }

  float x1 = (minScreenDim / 2) * sizeMultiplier * 0.9 * cos(a1);
  float y1 = (minScreenDim / 2) * sizeMultiplier * 0.9 * sin(a1);
  float cpx1 = (minScreenDim / 2) * beziMultiplier * 0.9 * cos(a1);
  float cpy1 = (minScreenDim / 2) * beziMultiplier * 0.9 * sin(a1);

  float x2 = (minScreenDim / 2) * sizeMultiplier * 0.9 * cos(a2);
  float y2 = (minScreenDim / 2) * sizeMultiplier * 0.9 * sin(a2);
  float cpx2 = (minScreenDim / 2) * beziMultiplier * 0.9 * cos(a2);
  float cpy2 = (minScreenDim / 2) * beziMultiplier * 0.9 * sin(a2);

  translate(width / 2, height / 2);
  //text(digit, x1, y1);
  bezier(x1, y1, cpx1, cpy1, cpx2, cpy2, x2, y2);

}