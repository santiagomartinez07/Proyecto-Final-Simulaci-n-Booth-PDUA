; PROYECTO FINAL ALGORITMO BOOTH
; Variables globales

variableA: 0x0  ; Variable acumuladora para almacenar valores intermedios
Q: 0b10000001   ; Multiplicando (el número que se está multiplicando)
Q_1: 0x0        ; Variable temporal para almacenar el bit más significativo de Q
M: 0b11111101  ; Multiplicador (el número por el que estamos multiplicando)
count: 0x8      ; Variable contadora para llevar la cuenta del número de iteraciones

; Inicio del programa
inicio:

; Comprueba si el bit más significativo de Q es 1
mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
mov ACC, 0x1
AND ACC, A
jz desplazamiento

; Si el bit más significativo de Q es 0, salta a la rutina de suma
mov ACC, Q_1
mov DPTR, ACC
mov ACC, [DPTR]
add ACC, A
jz suma

; Si el bit más significativo de Q no es 0 ni 1, el programa termina
jmp resta

; Rutina de desplazamiento
desplazamiento:

; Comprueba si el bit más significativo de Q es 1
mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
mov ACC, 0x1
AND ACC, A
jz desplazamiento

; Actualiza Q_1 y desplaza Q y variableA a la derecha
mov ACC, Q_1
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

mov ACC, variableA
mov DPTR, ACC
RSH ACC, 0x1
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

mov ACC, Q
mov DPTR, ACC
RSH ACC, 0x1
mov A, ACC
mov ACC, Q
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

hlt

; Suma rutina
suma:

; Suma el producto de M y A al valor almacenado en variableA
mov ACC, M
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, [DPTR]
add ACC, A
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

; Salta a la rutina de desplazamiento
jmp desplazamiento

; Resta rutina
resta:

; Resta el producto de M y A al valor almacenado en variableA
mov ACC, M
mov DPTR, ACC
mov ACC, [DPTR]
inv ACC
mov A, ACC
mov ACC, 0x1
add ACC, A
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, [DPTR]
add ACC, A
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

; Salta a la rutina de desplazamiento
jmp desplazamiento
