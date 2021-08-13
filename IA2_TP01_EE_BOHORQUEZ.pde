/*
 Juan Bohórquez - TP01
 Informática Aplicada II -2021
 ATAM - UNA
 ------------------------------------------------
 
 */

//Osc
import oscP5.*;
OscP5 osc;

//Toxiclibs
import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.fluid.DwFluid2D;
DwFluid2D fluid;//Clase FLuido Toxiclibs
PGraphics2D pg_fluid;//Render Toxiclibs

//Color
float[] tintes = {78, 67, 151, 37, 220, 278}; 
color col;
float r, g, b;

//Tinta
int n = 15;
Tinta tintas_aux[];

Tinta c_col_inf;
Tinta c_col_sup;
Tinta c_blanco_A;
Tinta c_blanco_B;

//Sonido
float amp = 0;
float pitch = 0;
int delay = 0; //Binario

//Control y tiempo
boolean caux_in, blanco_in, color_in;
int ct, t0, tf;


public void setup() {
  size(600, 600, P2D);
  
  //Inicializo tiempo en 0
  ct = 0;
  t0 = 0;
  tf = 0;
  
  //Sonido
  osc = new OscP5(this, 12345);
  caux_in = false;
  blanco_in = false;
  color_in = false;
  
  
  //Inicializo color
  pushStyle();
  
  colorMode(HSB);
  col = color(181, 200, 255);
  colorMode(RGB);
  r = red(col)/255.0;
  g = green(col)/255.0;
  b = blue(col)/255.0;
  
  popStyle();
  
  
  //Inicio Tintas aleatorios
  tintas_aux = new Tinta[n];

  for ( int i=0; i < n; i++ ) {
    tintas_aux[i] = new Tinta(random(width), random(height));
  }
  c_col_inf = new Tinta(25, height);
  c_col_sup = new Tinta(width - 25, 0);
  c_blanco_A = new Tinta(width - 30, height - 300);
  c_blanco_B = new Tinta(width - 400, height - 30);
  
  frameRate(30); //Bajo un poco por rendimiento


  //-----------------------Toxiclibs-----------------------------------
  
  // library context
  DwPixelFlow context = new DwPixelFlow(this);

  // fluid simulation
  fluid = new DwFluid2D(context, width, height, 1);

  //fluid.param.dissipation_velocity = 0.99f; 
  //fluid.param.dissipation_density  = 0.99f;
  fluid.param.fluid_weight = 0.99f;
  fluid.param.num_jacobi_projection  = 30;
  fluid.param.num_jacobi_diffuse  = 15;
  fluid.param.vorticity = 0.30;

  // Cambio para mejorar rendimiento
  fluid.param.timestep = 0.50f;
  fluid.param.gridscale = 2.0f;


  //Agrego data al fluído según pasos en función click()
  fluid.addCallback_FluiData(
    new  DwFluid2D.FluidData() {
      public void update(DwFluid2D fluid) {
        data_in();
      }    
    }
  );

  pg_fluid = (PGraphics2D) createGraphics(600, 600, P2D);
}


public void draw() {
  //Tiempo en segundos (para guardar imagen)
  ct = millis()/1000;
  
  if (ct > t0){ //Emulo contador de seg
    tf++;
    t0 = ct;
  }

  // update simulation
  fluid.update();

  // clear render target
  pg_fluid.beginDraw();
  pg_fluid.background(0);
  pg_fluid.endDraw();

  // render fluid stuff
  fluid.renderFluidTextures(pg_fluid, 0); //param2 = 2 "cambia _blendmode_ del shader" (buscar sobre shaders, puppo,etc)

  // display
  image(pg_fluid, 0, 0);
  
}
