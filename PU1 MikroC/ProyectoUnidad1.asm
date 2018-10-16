
_configurar:

;ProyectoUnidad1.c,13 :: 		void configurar(){
;ProyectoUnidad1.c,14 :: 		ADCON1 = 0XFF;
	MOVLW       255
	MOVWF       ADCON1+0 
;ProyectoUnidad1.c,15 :: 		TRISB = 0XFF;
	MOVLW       255
	MOVWF       TRISB+0 
;ProyectoUnidad1.c,16 :: 		PORTB = 0;
	CLRF        PORTB+0 
;ProyectoUnidad1.c,17 :: 		TRISD = 0;
	CLRF        TRISD+0 
;ProyectoUnidad1.c,18 :: 		PORTD =  0;
	CLRF        PORTD+0 
;ProyectoUnidad1.c,19 :: 		INTCON = 0XF0;
	MOVLW       240
	MOVWF       INTCON+0 
;ProyectoUnidad1.c,20 :: 		INTCON2 = 0XF4;
	MOVLW       244
	MOVWF       INTCON2+0 
;ProyectoUnidad1.c,21 :: 		T0CON = 0X03;
	MOVLW       3
	MOVWF       T0CON+0 
;ProyectoUnidad1.c,22 :: 		TMR0L = 0XDB;
	MOVLW       219
	MOVWF       TMR0L+0 
;ProyectoUnidad1.c,23 :: 		TMR0H = 0X0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;ProyectoUnidad1.c,24 :: 		T0IE_bit = 1;
	BSF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;ProyectoUnidad1.c,25 :: 		TMR0ON_bit = 1;
	BSF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;ProyectoUnidad1.c,26 :: 		estado = caso = i = 0;
	CLRF        _i+0 
	CLRF        _caso+0 
	BCF         _estado+0, BitPos(_estado+0) 
;ProyectoUnidad1.c,27 :: 		}
L_end_configurar:
	RETURN      0
; end of _configurar

_Incremento:

;ProyectoUnidad1.c,33 :: 		void Incremento(){
;ProyectoUnidad1.c,34 :: 		if(PORTD==255)      PORTD=0;
	MOVF        PORTD+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_Incremento0
	CLRF        PORTD+0 
L_Incremento0:
;ProyectoUnidad1.c,35 :: 		if((i%2)==0){
	MOVLW       2
	MOVWF       R4 
	MOVF        _i+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Incremento1
;ProyectoUnidad1.c,36 :: 		PORTD=(2*PORTD)+1;
	MOVF        PORTD+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       PORTD+0 
;ProyectoUnidad1.c,37 :: 		}else{
	GOTO        L_Incremento2
L_Incremento1:
;ProyectoUnidad1.c,38 :: 		PORTD=(PORTD-1)/2;
	DECF        PORTD+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	BTFSS       R1, 7 
	GOTO        L__Incremento48
	BTFSS       STATUS+0, 0 
	GOTO        L__Incremento48
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__Incremento48:
	MOVF        R0, 0 
	MOVWF       PORTD+0 
;ProyectoUnidad1.c,39 :: 		}
L_Incremento2:
;ProyectoUnidad1.c,40 :: 		if(i>3)              i=0;
	MOVLW       128
	XORLW       3
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Incremento3
	CLRF        _i+0 
	GOTO        L_Incremento4
L_Incremento3:
;ProyectoUnidad1.c,41 :: 		else                 i++;
	INCF        _i+0, 1 
L_Incremento4:
;ProyectoUnidad1.c,42 :: 		}
L_end_Incremento:
	RETURN      0
; end of _Incremento

_CorrimientoI_D:

;ProyectoUnidad1.c,48 :: 		void CorrimientoI_D(){
;ProyectoUnidad1.c,49 :: 		if(i>0 && i<8){
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_CorrimientoI_D7
	MOVLW       128
	XORWF       _i+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       8
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_CorrimientoI_D7
L__CorrimientoI_D43:
;ProyectoUnidad1.c,50 :: 		PORTD*=2;
	MOVF        PORTD+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       PORTD+0 
;ProyectoUnidad1.c,51 :: 		i++;
	INCF        _i+0, 1 
;ProyectoUnidad1.c,52 :: 		}else if(i>7 && i<15){
	GOTO        L_CorrimientoI_D8
L_CorrimientoI_D7:
	MOVLW       128
	XORLW       7
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_CorrimientoI_D11
	MOVLW       128
	XORWF       _i+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       15
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_CorrimientoI_D11
L__CorrimientoI_D42:
;ProyectoUnidad1.c,53 :: 		PORTD/=2;
	MOVF        PORTD+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       PORTD+0 
;ProyectoUnidad1.c,54 :: 		i++;
	INCF        _i+0, 1 
;ProyectoUnidad1.c,55 :: 		}
L_CorrimientoI_D11:
L_CorrimientoI_D8:
;ProyectoUnidad1.c,56 :: 		if(i==0 || i==15){
	MOVF        _i+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__CorrimientoI_D41
	MOVF        _i+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L__CorrimientoI_D41
	GOTO        L_CorrimientoI_D14
L__CorrimientoI_D41:
;ProyectoUnidad1.c,57 :: 		i=1;
	MOVLW       1
	MOVWF       _i+0 
;ProyectoUnidad1.c,58 :: 		PORTD=1;
	MOVLW       1
	MOVWF       PORTD+0 
;ProyectoUnidad1.c,59 :: 		}
L_CorrimientoI_D14:
;ProyectoUnidad1.c,60 :: 		}
L_end_CorrimientoI_D:
	RETURN      0
