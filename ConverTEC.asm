data segment
    ; mensajes en consola
    bienvenida db "Bienvenido a ConverTec", 0Dh, 0Ah, "Por favor indique que tipo de conversion desea realizar:", 0Dh, 0Ah, "Presione:", 0Dh, 0Ah, "$"
    temperatura db "1. Fahrenheit a Celsius", 0Dh, 0Ah, "2. Celsius a Kelvin", 0Dh, 0Ah, "3. Kelvin a Celsius", 0Dh, 0Ah, "4. Fahrenheit a Kelvin", 0Dh, 0Ah, "$"
    distancia1 db "5. Pulgadas a Centimetros", 0Dh, 0Ah, "6. Pies a Centimetros", 0Dh, 0Ah, "7. Yardas a Centimetros", 0Dh, 0Ah, "8. Millas a Kilometros", 0Dh, 0Ah, "$"
    distancia2 db "9. Centimetros a Pulgadas", 0Dh, 0Ah, "10. Centimetros a Pies", 0Dh, 0Ah, "11. Centimetros a Yardas", 0Dh, 0Ah, "12. Kilometros a Millas", 0Dh, 0Ah, "$"  
    masa db "13. Onzas a Kilos", 0Dh, 0Ah, "14. Libras a Kilos", 0Dh, 0Ah, "15. Toneladas a Kilos", 0Dh, 0Ah, "16. Kilos a Onzas", 0Dh, 0Ah, "17. Kilos a Libras", 0Dh, 0Ah, "18. Kilos a Toneladas", 0Dh, 0Ah, "$"
    input_prompt db "Por favor ingrese el valor a convertir: $"
    result_msg db "El resultado es: $"
    continue_msg db "Presione 1 para continuar o 2 para salir: $"
    invalid_msg db "Opcion invalida, por favor intente de nuevo.", 0Dh, 0Ah, "$"
    buffer db 10 dup('$')  ; Buffer para almacenar la entrada del usuario
    result db 10 dup('$')   ; Buffer para almacenar el resultado
    newline db 0Dh, 0Ah, "$"  ; Salto de linea
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    ; Inicializa los segmentos 
    mov ax, data
    mov ds, ax
    mov es, ax

    ; Mostrar mensaje de bienvenida
    lea dx, bienvenida
    mov ah, 9
    int 21h

    ; Mostrar opciones de conversion
    lea dx, temperatura
    mov ah, 9
    int 21h
    lea dx, distancia1
    mov ah, 9
    int 21h
    lea dx, distancia2
    mov ah, 9
    int 21h
    lea dx, masa
    mov ah, 9
    int 21h

    ; Leer la seleccion del usuario
    mov ah, 1
    int 21h
    sub al, '0'  ; Convertir el caracter a numero   
    
    

    ; Comparar la seleccion del usuario
    cmp al, 1
    je fahrenheit_to_celsius
    cmp al, 2
    je celsius_to_kelvin
    cmp al, 3
    je kelvin_to_celsius
    cmp al, 4
    je fahrenheit_to_kelvin
    ; Agregar mas comparaciones para las otras opciones...

    ; Si la opcion no es valida
    jmp invalid_option

fahrenheit_to_celsius:

    ; Mostrar mensaje para ingresar la temperatura en Fahrenheit
    lea dx, input_prompt
    mov ah, 9
    int 21h

    ; Leer la entrada del usuario
    call read_input  ; Lee la entrada y la convierte a un número en AX

    ; Convertir Fahrenheit a Celsius
    ; Fórmula: C = (5/9) * (F - 32)
    ; Primero, restamos 32
    sub ax, 32

    ; Multiplicar por 5
    mov bx, 5
    mul bx           ; AX = AX * 5

    ; Dividir por 9
    mov bx, 9
    div bx           ; AX = AX / 9

    ; El resultado está en AX
    ; Convertir el resultado a una cadena para mostrarlo
    call int_to_string

    ; Mostrar el resultado
    lea dx, result_msg
    mov ah, 9
    int 21h
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    ; Preguntar si desea continuar
    jmp ask_continue

