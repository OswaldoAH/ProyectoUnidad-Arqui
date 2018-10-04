/**
 * Universidad Rafael Landivar
 * Arquitectura del computador II
 * 22/09/2018
 * ING. Abelardo Méndez
 * Integrantes:
 * Erick Alexander de León Véliz 15632-16
 * Lilian Nahomi Torees Gonzalez 15101-16
 * Héctor Armando Tello Itzep 16885-16
 * Mynor Oswaldo Alvarez Hernández 22814-16
 **********Descripción del proyecto************
 * Proyecto de uniddad 1 realizando con temporizador
 * y con interrupcion para el pulsador
 */
 //Variable
signed short int caso;
bit estado;
signed short int i;
//Funciones
//Funcion para configurar
void configurar(){
     ADCON1 = 0XFF;
     TRISB = 0XFF;
     PORTB = 0;
     TRISD = 0;
     PORTD =  0;
     INTCON = 0XF0;
     INTCON2 = 0XF4;
     T0CON = 0X03;
     TMR0L = 0XDB;
     TMR0H = 0X0B;
     T0IE_bit = 1;
     TMR0ON_bit = 1;
     estado = caso = i = 0;
}
/**
 * FUNCIÓN INCREMENTO
 * PC02 BASCULACIÓN DE BITS
 * CON INCREMENTO Y RETORNO A CERO
 **********************************
 * En esta funcion lo que hago es iterar el puerto teniendo como un ciclo
 * el temporizador y una variable i.
 * cuando el puerto llega a 255 lo reinicio a 0
 * si i mod 2 == 0 hago que encienda el led PORTD empieza en 0
 * PORTD = (PORTD*2)+1 = (0*2)+1=1      0000 0001
 * PORTD = (PORTD-1)/2 = (1-1)/2=0      0000 0000
 * Lo repite 3 veces y sigue la secuencia
 * PORTD = (PORTD*2)+1 = (1*2)+1=3      0000 0011
 * PORTD = (PORTD-1)/2 = (3-1)/2=1      0000 0001
 * PORTD = (PORTD*2)+1 = (3*2)+1=7      0000 0111
 * PORTD = (PORTD-1)/2 = (7-1)/2=3      0000 0011
 * PORTD = (PORTD*2)+1 = (7*2)+1=15     0000 1111
 * PORTD = (PORTD-1)/2 = (15-1)/2=7     0000 0111
 * PORTD = (PORTD*2)+1 = (15*2)+1=31    0001 1111
 * PORTD = (PORTD-1)/2 = (31-1)/2=15    0000 1111
 * PORTD = (PORTD*2)+1 = (31*2)+1=63    0011 1111
 * PORTD = (PORTD-1)/2 = (63-1)/2=31    0001 1111
 * PORTD = (PORTD*2)+1 = (63*2)+1=127   0111 1111
 * PORTD = (PORTD-1)/2 = (127-1)/2=63   0011 1111
 * PORTD = (PORTD*2)+1 = (127*2)+1=255  1111 1111
 * PORTD = (PORTD-1)/2 = (255-1)/2=127  0111 1111
 */
void Incremento(){
     if(PORTD==255)      PORTD=0;
     if((i%2)==0){
           PORTD=(2*PORTD)+1;
     }else{
            PORTD=(PORTD-1)/2;
     }
     if(i>3)              i=0;
     else                 i++;
}
/**
 * Función corrimientoI_D
 * PC03 Corrimiento de bit
 * Izquierda a derecha
 **************************************
 * Esta Funcion iguak itera el puerto con el temporizador
 * Hace casi lo mismo que la anterior funcion
 * Si i=0 o 16 PORTD=1
 *De lo contrario si i>0 y i<8
 * PORTD = (PORTD*2)+1 = (1*2)=2      0000 0010
 * PORTD = (PORTD*2)+1 = (2*2)=4      0000 0100
 * PORTD = (PORTD*2)+1 = (4*2)=8      0000 1000
 * PORTD = (PORTD*2)+1 = (8*2)=16     0001 0000
 * PORTD = (PORTD*2)+1 = (31*2)=32    0010 0000
 * PORTD = (PORTD*2)+1 = (63*2)=64    0100 0000
 * PORTD = (PORTD*2)+1 = (127*2)=128  1000 0000
 * Pero si i>7 y i<15
 * PORTD = (PORTD*2)+1 = (63/2)=64    0100 0000
 * PORTD = (PORTD*2)+1 = (31/2)=32    0010 0000
 * PORTD = (PORTD*2)+1 = (8/2)=16     0001 0000
 * PORTD = (PORTD*2)+1 = (4/2)=8      0000 1000
 * PORTD = (PORTD*2)+1 = (2/2)=4      0000 0100
 * PORTD = (PORTD*2)+1 = (1/2)=2      0000 0010
 */
void CorrimientoI_D(){
     if(i>0 && i<8){
           PORTD*=2;
           i++;
     }else if(i>7 && i<15){
           PORTD/=2;
           i++;
     }
     if(i==0 || i==15){
           i=1;
           PORTD=1;
     }
}
/**
 * Función contador
 * PC04 Contador con temporizador
 ***********************************
 * En esta funcion pues solo le doy el valor de i a PORTD
 * si i == 255 i=0
 */
void contador(){
     if(i==255)    i=0;
     PORTD=i;
     i++;
}
/**
 * Funcion Par_Impar
 * PC05 Corrimiento de bit con salto par/impar
*/
void Par_Impar(){
     if (i==0){
           PORTD=2;
     }else if(i>0 && i<=3){
           PORTD*=4;
     }else if(i==4){
           PORTD/=2;
     }else if(i>4 && i<=7){
           PORTD/=4;
     }
     i++;
     if(i==8)       i=0;
}
/*
 *Switch case que me dice a que funcion ir.
*/
void Secuencia(){
     switch(caso){
         case 0:
            break;
         case 1:
              RD0_bit = !(RD0_bit);
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
 * Funcion para las interrupciones
*/
void interrupt(){
     if (INT0IF_bit){
        INT0IF_bit = 0;
        caso++;
        if(caso==6)      caso=0;
        estado = PORTD = i = 0;
     }
     if (TMR0IF_bit){
       TMR0ON_bit = 0;
       T0IE_bit = 0;
       T0IF_bit = 0;
       TMR0L =0XDB;
       TMR0H = 0X0D;
       T0IE_bit = 1;
       T0CON = 0X83;
     }
     Secuencia();
}
void main() {
     configurar();
     while(1);
}