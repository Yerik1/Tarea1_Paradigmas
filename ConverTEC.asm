data segment
    bienvenida db "Bienvenido a ConverTec", 0Dh, 0Ah, "Por favor indique que tipo de conversion desea realizar:", 0Dh, 0Ah, "$"  ; Mensaje de bienvenida
    menu_principal db "1. Temperatura", 0Dh, 0Ah,"2. Longitud", 0Dh, 0Ah,"3. Masa", 0Dh, 0Ah, "$"                           ; Menu principal
    
    opciones_temperatura db "1. Fahrenheit a Celsius", 0Dh, 0Ah,"2. Celsius a Fahrenheit", 0Dh, 0Ah,"3. Celsius a Kelvin", 0Dh, 0Ah,"4. Kelvin a Celsius", 0Dh, 0Ah,"5. Fahrenheit a Kelvin", 0Dh, 0Ah,"6. Kelvin a Fahrenheit", 0Dh, 0Ah, "$"  ; Opciones de temperatura
    
    opciones_longitud db "1. Pulgadas a Centimetros", 0Dh, 0Ah,"2. Pies a Centimetros ", 0Dh, 0Ah,"3. Yardas a centimetros", 0Dh, 0Ah,"4. Millas a kilometros", 0Dh, 0Ah,"5. Centimetros a Pulgadas", 0Dh, 0Ah,"6. Centimetros a Pies", 0Dh, 0Ah,"7. Centimetros a Yardas", 0Dh, 0Ah,"8. Kilometros a Millas", 0Dh, 0Ah, "$"  ; Opciones de longitud
    
    opciones_masa db "1. Onzas a Kilos", 0Dh, 0Ah, "2. Libras a Kilos", 0Dh, 0Ah, "3. Toneladas a Kilos", 0Dh, 0Ah, "4. Kilos a Onzas", 0Dh, 0Ah, "5. Kilos a Libras", 0Dh, 0Ah, "6. Kilos a Toneladas", 0Dh, 0Ah, "$"  ; Opciones de masa
    
    valor_entrada db "Por favor ingrese el valor: $"         ; Solicitud de entrada
    result_msg db "El resultado de la conversion es: $"      ; Mensaje de resultado
    continue_msg db "Presione 1 para continuar o 2 para salir: $"  ; Opcion de continuar
    invalid_msg db "Opcion invalida, por favor intente de nuevo.", 0Dh, 0Ah, "$"  ; Mensaje de error
    buffer db 12 dup('$')          ; Buffer para entrada
    result db 12 dup('$')          ; Buffer para resultado
    newline db 0Dh, 0Ah, "$"       ; Salto de linea
ends

stack segment
    dw 128 dup(0)                  ; Segmento de pila
ends

code segment
start:
    jmp inicio                     ; Salto al inicio

inicio:
    mov ax, data                   ; Cargar segmento de datos
    mov ds, ax
    mov es, ax
    
    lea dx, bienvenida             ; Mostrar mensaje de bienvenida
    mov ah, 9
    int 21h
    
    lea dx, menu_principal         ; Mostrar menu principal
    mov ah, 9
    int 21h

    mov ah, 1                      ; Leer opcion del usuario
    int 21h
    sub al, '0'                    ; Convertir a numero

    cmp al, 1
    je conversiones_temperatura    ; Ir a temperatura
    cmp al, 2
    je conversiones_longitud       ; Ir a longitud
    cmp al, 3
    je conversiones_masa           ; Ir a masa
    jmp invalid_option             ; Opcion invalida
    

conversiones_temperatura:
    mov ax, data                   ; Cargar segmento de datos
    mov ds, ax
    mov es, ax
    
    lea dx, newline                ; Nueva linea
    mov ah, 9
    int 21h
    
    lea dx, opciones_temperatura   ; Mostrar opciones de temperatura
    mov ah, 9
    int 21h

    mov ah, 1                      ; Leer opcion
    int 21h
    sub al, '0'

    cmp al, 1  
    je fahrenheit_celsius          ; Conversion 1
    cmp al, 2
    je celsius_fahrenheit          ; Conversion 2
    cmp al, 3
    je celsius_kelvin              ; Conversion 3
    cmp al, 4
    je kelvin_celsius              ; Conversion 4
    cmp al, 5
    je fahrenheit_kelvin           ; Conversion 5
    cmp al, 6
    je kelvin_fahrenheit           ; Conversion 6
    
    