; end of _CorrimientoI_D

_contador:

;ProyectoUnidad1.c,65 :: 		void contador(){
;ProyectoUnidad1.c,66 :: 		if(i==255)    i=0;
	MOVLW       0
	BTFSC       _i+0, 7 
	MOVLW       255
	MOVWF       R0 
	MOVLW       0
	XORWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__contador51
	MOVLW       255
	XORWF       _i+0, 0 
L__contador51:
	BTFSS       STATUS+0, 2 
	GOTO        L_contador15
	CLRF        _i+0 
L_contador15:
;ProyectoUnidad1.c,67 :: 		PORTD=i;
	MOVF        _i+0, 0 
	MOVWF       PORTD+0 
;ProyectoUnidad1.c,68 :: 		i++;
	INCF        _i+0, 1 
;ProyectoUnidad1.c,69 :: 		}
L_end_contador:
	RETURN      0
; end of _contador

_Par_Impar:

;ProyectoUnidad1.c,74 :: 		void Par_Impar(){
;ProyectoUnidad1.c,75 :: 		if (i==0){
	MOVF        _i+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Par_Impar16
;ProyectoUnidad1.c,76 :: 		PORTD=2;
	MOVLW       2
	MOVWF       PORTD+0 
;ProyectoUnidad1.c,77 :: 		}else if(i>0 && i<=3){
	GOTO        L_Par_Impar17
L_Par_Impar16:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Par_Impar20
	MOVLW       128
	XORLW       3
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Par_Impar20
L__Par_Impar45:
;ProyectoUnidad1.c,78 :: 		PORTD*=4;
	MOVF        PORTD+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       PORTD+0 
;ProyectoUnidad1.c,79 :: 		}else if(i==4){
	GOTO        L_Par_Impar21
L_Par_Impar20:
	MOVF        _i+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Par_Impar22
;ProyectoUnidad1.c,80 :: 		PORTD/=2;
	MOVF        PORTD+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       PORTD+0 
;ProyectoUnidad1.c,81 :: 		}else if(i>4 && i<=7){
	GOTO        L_Par_Impar23
L_Par_Impar22:
	MOVLW       128
	XORLW       4
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Par_Impar26
	MOVLW       128
	XORLW       7
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Par_Impar26
L__Par_Impar44:
;ProyectoUnidad1.c,82 :: 		PORTD/=4;
	MOVF        PORTD+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       PORTD+0 
;ProyectoUnidad1.c,83 :: 		}
L_Par_Impar26:
L_Par_Impar23:
L_Par_Impar21:
L_Par_Impar17:
;ProyectoUnidad1.c,84 :: 		i++;
	INCF        _i+0, 1 
;ProyectoUnidad1.c,85 :: 		if(i==8)       i=0;
	MOVF        _i+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Par_Impar27
	CLRF        _i+0 
L_Par_Impar27:
;ProyectoUnidad1.c,86 :: 		}
L_end_Par_Impar:
	RETURN      0
; end of _Par_Impar

_Secuencia:

