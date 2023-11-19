; **Variables globales**
variableA:0x0
Q: 0b10000001 ; Multiplicador
Q_1:0x0
M: 0b11111101; Multiplicando
count: 0x8

; **Inicio del programa**
inicio:

; **Comprobamos si el bit más significativo de Q es 1**
; **Si lo es, saltamos al bucle de desplazamiento**
mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
mov ACC, 0x1
AND ACC, A
mov A, ACC
jz desplazamiento

; **Comprobamos si el bit más significativo de Q es 0**
; **Si lo es, saltamos al bucle de suma**
mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
mov ACC, 0x1
and ACC, A
mov A, ACC
jz suma

; **Si no es ni 0 ni 1, el programa termina**
hlt

; **Desplazamiento a la derecha**
desplazamiento:

; **Guardamos el bit más significativo de Q en Q_1**
mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
mov ACC, Q_1
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

; **Desplazamos A a la derecha**
RSH ACC, variableA
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

; **Desplazamos Q a la derecha**
RSH ACC, Q
mov A, ACC
mov ACC, Q
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

; **Volvemos a comprobar si el bit más significativo de Q es 1 o 0**
; **Si lo es, saltamos al bucle de suma o resta**
mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
mov ACC, 0x1
AND ACC, A
mov A, ACC
jz desplazamiento

; **Si no es ni 0 ni 1, el programa termina**
hlt

; **Suma**
suma:

; **Sumamos el producto de M y A**
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

; **Volvemos al bucle de desplazamiento**
jmp desplazamiento

; **Resta**
resta:

; **Restamos el producto de M y A**
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

; **Volvemos al bucle de desplazamiento**
jmp desplazamiento