conversiones_longitud:
    mov ax, data                   ; Cargar segmento de datos
    mov ds, ax
    mov es, ax
    
    lea dx, newline                ; Nueva linea
    mov ah, 9
    int 21h
    
    lea dx, opciones_longitud      ; Mostrar opciones de longitud
    mov ah, 9
    int 21h

    mov ah, 1                      ; Leer opcion
    int 21h
    sub al, '0'

    cmp al, 1  
    je pulgadas_centimetros        ; Conversion 1
    cmp al, 2
    je pies_centimetros            ; Conversion 2
    cmp al, 3
    je yardas_centimetros          ; Conversion 3
    cmp al, 4
    je millas_kilometros           ; Conversion 4
    cmp al, 5
    je centimetros_pulgadas        ; Conversion 5
    cmp al, 6
    je centimetros_pies            ; Conversion 6
    cmp al, 7
    je centimetros_yardas          ; Conversion 7
    cmp al, 8
    je kilometros_millas           ; Conversion 8
      
    jmp invalid_option             ; Opcion invalida

conversiones_masa:
    mov ax, data                   ; Cargar segmento de datos
    mov ds, ax
    mov es, ax
    
    lea dx, newline                ; Nueva linea
    mov ah, 9
    int 21h
    
    lea dx, opciones_masa          ; Mostrar opciones de masa
    mov ah, 9
    int 21h

    mov ah, 1                      ; Leer opcion
    int 21h
    sub al, '0'

    cmp al, 1  
    je onzas_kilos                 ; Conversion 1
    cmp al, 2
    je libras_kilos                ; Conversion 2
    cmp al, 3
    je toneladas_kilos             ; Conversion 3
    cmp al, 4
    je kilos_onzas                 ; Conversion 4
    cmp al, 5
    je kilos_libras                ; Conversion 5
    cmp al, 6
    je kilos_toneladas             ; Conversion 6
      
    jmp invalid_option             ; Opcion invalida
 
 
 
fahrenheit_celsius:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call fahrenheit_to_celsius_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar

celsius_fahrenheit:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call celsius_to_fahrenheit_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar 
    
    
celsius_kelvin:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call celsius_to_kelvin_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
    
kelvin_celsius:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call kelvin_to_celsius_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
    
fahrenheit_kelvin:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call fahrenheit_to_kelvin_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
    
    
kelvin_fahrenheit:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call kelvin_to_fahrenheit_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar 
    
pulgadas_centimetros:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call pulgadas_to_centimetros_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
    

pies_centimetros:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call pies_to_centimetros_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar


yardas_centimetros:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call yardas_to_centimetros_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
            


millas_kilometros:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call millas_to_kilometros_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar 
    
    
centimetros_pulgadas:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call centimetros_to_pulgadas_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
    
    
    
centimetros_pies:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call centimetros_to_pies_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
    
    
    
    
centimetros_yardas:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call centimetros_to_yardas_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
    
    
    
kilometros_millas:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call kilometros_to_millas_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
    
    
    
onzas_kilos:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call onzas_to_kilos_convert    ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
    
    
    
libras_kilos:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call libras_to_kilos_convert   ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
    
    
    
toneladas_kilos:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call toneladas_to_kilos_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
                        
                        
kilos_onzas:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call kilos_to_onzas_convert    ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
    
    
    
kilos_libras:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call kilos_to_libras_convert   ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
    
    
kilos_toneladas:
    lea dx, valor_entrada          ; Solicitar valor
    mov ah, 9
    int 21h

    call read_float                ; Leer numero
    call kilos_to_toneladas_convert  ; Convertir
    
    lea dx, newline                ; Mostrar resultado
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    call float_to_string           ; Convertir a string
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue               ; Preguntar si continuar
    
    
    
    
; Leer numero con decimales
read_float:
    pusha
    lea dx, buffer                 ; Leer entrada del usuario
    mov ah, 0Ah
    int 21h

    lea si, buffer + 2             ; Apuntar al inicio de la entrada
    xor ax, ax                     ; Parte entera
    xor dx, dx                     ; Parte decimal
    xor bx, bx                     ; Contador de decimales
    mov cx, 0                      ; Indicador de signo (0=positivo, 1=negativo)

    cmp byte [si], '-'             ; Verificar si es negativo
    jne read_loop
    inc si
    mov cx, 1                      ; Marcar como negativo

