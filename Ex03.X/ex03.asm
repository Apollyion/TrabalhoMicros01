#include <p18f4550.inc>

CONFIG WDT=OFF       ; Desabilitar o watchdog timer
CONFIG MCLRE = ON    ; Habilitar o pino MCLEAR
CONFIG DEBUG = ON    ; Habilitar o modo de depura��o
CONFIG LVP = OFF     ; Desabilitar programa��o de baixa tens�o
CONFIG FOSC = INTOSCIO_EC ; Oscilador interno, fun��o do pino RA6

org 0 ; In�cio do c�digo

UDATA
    var res 1 ; Vari�vel para armazenar os 8 bits originais
    msb res 1 ; Vari�vel para armazenar os 4 MSBs
    lsb res 1 ; Vari�vel para armazenar os 4 LSBs
    result res 1 ; Vari�vel para armazenar o resultado da soma

CODE
Start:
    ; Coloque aqui o c�digo para atribuir o valor desejado � vari�vel 'var'
    MOVLW b'11111111'
    MOVWF var
    
    ; Extrair os 4 MSBs
    MOVF var, W
    ANDLW b'11110000' ; Mascara para manter apenas os 4 bits mais significativos
    MOVWF msb
    CALL MOVE_4
    
    ; Extrair os 4 LSBs
    MOVF var, W
    ANDLW b'00001111' ; Mascara para manter apenas os 4 bits menos significativos
    MOVWF lsb

    ; Soma dos MSBs com os LSBs
    ADDWF msb, W
    MOVWF result
    
    GOTO $
    ; Fim do programa

; Fun��o para rotacionar o Vetor para que ele transforme os ultimos 4 bits nos primeiros
MOVE_4:
    RRNCF msb; Rotaciona para esquerda
    RRNCF msb; Rotaciona novamente
    RRNCF msb; Rotaciona novamente
    RRNCF msb; Rotaciona novamente
    RETURN
    

end