;ProyectoUnidad1.c,87 :: 		void Secuencia(){
;ProyectoUnidad1.c,88 :: 		switch(caso){
	GOTO        L_Secuencia28
;ProyectoUnidad1.c,89 :: 		case 0:
L_Secuencia30:
;ProyectoUnidad1.c,90 :: 		break;
	GOTO        L_Secuencia29
;ProyectoUnidad1.c,91 :: 		case 1:
L_Secuencia31:
;ProyectoUnidad1.c,92 :: 		RD0_bit = !(RD0_bit);
	BTG         RD0_bit+0, BitPos(RD0_bit+0) 
;ProyectoUnidad1.c,93 :: 		break;
	GOTO        L_Secuencia29
;ProyectoUnidad1.c,94 :: 		case 2:
L_Secuencia32:
;ProyectoUnidad1.c,95 :: 		Incremento();
	CALL        _Incremento+0, 0
;ProyectoUnidad1.c,96 :: 		break;
	GOTO        L_Secuencia29
;ProyectoUnidad1.c,97 :: 		case 3:
L_Secuencia33:
;ProyectoUnidad1.c,98 :: 		CorrimientoI_D();
	CALL        _CorrimientoI_D+0, 0
;ProyectoUnidad1.c,99 :: 		break;
	GOTO        L_Secuencia29
;ProyectoUnidad1.c,100 :: 		case 4:
L_Secuencia34:
;ProyectoUnidad1.c,101 :: 		contador();
	CALL        _contador+0, 0
;ProyectoUnidad1.c,102 :: 		break;
	GOTO        L_Secuencia29
;ProyectoUnidad1.c,103 :: 		case 5:
L_Secuencia35:
;ProyectoUnidad1.c,104 :: 		Par_Impar();
	CALL        _Par_Impar+0, 0
;ProyectoUnidad1.c,105 :: 		break;
	GOTO        L_Secuencia29
;ProyectoUnidad1.c,106 :: 		}
L_Secuencia28:
	MOVF        _caso+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_Secuencia30
	MOVF        _caso+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_Secuencia31
	MOVF        _caso+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_Secuencia32
	MOVF        _caso+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_Secuencia33
	MOVF        _caso+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_Secuencia34
	MOVF        _caso+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_Secuencia35
L_Secuencia29:
;ProyectoUnidad1.c,107 :: 		}
L_end_Secuencia:
	RETURN      0
; end of _Secuencia

_interrupt:

;ProyectoUnidad1.c,111 :: 		void interrupt(){
;ProyectoUnidad1.c,112 :: 		if (INT0IF_bit){
	BTFSS       INT0IF_bit+0, BitPos(INT0IF_bit+0) 
	GOTO        L_interrupt36
;ProyectoUnidad1.c,113 :: 		INT0IF_bit = 0;
	BCF         INT0IF_bit+0, BitPos(INT0IF_bit+0) 
;ProyectoUnidad1.c,114 :: 		caso++;
	INCF        _caso+0, 1 
;ProyectoUnidad1.c,115 :: 		if(caso==6)      caso=0;
	MOVF        _caso+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt37
	CLRF        _caso+0 
L_interrupt37:
;ProyectoUnidad1.c,116 :: 		estado = PORTD = i = 0;
	CLRF        _i+0 
	CLRF        PORTD+0 
	BTFSC       PORTD+0, 0 
	GOTO        L__interrupt56
	BCF         _estado+0, BitPos(_estado+0) 
	GOTO        L__interrupt57
L__interrupt56:
	BSF         _estado+0, BitPos(_estado+0) 
L__interrupt57:
;ProyectoUnidad1.c,117 :: 		}
L_interrupt36:
;ProyectoUnidad1.c,118 :: 		if (TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt38
;ProyectoUnidad1.c,119 :: 		TMR0ON_bit = 0;
	BCF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;ProyectoUnidad1.c,120 :: 		T0IE_bit = 0;
	BCF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;ProyectoUnidad1.c,121 :: 		T0IF_bit = 0;
	BCF         T0IF_bit+0, BitPos(T0IF_bit+0) 
;ProyectoUnidad1.c,122 :: 		TMR0L =0XDB;
	MOVLW       219
	MOVWF       TMR0L+0 
;ProyectoUnidad1.c,123 :: 		TMR0H = 0X0D;
	MOVLW       13
	MOVWF       TMR0H+0 
;ProyectoUnidad1.c,124 :: 		T0IE_bit = 1;
	BSF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;ProyectoUnidad1.c,125 :: 		T0CON = 0X83;
	MOVLW       131
	MOVWF       T0CON+0 
;ProyectoUnidad1.c,126 :: 		}
L_interrupt38:
;ProyectoUnidad1.c,127 :: 		Secuencia();
	CALL        _Secuencia+0, 0
;ProyectoUnidad1.c,128 :: 		}
L_end_interrupt:
L__interrupt55:
	RETFIE      1
; end of _interrupt

_main:

;ProyectoUnidad1.c,129 :: 		void main() {
;ProyectoUnidad1.c,130 :: 		configurar();
	CALL        _configurar+0, 0
;ProyectoUnidad1.c,131 :: 		while(1);
L_main39:
	GOTO        L_main39
;ProyectoUnidad1.c,132 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