read_loop:
    mov bl, [si]
    cmp bl, 0Dh                    ; Fin de entrada
    je read_done
    cmp bl, '.'                    ; Punto decimal
    je read_decimal
    
    sub bl, '0'                    ; Convertir a numero
    mov dx, ax                     ; Guardar valor actual
    mov ax, 10
    mul dx                         ; Multiplicar por 10
    add ax, bx                     ; Sumar nuevo digito
    inc si
    jmp read_loop

read_decimal:
    inc si
    mov bx, 0                      ; Contador de decimales

decimal_loop:
    mov dl, [si]
    cmp dl, 0Dh                    ; Fin de entrada
    je read_done
    sub dl, '0'                    ; Convertir a numero
    mov dh, dl
    mov dl, 10
    mul dl                         ; Multiplicar parte decimal por 10
    add dx, bx                     ; Sumar nuevo digito decimal
    inc si
    inc bx
    cmp bx, 2                      ; Limitar a 2 decimales
    jl decimal_loop

read_done:
    ; Se Ajusta a 2 decimales
    cmp bx, 0
    je no_decimals
    cmp bx, 1
    je one_decimal

two_decimals:
    jmp store_result

one_decimal:
    mov bx, 10
    mul bx                         ; Multiplicar por 10 si solo hay 1 decimal
    jmp store_result

no_decimals:
    mov bx, 100
    mul bx                         ; Multiplicar por 100 si no hay decimales

store_result:
    cmp cx, 1                      ; Aplicar signo negativo si es necesario
    jne no_negate_float
    neg ax
    neg dx
    
no_negate_float:
    mov word ptr [bp-2], ax        ; Guardar parte entera
    mov word ptr [bp-4], dx        ; Guardar parte decimal
    popa
    ret 
    

; Conversion Fahrenheit a Celsius
fahrenheit_to_celsius_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    sub ax, 32                     ; Restar 32
    mov bx, 5
    imul bx                        ; Multiplicar por 5
    mov bx, 9
    idiv bx                        ; Dividir por 9
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret

; Conversion Celsius a Fahrenheit (nota: formula incorrecta en el original)
celsius_to_fahrenheit_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    sub ax, 32                     ; Restar 32 (deberia ser mul 9/5 + 32)
    mov bx, 5
    imul bx                        ; Multiplicar por 5
    mov bx, 9
    idiv bx                        ; Dividir por 9
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret

; Conversion Celsius a Kelvin
celsius_to_kelvin_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    add ax, 273                    ; Sumar 273
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret

