//Funciones 

void data_in() { 
    
    // Pinto fluído color
    if (amp > 65 && color_in) { 
      //Chorro inferior
      c_col_inf.Acolor(r, g, b);
      c_col_inf.dir = radians(45);
      c_col_inf.mover("diag");      
      pintar(c_col_inf);
      
      //Chorro superior
      c_col_sup.Acolor(r, g, b);
      c_col_sup.dir = radians(225);
      c_col_sup.mover("diag");
      pintar(c_col_sup);
     }
    
    
    // Pinto flúido blanco
    if (amp > 65 && blanco_in) {  
      c_blanco_A.Acolor(255,255,255);
      c_blanco_A.dir = radians(225);
      c_blanco_A.mover("espa");
      pintar(c_blanco_A);
      
      c_blanco_B.Acolor(255,255,255);
      c_blanco_B.dir = radians(55);
      c_blanco_B.mover("espa");
      pintar(c_blanco_B);
     }
    
    
    // Pinto fluídos "auxiliares"
    if(delay == 1){
      // Si hay delay dibujar fluído auxiliar
      int index = int(random(n));    
      Tinta c_ale = tintas_aux[index];
      
      if(amp > 86.0){
        c_ale.Acolor(255,255,255); //Blanco si sonido muy fuerte
      }
      else{
        c_ale.Acolor(0,0,0); // Negro 
      }
      
      c_ale.dir = radians(random(225,315));
      c_ale.mover("extra");
      pintar(c_ale);
      delay = 0;  
    }
    
    guardar();
}

void guardar(){
  // Guarda imagen
  
    if(amp > 65.0){ //Reinicia cuenta de tiempo si hay sonido mayor a 65.0
      tf = 0;
    }
    
    if (tf > 6){
      //SI tiempo supera los 6 seg guarda la imagen (crea carpeta imgs y guarda frame del sketch) 
      save("imgs/fluido" + millis()/100 + ".png");
      
      //Reinicia el lienzo y cambia color principal 
      pushStyle();
      colorMode(HSB);
      int index = int(random(tintes.length)); //Elige al azar entre colores predeterminados para la serie
      col = color(tintes[index], 255, 255);
      colorMode(RGB);
      r = red(col)/255.0;
      g = green(col)/255.0;
      b = blue(col)/255.0;
      popStyle();  
  
      fluid.reset(); // función reinicio de Toxiclibs
      tf = 0; //reinicia conteo de segundos.
      
      
    }

}

void pintar(Tinta c) {
  
  float px     = c.posX;
  float py     = height - c.posY;
  float vx     = c.dx * c.fuerza;
  float vy     = c.dy * c.fuerza;
  
  fluid.addDensity(px, py, c.radio, c.r, c.g, c.b, 1.0f); 
  fluid.addVelocity(px, py, c.radio, vx, vy);
}

void  oscEvent (OscMessage m) {

  if (m.addrPattern().equals("/amp")) {
    amp = m.get(0).floatValue();   
    caux_in = amp > 80.0;
    
  } else if (m.addrPattern().equals("/pitch")) {
    pitch = m.get(0).floatValue();
    blanco_in = pitch > 65.0;
    color_in = pitch < 65.0 && pitch > 40.0;
    
  } else if (m.addrPattern().equals("/dly")){
    delay = m.get(0).intValue();
    
  }
  
}