celsius_to_kelvin:
    ; Implementar la conversion de Celsius a Kelvin
    ; Similar a fahrenheit_to_celsius
    jmp ask_continue

kelvin_to_celsius:
    ; Implementar la conversion de Kelvin a Celsius
    ; Similar a fahrenheit_to_celsius
    jmp ask_continue

fahrenheit_to_kelvin:
    ; Implementar la conversion de Fahrenheit a Kelvin
    ; Similar a fahrenheit_to_celsius
    jmp ask_continue

invalid_option:
    ; Mostrar mensaje de opcion invalida
    lea dx, invalid_msg
    mov ah, 9
    int 21h
    jmp start

ask_continue:
    ; Preguntar si desea continuar
    lea dx, continue_msg
    mov ah, 9
    int 21h
    ; Leer la seleccion del usuario
    mov ah, 1
    int 21h
    sub al, '0'
    cmp al, 1
    je start  ; Volver al inicio si el usuario desea continuar
    ; Salir si el usuario selecciona 2
    mov ax, 4c00h
    int 21h

read_input:
    ; Leer la entrada del usuario y convertirla a un número en AX
    ; Usamos la interrupción 21h, AH = 0Ah para leer una cadena
    lea dx, buffer
    mov ah, 0Ah
    int 21h

    ; Eliminar el 0Dh (retorno de carro) de la cadena
    lea si, buffer + 1  ; Saltar el primer byte (longitud de la cadena)
    mov cl, [si]        ; Cargar la longitud de la cadena en CL
    xor ch, ch          ; Limpiar CH
    add si, cx          ; Mover SI al final de la cadena

    ; Asegurarnos de que el 0Dh sea reemplazado por el carácter nulo 0
    cmp byte ptr [si], 0Dh  ; Verificar si es el 0Dh (Enter)
    je replace_return
    jmp convert_done

replace_return:
    mov byte ptr [si], 0  ; Reemplazar 0Dh con 0 (fin de cadena)

    ; Convertir la cadena a un número
    lea si, buffer + 2  ; Volver al inicio de la cadena (después del byte de longitud)
    mov cx, 0           ; Inicializar el contador
    mov ax, 0           ; Inicializar el resultado

convert_loop:
    mov bl, [si]        ; Leer un caracter de la cadena
    cmp bl, 0           ; Verificar si es el final de la cadena
    je convert_done     ; Si es el final de la cadena, terminar la conversión
    cmp bl, '0'         ; Verificar si es un digito
    jb convert_done     ; Si no es un digito, terminar la conversion
    cmp bl, '9'
    ja convert_done     ; Si no es un digito, terminar la conversion

    sub bl, '0'         ; Convertir el caracter a número
    mov dx, 10
    mul dx              ; Multiplicar AX por 10
    add ax, bx          ; Sumar el dígito actual
    inc si              ; Mover al siguiente carácter
    jmp convert_loop

convert_done:
    ret



int_to_string:
    ; Convertir el número en AX a una cadena en 'result'
    ; Suponemos que el número es positivo y menor a 1000
    lea di, result
    mov cx, 10          ; Base 10
    mov bx, 0           ; Contador de dígitos

convert_to_string_loop:
    xor dx, dx          ; Limpiar DX para la división
    div cx              ; AX = AX / 10, DX = AX % 10
    add dl, '0'         ; Convertir el residuo a carácter
    push dx             ; Guardar el carácter en la pila
    inc bx              ; Incrementar el contador de dígitos
    cmp ax, 0           ; Verificar si AX es 0
    jne convert_to_string_loop

    ; Extraer los caracteres de la pila y almacenarlos en 'result'
    lea di, result
store_loop:
    pop dx              ; Extraer un carácter de la pila
    mov [di], dl        ; Almacenar el carácter en 'result'
    inc di              ; Mover al siguiente byte
    dec bx              ; Decrementar el contador de dígitos
    cmp bx, 0           ; Verificar si ya se extrajeron todos los dígitos
    jne store_loop

    ; Agregar el carácter nulo al final de la cadena
    mov byte ptr [di], '$'
    ret

ends

end start ; set entry point and stop the assembler.