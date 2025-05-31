//////////////////////////////////////////////////////////////////TP3 DE ALEJANDRO TAMAYO - LEGAJO 122913/2 - DOCUMENTO 82224120
///////////////////////////////////////////////////////////////// TP3 (IPMI) - Video explícativo - Alejandro Tamayo - https://youtu.be/TIH7ExvvQqI?feature=shared
PImage referencia;
int cols = 10;
int rows = 10;
float baseSize = 20;
boolean efectoOndas = true;
boolean mostrarBoton = false;

void setup() {
  size(800, 400);
  referencia = loadImage("referencia.png");
  referencia.filter(GRAY);
}

void draw() {
  background(255);
  dibujarOpArt(0, 0, 400, height);
  image(referencia, 400, 0, 400, 400);

/////////////////////////////////////////////////////////////restart button
  if (mostrarBoton) {
    fill(200, 100, 100);
    rect(520, height - 50, 120, 30);
    fill(255);
    textAlign(CENTER, CENTER);
    text("Restart", 580, height - 35);
  }
}

/////////////////////////////////////////////////////////////////función que no retorna
void dibujarCirculo(float x, float y, float diam) {
  fill(0);
  ellipse(x, y, diam, diam);
}

//////////////////////////////////////////////////////////////función que sí retorna
float calcularDiametro(float x, float y) {
  float d = dist(x, y, mouseX, mouseY);
  float factor = efectoOndas ? sin(d * 0.05 + frameCount * 0.05) : cos(d * 0.05);
  return map(factor, -1, 1, 5, baseSize * 2);
}

void dibujarOpArt(float x, float y, float w, float h) {
  float cellW = w / cols;
  float cellH = h / rows;

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float cx = x + i * cellW + cellW / 2;
      float cy = y + j * cellH + cellH / 2;
      float diam = calcularDiametro(cx, cy);
      dibujarCirculo(cx, cy, diam);
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    efectoOndas = !efectoOndas;
  } else if (key == '+') {
    baseSize += 2;
  } else if (key == '-') {
    baseSize = max(5, baseSize - 2);
  } else if (key == 'r' || key == 'R') {
    reiniciar();
  }
}
//////////////////////////////////////////////////////seguimiento del mouse
void mousePressed() {
  if (mostrarBoton &&
      mouseX > 520 && mouseX < 640 &&
      mouseY > height - 50 && mouseY < height - 20) {
    reiniciar();
  }
}

/////////////////////////////////////////////////movimiento del mouse
void reiniciar() {
  baseSize = 20;
  efectoOndas = true;
}

///////////////////////////////////////////////////////////////reinicio del op art
void mouseMoved() {
  mostrarBoton = (mouseX > 400 && mouseY > height - 60);
}
