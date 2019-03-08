//sensores analogos

int sensorValue; //este es el potenciometro 1
int sensorValue2; //este es el potenciometro 2
int sensorValue3; //3
int sensorValue4; //4
int inputPin = A0;
int inputPin2 = A1;  
int inputPin3 = A2;
int inputPin4 = A3;        


void setup() 
{
  Serial.begin(9600);  
}

void loop() 
{
  //al dividirlo entre 4 me bota datos de 0-255 y no de 0-1023 ke es lo normal


   
  sensorValue = analogRead(inputPin)/4; //divido el primero

  sensorValue2 = analogRead(inputPin2)/4; //divido el segundo

  sensorValue3 = analogRead(inputPin3)/4; //divido el tercero

  sensorValue4 = analogRead(inputPin4)/4; //divido el cuarto
  
  //imprimo el dato en consola DEC para poderlo ver yo, Byte para la makina, solo se imprime cuando no se este usando serial.write
  Serial.print(sensorValue);
  Serial.print("T");
  Serial.print(sensorValue2);
  Serial.print("T");
  Serial.print(sensorValue3);
  Serial.print("T");
  Serial.print(sensorValue4);
  Serial.println();


  // enviar el dato, no se debe usar cuando se use serial.print
  //SERIAL WRITE LE ENVIA DATOS 
  //Serial.write(sensorValue);

  //cada 100 me envia el dato  
  delay(100); 
}
