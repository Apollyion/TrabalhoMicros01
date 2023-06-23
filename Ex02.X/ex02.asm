#include <p18f4550.inc>
	
	CONFIG WDT=OFF; disable watchdog timer
	CONFIG MCLRE = ON; MCLEAR Pin on
	CONFIG DEBUG = ON; Enable Debug Mode
	CONFIG LVP = OFF; Low-Voltage programming disabled (necessary for debugging)
	CONFIG FOSC = INTOSCIO_EC;Internal oscillator, port function on RA6 
	
	org 0; start code at 0

UDATA
	
valor res 1; Reserva 1 byte para guardar o valor
qtd res 1; Variavel para guardar numero de '1's
counter res 1; Reserva 1 byte para guardar o counter
max res 1;

CODE
 
 
; WorkFlow:
 ; Atribui o valor
 ; Pega o LSB
    ; Se for 1 adiciona 1 no qtd
    ; Se não, faz nada (NOP)
; Rotaciona o valor.
 ; Adiciona 1 no counter
 ; Verifica se Counter == Max(8)
    ; Se sim, rodou todo o byte, então para o codigo
Start:
    ; Inicialização do valor
    MOVLW b'11001001' ; Valor para contar os bits "1"
    MOVWF valor

    
    ; Carrega o maximo de voltas:
    MOVLW 0x07 ; Carrega 7 em decimal - Suficiente para percorrer o Byte
    MOVWF max
    
    ; Contagem dos bits "1"
    CLRF counter ; Zera a variável de contagem
LOOP:
    
        BTFSC valor, 0 ; Verifica se LSB de valor é não 1
        CALL INCREMENT ; Se for zero, pula a incrementação da contagem
	
	RRNCF valor; Rotaciona o valor e mov W
	;MOVWF valor;  Mov W para Valor
	
	; Verificar se rodou o numero maximo de vezes, ou seja se counter >= max
	; Se não for pula a instrução FINALIZOU
	MOVF counter, W      ; Move o valor de 'counter' para W
	SUBWF max, W         ; Subtrai o valor de 'max' de W e atualiza W com o resultado
	BTFSC STATUS, Z      ; Verifica se o resultado da subtração é igual a zero (zero clear)
	GOTO FINALIZOU       ; Se o resultado for igual a zero, vai para 'FINALIZOU'

	MOVLW 0x01;
	ADDWF counter, F; Adiciona mais um no contador


	
        ;INCF counter, F ; Incrementa a contagem
	GOTO LOOP
INCREMENT:
	MOVLW 0x01; Coloca 1 em W
	ADDWF qtd, F; Adiciona mais um na qtd de '1's
	RETURN
FINALIZOU:
    GOTO $
	end