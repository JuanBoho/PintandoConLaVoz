
class Tinta {

  float posX, posY, vel, dir, dx, dy, r, g, b, col, fuerza,radio;
  float amplitudAngular = 0.6;
  String tipo_;

  Tinta(float x0_, float y0_) {
    posX = x0_;
    posY = y0_;
    vel = 10;
    radio = 25;
  }


  void Acolor(float rojo, float verde, float azul) {
    r = rojo;
    g = verde;
    b = azul;
  }
  
  void mover(String movimiento_) {    
    String mov = movimiento_;

    if (mov.equals("diag")) {
      this.movDiagonal();
    }else if (mov.equals("espa")) {
      this.movEsparcir(); 
    } else if (mov.equals("extra")) {
      this.movAleatorio();
    }
    
  }
  
  void movDiagonal() {
    fuerza = 7;
    dx = vel * cos( dir );
    dy = vel * sin( dir );
  }

  void movEsparcir() {
    vel = 5;
    radio = 25;
    fuerza = 3.5;
    dx = vel * sin( dir );
    dy = vel * cos( dir );
  }
  
  void movAleatorio() {
    radio = 15;
    fuerza = 6;
    dir = radians(random(225,315));
    vel = 20;
    dx = vel * cos( dir );
    dy = vel * sin( dir );
    
    posX += dx;
    posY += dy;
    
  }

}
