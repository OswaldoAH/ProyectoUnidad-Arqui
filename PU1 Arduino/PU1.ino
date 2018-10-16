/**
   Universidad Rafael Landivar
   Arquitectura del computador II
   Ing. Abelardo Méndez
   30-09-2018
   Mynor Oswaldo Alvarez Hernández 22814-16
   Héctor Armando Tello Itzep 16885-16
   Lilian Nahomi Torres Gónzalez 15101-16
   Erick Alexander de León Veliz 15632-16
*/

//Pines las declaro como constante.
const int pulso = 8;
//Variables utilizadas parael programa
//3 variables que me sirven para el tiempo y no usar delay
unsigned long tiempo_previo = 0;
const long tiempo = 500;
unsigned long tiempo_transcurrido;
/* Variables que sirven en el programa, i me sirve para simular la iteracion de un ciclo con
   caso es una variable que aumenta cada pulso para ver que secuencia se ejecutara

*/
byte i = 0;
byte caso = 0;
bool estado = false;
bool presionado =  false;


void setup() {
  DDRD = 255;
  PORTD = 0;
  pinMode(pulso, INPUT);
}

void loop() {
  if (!presionado) {
    presionado = digitalRead(pulso);
  }
  tiempo_transcurrido = millis();
  if (tiempo_transcurrido - tiempo_previo >= tiempo) {
    tiempo_previo = tiempo_transcurrido;
    estado = !estado;
    if (estado) {
      verificar_pulso();
      secuencia();
    }
  }
}
/**
    Verifica si hubo un pulso
    si hubo un pulso pone i, portd en 0 y aunmenta el caso
    si el caso es igual a 6 el caso vueleve a 0
*/
void verificar_pulso() {
  if (presionado) {
    i = 0;
    PORTD = 0;
    caso++;
    if (caso == 6) caso = 0;
    presionado = false;
  }
}
/**
 * 
 */
void secuencia() {
  switch (caso) {
    case 0:
      break;
    case 1:
      PORTD = !PORTD;
      break;
    case 2:
      Incremento();
      break;
    case 3:
      CorrimientoI_D();
      break;
    case 4:
      contador();
      break;
    case 5:
      Par_Impar();
      break;
  }
}
/**
   FUNCIÓN INCREMENTO
   PC02 BASCULACIÓN DE BITS
   CON INCREMENTO Y RETORNO A CERO
*/
void Incremento() {
  if (PORTD == 255)      PORTD = 0;
  if ((i % 2) == 0) {
    PORTD = (2 * PORTD) + 1;
  } else {
    PORTD = (PORTD - 1) / 2;
  }
  if (i > 3)              i = 0;
  else                 i++;
}
/**
   Función corrimientoI_D
   PC03 Corrimiento de bit
   Izquierda a derecha
*/
void CorrimientoI_D() {
  if (i > 0 && i < 8) {
    PORTD *= 2;
    i++;
  } else if (i > 7 && i < 15) {
    PORTD /= 2;
    i++;
  }
  if (i == 0 || i == 15) {
    i = 1;
    PORTD = 1;
  }
}
/**
   Función contador
   PC04 Contador con temporizador
*/
void contador() {
  if (i == 255)    i = 0;
  PORTD = i;
  i++;
}
/**
   Funcion Par_Impar
   PC05 Corrimiento de bit con salto par/impar
*/
void Par_Impar() {
  if (i == 0) {
    PORTD = 2;
  } else if (i > 0 && i <= 3) {
    PORTD *= 4;
  } else if (i == 4) {
    PORTD /= 2;
  } else if (i > 4 && i <= 7) {
    PORTD /= 4;
  }
  i++;
  if (i == 8)       i = 0;
}

