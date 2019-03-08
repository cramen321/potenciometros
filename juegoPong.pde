//        XOR MEDIA LAB

//--------------------------Librerias---------------------------
 import processing.serial.*;
 
 Serial port;
//---------------------------Varibles--------------------------
//posicion en y del jugador 1
float posicionY1;
//ubicacion del jugador1 en el centro
float ubicY1;

//posicion en y del jugador 2
float posicionY2;
//ubicacion del jugador2 en el centro
float ubicY2;

//posicion en y del jugador 3
float posicionY3;
//ubicacion del jugador3 en el centro
float ubicY3;

//posicion en y del jugador 4
float posicionY4;
//ubicacion del jugador4 en el centro
float ubicY4;

//ubicacion de la bola
float x=150;
float y=30;

//TAMAÑOS del jugador
int ancho=48;
int alto =150;

//dirección para el rebote de la bola
int dir=1;
int dir2=1;

//valores de los sensores de wiring como input
String sensores;
int potenciometro1;
int potenciometro2;
int potenciometro3;
int potenciometro4;

int vel = 5;

//--------------------------- Setup ---------------------------
void setup()
{
    size(1024, 768);
  
    noStroke();
   port= new Serial(this, Serial.list()[0],9600);
   //port = new Serial(this, "/dev/cu.usbmodem14231", 9600); 
   
}


//------------------------Gráfica-----------------------------
void draw()
{
  //Color de fondo
  background(0);

  //dibuja la bola
  stroke(255);
  fill(255);
  ellipse(x,y,15,15);

  //velocidad de la bola
  x=x+vel*dir;
  y=y+vel*dir2; 

  //si la bola se sale de la pantalla por la pared derecha, vuelva y aparesca desde la pared izkierda
  if(x>1024)  
  {
    x= width/2;    
    y = random (0,768);
  }
  
  //si la bola pega contra la pared de arriba o de abajo rebota es decir cambia de dirección
  if((y>750)||(y<0))
  {
    dir2=dir2*-1;
  }

  //si la bola se sale de la pantalla por la pared izkierda, vuelva y aparesca desde la pared derecha
  if(x<0)
  {
    x= width/2;    
    y = random (0,768);
  }


  
  //ubicacion del jugador con el sensor de wiring
  if (0 < port.available()) 
  { 
    
    //otra forma de enviar los datos a processing es no usando serial.write, sino serial.println, sin embargo en processing no se utiliza port.read(), sino port.readStringUntil('\n');
    sensores =  port.readStringUntil('\n');    
        
    if(sensores != null)
    {
      println(sensores);
      //se crea un arreglo que divide los datos y los guarda dentro del arreglo, para dividir los datos se hace con split cuando le llegue el caracter 'T',
      String[] datosSensor = split(sensores,'T');
      
      if(datosSensor.length == 4)
      {
        println(datosSensor[0]);
        println(datosSensor[1]);
        println(datosSensor[2]);
        println(datosSensor[3]);
        potenciometro1 = int(trim(datosSensor[0]));      
        potenciometro2 = int(trim(datosSensor[1]));
        potenciometro3 = int(trim(datosSensor[2]));
        potenciometro4 = int(trim(datosSensor[3]));
      }     
    }
    
    posicionY1 = map(potenciometro1,0,255,300,0);
    posicionY2 = map(potenciometro2,0,255,300,0);
    posicionY3 = map(potenciometro3,0,255,768,470);
    posicionY4 = map(potenciometro4,0,255,768,470);
  }
  
  //jugar con el mouse
  //posicionY1 = mouseY;
  
  // jugador 1
  ubicY1 = posicionY1-(alto/2);
  rect(0,ubicY1,ancho,alto);
  
  //jugar con el mouse
  //posicionY2 = mouseY;
  
  // jugador 2
  ubicY2 = posicionY2-(alto/2);
  rect(width-ancho,ubicY2,ancho,alto);
  
  //jugador3
  ubicY3= posicionY3-(alto/2);
  fill(255,40,40);
  rect(width-ancho,ubicY3,ancho,alto);

  //jugador4
  ubicY4= posicionY4-(alto/2);
  fill(255,40,40);
  rect(0,ubicY4,ancho,alto);

  //dibujar cancha
  strokeWeight(10); 
  noFill();
  stroke(255,0,0);
  rect(0,0,1024,768);

  //REBOTA SI LA PELOTA ESTA CERCA DEL MURO IZQUIERDO
  if(x > 0 && x <= ancho+20)
  {
    //REBOTA SI LA PELOTA ESTA CERCA DEL JUGADOR   
    //if(y >= posicionY1-(alto/2) && y <= posicionY1+(alto/2) )
    if(y >= posicionY1-alto && y <= posicionY1+alto )
    {
      dir *= -1;
    }
    else if(y >= posicionY4-alto && y <= posicionY4+alto )
    {
      dir *= -1;
    }
  }
  
  //REBOTA SI LA PELOTA ESTA CERCA DEL MURO DERECHO
  if(x <= width && x >= width-ancho-20)
  {
    //REBOTA SI LA PELOTA ESTA CERCA DEL JUGADOR   
    //if(y >= posicionY1-(alto/2) && y <= posicionY1+(alto/2) )
    if(y >= posicionY2-alto && y <= posicionY2+alto )
    {
      dir *= -1;
    }
    else if(y >= posicionY3-alto && y <= posicionY3+alto )
    {
      dir *= -1;
    }
  }
  
  
}
