#line 1 "R:/URL Mynor/6to Ciclo/Arquitectura del computador 2/Mikroc/PU1/ProyectoUnidad1.c"
#line 8 "R:/URL Mynor/6to Ciclo/Arquitectura del computador 2/Mikroc/PU1/ProyectoUnidad1.c"
signed short int caso;
bit estado;
signed short int i;


void configurar(){
 ADCON1 = 0XFF;
 TRISB = 0XFF;
 PORTB = 0;
 TRISD = 0;
 PORTD = 0;
 INTCON = 0XF0;
 INTCON2 = 0XF4;
 T0CON = 0X03;
 TMR0L = 0XDB;
 TMR0H = 0X0B;
 T0IE_bit = 1;
 TMR0ON_bit = 1;
 estado = caso = i = 0;
}
#line 33 "R:/URL Mynor/6to Ciclo/Arquitectura del computador 2/Mikroc/PU1/ProyectoUnidad1.c"
void Incremento(){
 if(PORTD==255) PORTD=0;
 if((i%2)==0){
 PORTD=(2*PORTD)+1;
 }else{
 PORTD=(PORTD-1)/2;
 }
 if(i>3) i=0;
 else i++;
}
#line 48 "R:/URL Mynor/6to Ciclo/Arquitectura del computador 2/Mikroc/PU1/ProyectoUnidad1.c"
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
#line 65 "R:/URL Mynor/6to Ciclo/Arquitectura del computador 2/Mikroc/PU1/ProyectoUnidad1.c"
void contador(){
 if(i==255) i=0;
 PORTD=i;
 i++;
}
#line 74 "R:/URL Mynor/6to Ciclo/Arquitectura del computador 2/Mikroc/PU1/ProyectoUnidad1.c"
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
 if(i==8) i=0;
}
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
#line 111 "R:/URL Mynor/6to Ciclo/Arquitectura del computador 2/Mikroc/PU1/ProyectoUnidad1.c"
void interrupt(){
 if (INT0IF_bit){
 INT0IF_bit = 0;
 caso++;
 if(caso==6) caso=0;
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
