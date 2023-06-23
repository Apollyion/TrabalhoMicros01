#include <p18f4550.inc>

org 0 ; Início do código

UDATA
    CONTADOR res 1; Variavel para def. atraso

CODE
Start:
    ; Configuração dos pinos de saída
    MOVLW b'11111000'
    MOVWF TRISD ; RD2, RD1 e RD0 configurados como saída
    
    ; Zera todos os bits do PORTD
    CLRF PORTD
    
REPETE: ; Loop principal que se repete a cada 3 * T (de acordo com a Figura 1)
    ; Limpa o bit 0 de PORTD
    BCF PORTD, 0
    
    ; Seta o bit 2 de PORTD
    BSF PORTD, 2
    
    ; Chama a rotina de atraso que deve ter duração de 400 us
    CALL ATRASO
    
    ; Limpa o bit 2 de PORTD
    BCF PORTD, 2
    
    ; Seta o bit 1 de PORTD
    BSF PORTD, 1
    
    ; Chama o segundo atraso
    CALL ATRASO
    
    ; Limpa o bit 1 de PORTD
    BCF PORTD, 1
    
    ; Seta o bit 0 de PORTD
    BSF PORTD, 0
    
    ; Chama o último atraso com duração de 2 us
    CALL ATRASO
    
    ; Salta para o início do loop principal
    GOTO REPETE
 
; Rotina de atraso
ATRASO:
    ; Configura o contador do loop com o valor 78
    MOVLW .78
    
    ; Armazena o valor do contador na variável CONTADOR
    MOVWF CONTADOR
    
    ; Atraso inicial
    NOP
    NOP
    NOP
    NOP
    
LOOP:
    ; Atraso de 1 us
    NOP
    NOP
    
    ; Decrementa o valor do contador
    DECFSZ CONTADOR
    
    ; Salta para o início do loop caso o contador seja diferente de zero
    GOTO LOOP
    
    ; Retorna para a posição chamadora
    RETURN
    
    ; Salta para o início do loop infinito
    GOTO $                          ; Loop infinito

    END