; Conversion Kelvin a Celsius
kelvin_to_celsius_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 273
    sub ax, bx                     ; Restar 273
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Fahrenheit a Kelvin
fahrenheit_to_kelvin_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    sub ax, 32                     ; Restar 32
    mov bx, 5  
    imul bx                        ; Multiplicar por 5
    mov bx, 9
    idiv bx                        ; Dividir por 9
    add ax, 273                    ; Sumar 273
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Kelvin a Fahrenheit
kelvin_to_fahrenheit_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    sub ax, 273                    ; Restar 273
    mov bx, 9   
    imul bx                        ; Multiplicar por 9
    mov bx, 5
    idiv bx                        ; Dividir por 5
    add ax, 32                     ; Sumar 32
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Pulgadas a Centimetros
pulgadas_to_centimetros_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 254   
    imul bx                        ; Multiplicar por 254 (2.54 * 100)
    mov bx, 100
    idiv bx                        ; Dividir por 100
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Pies a Centimetros
pies_to_centimetros_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 3048   
    imul bx                        ; Multiplicar por 3048 (30.48 * 100)
    mov bx, 100  
    idiv bx                        ; Dividir por 100
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Yardas a Centimetros
yardas_to_centimetros_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 9144   
    imul bx                        ; Multiplicar por 9144 (91.44 * 100)
    mov bx, 100  
    idiv bx                        ; Dividir por 100
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Millas a Kilometros
millas_to_kilometros_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 1609   
    imul bx                        ; Multiplicar por 1609 (1.609 * 1000)
    mov bx, 1000
    idiv bx                        ; Dividir por 1000
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Centimetros a Pulgadas
centimetros_to_pulgadas_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 100   
    imul bx                        ; Multiplicar por 100
    mov bx, 254
    idiv bx                        ; Dividir por 254 (2.54 * 100)
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Centimetros a Pies
centimetros_to_pies_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 100   
    imul bx                        ; Multiplicar por 100
    mov bx, 3048  
    idiv bx                        ; Dividir por 3048 (30.48 * 100)
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Centimetros a Yardas
centimetros_to_yardas_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 100   
    imul bx                        ; Multiplicar por 100
    mov bx, 9144
    idiv bx                        ; Dividir por 9144 (91.44 * 100)
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Kilometros a Millas
kilometros_to_millas_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 1000   
    imul bx                        ; Multiplicar por 1000
    mov bx, 1609
    idiv bx                        ; Dividir por 1609 (1.609 * 1000)
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Onzas a Kilos
onzas_to_kilos_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 1000   
    imul bx                        ; Multiplicar por 1000
    mov bx, 35274  
    idiv bx                        ; Dividir por 35274 (aprox 0.0283495 * 1000)
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Libras a Kilos
libras_to_kilos_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 1000   
    imul bx                        ; Multiplicar por 1000
    mov bx, 2205  
    idiv bx                        ; Dividir por 2205 (aprox 0.453592 * 1000)
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Toneladas a Kilos
toneladas_to_kilos_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 1000
    imul bx                        ; Multiplicar por 1000
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Kilos a Onzas
kilos_to_onzas_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 35274   
    imul bx                        ; Multiplicar por 35274 (aprox 0.0283495 * 1000)
    mov bx, 1000  
    idiv bx                        ; Dividir por 1000
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Kilos a Libras
kilos_to_libras_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 2205   
    imul bx                        ; Multiplicar por 2205 (aprox 0.453592 * 1000)
    mov bx, 1000  
    idiv bx                        ; Dividir por 1000
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    
; Conversion Kilos a Toneladas
kilos_to_toneladas_convert:
    pusha
    mov ax, word ptr [bp-2]        ; Parte entera
    mov dx, word ptr [bp-4]        ; Parte decimal
    
    mov bx, 1000
    idiv bx                        ; Dividir por 1000
    
    mov word ptr [bp-6], ax        ; Guardar resultado
    mov word ptr [bp-8], dx        ; Guardar resto
    popa
    ret
    

; Convertir float a string
float_to_string:
    pusha
    lea di, result                 ; Apuntar al buffer de resultado
    mov ax, word ptr [bp-6]        ; Parte entera
    
    cmp ax, 0                      ; Verificar si es negativo
    jge positive_num
    neg ax
    mov byte [di], '-'             ; Agregar signo
    inc di

positive_num:
    mov cx, 10
    xor bx, bx

int_loop:
    xor dx, dx
    div cx                         ; Dividir por 10
    add dl, '0'                    ; Convertir a caracter
    push dx                        ; Guardar digito
    inc bx
    test ax, ax                    ; Continuar si no es 0
    jnz int_loop

store_int:
    pop dx
    mov [di], dl                   ; Almacenar digito
    inc di
    dec bx
    jnz store_int                  ; Repetir hasta terminar

    mov byte [di], '.'             ; Punto decimal
    inc di
    
    mov ax, word ptr [bp-8]        ; Parte decimal
    mov cx, 100
    mul cx                         ; Escalar a 2 decimales
    mov cx, 10
    
    mov bx, 2                      ; 2 decimales
decimal_output:
    xor dx, dx
    div cx                         ; Extraer digito decimal
    add dl, '0'                    ; Convertir a caracter
    mov [di], dl                   ; Almacenar
    inc di
    dec bx
    jnz decimal_output             ; Repetir para 2 decimales
    
    mov byte [di], '$'             ; Fin de cadena
    popa
    ret

invalid_option:
    lea dx, invalid_msg            ; Mostrar mensaje de error
    mov ah, 9
    int 21h
    jmp start                      ; Volver al inicio

ask_continue:
    lea dx, continue_msg           ; Preguntar si continuar
    mov ah, 9
    int 21h
    mov ah, 1
    int 21h                        ; Leer respuesta
    sub al, '0'

    cmp al, 1
    je inicio                      ; Continuar
    cmp al, 2
    je exit                        ; Salir
    jmp ask_continue               ; Repetir si opcion invalida

exit:
    mov ax, 4C00h                  ; Terminar programa
    int 21h

ends
