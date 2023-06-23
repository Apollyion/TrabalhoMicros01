#include <p18f4550.inc>
	
	CONFIG WDT=OFF; disable watchdog timer
	CONFIG MCLRE = ON; MCLEAR Pin on
	CONFIG DEBUG = ON; Enable Debug Mode
	CONFIG LVP = OFF; Low-Voltage programming disabled (necessary for debugging)
	CONFIG FOSC = INTOSCIO_EC;Internal oscillator, port function on RA6 
	
	org 0; start code at 0

UDATA
	
var1H res 1;Reserve 1 byte for the variable Delay1
var1L res 1;Reserve 1 byte for the variable Delay2
var2H res 1;Reserve 1 byte for the variable Delay1
var2L res 1;Reserve 1 byte for the variable Delay2
resH res 1;Reserve 1 byte for the variable Delay1
resL res 1;Reserve 1 byte for the variable Delay2

CODE
 
Start:

MainLoop:
	; Adicionando 4E50h para var1
	MOVLW 4Eh; Movendo para Acumulador
	MOVWF var1H; Inserindo valor MSB
	
	MOVLW 50h ; Movendo para Acumulador
	MOVWF var1L ; Inserindo valor LSB
	
	; Adicionando 4141h para var2
	MOVLW 41h ; Movendo para Acumulador
	MOVWF var2H; Inserindo valor MSB
	
	MOVLW 41h ; Movendo para Acumulador
	MOVWF var2L ; Inserindo valor LSB
	
	;Soma da parte menos sig.
	MOVF var1L, W; Move var1L para W
	ADDWF var2L, W; Soma oq ta em W com var2L - O status do bitcarry muda!
	MOVWF resL; 
	
		
	;Realizando soma da parte mais sig. -  considerando o CARRY
	MOVF var1H, W; Move var1H para W
	ADDWFC var2H, W; Soma W(var1H) com var2H
	MOVWF resH ; 4E + 41 = 8F
	
	GOTO MainLoop
	
	
	
	
	end