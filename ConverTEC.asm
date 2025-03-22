data segment
    ; Mensajes mostrados en pantalla
    bienvenida db "Bienvenido a ConverTec", 0Dh, 0Ah, "Por favor indique que tipo de conversion desea realizar:", 0Dh, 0Ah, "Presione:", 0Dh, 0Ah, "$"
    menu_principal db "1. temperatura", 0Dh, 0Ah,"2. Longitud", 0Dh, 0Ah,"3. Masa", 0Dh, 0Ah, "$"
    
    
    ; Opciones de conversion para cada categoria
    opciones_temperatura db "1. Fahrenheit a Celsius", 0Dh, 0Ah,"2. Celsius a Fahrenheit", 0Dh, 0Ah,"3. Celsius a Kelvin", 0Dh, 0Ah,"4. Kelvin a Celsius", 0Dh, 0Ah,"5. Fahrenheit a Kelvin", 0Dh, 0Ah,"6. Kelvin a Fahrenheit", 0Dh, 0Ah, "$"
    
    opciones_longitud db "1. Pulgadas a Centimetros", 0Dh, 0Ah,"2. Pies a Centimetros ", 0Dh, 0Ah,"3. Yardas a centimetros", 0Dh, 0Ah,"4. Millas a kilometros", 0Dh, 0Ah,"5. Centimetros a Pulgadas", 0Dh, 0Ah,"6. Centimetros a Pies", 0Dh, 0Ah,"7. Centimetros a Yardas", 0Dh, 0Ah,"8. Kilometros a Millas", 0Dh, 0Ah, "$"
    
    opciones_masa db "1. Onzas a Kilos", 0Dh, 0Ah, "2. Libras a Kilos", 0Dh, 0Ah, "3. Toneladas a Kilos", 0Dh, 0Ah, "4. Kilos a Onzas", 0Dh, 0Ah, "5. Kilos a Libras", 0Dh, 0Ah, "6. Kilos a Toneladas", 0Dh, 0Ah, "$"
    
    valor_entrada db "Por favor ingrese el valor: $"
    result_msg db "El resultado de la conversion es: $"
    continue_msg db "Presione 1 para continuar o 2 para salir: $"
    invalid_msg db "Opcion invalida, por favor intente de nuevo.", 0Dh, 0Ah, "$"
    buffer db 10 dup('$')  
    result db 10 dup('$')  
    newline db 0Dh, 0Ah, "$"  
ends

stack segment
    dw 128 dup(0)
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
    lea dx, menu_principal
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, '0'  

    cmp al, 1  
    je conversiones_temperatura
    cmp al, 2
    je conversiones_longitud
    cmp al, 3
    je conversiones_masa
      
    jmp invalid_option
    
;Un segundo menu para elegir cual conversion especifica dentro de cada categoria temperatura

conversiones_temperatura:
    ; Inicializa los segmentos 
    mov ax, data
    mov ds, ax
    mov es, ax
    
    
    lea dx, newline
    mov ah, 9
    int 21h
    
    ; Muestra las opciones de conversion de temperatura
    lea dx, opciones_temperatura
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, '0'  ; Convierte la entrada de caracter a numero
    
    
    ;Compara la opcion seleccionada para redirigir a la conversion correspondiente

    cmp al, 1  
    je fahrenheit_celsius
    cmp al, 2
    je celsius_fahrenheit
    cmp al, 3
    je celsius_kelvin
    cmp al, 4
    je kelvin_celsius
    cmp al, 5
    je fahrenheit_kelvin
    cmp al, 6
    je kelvin_fahrenheit
      
    jmp invalid_option  ; Si no se selecciona una opcion valida, muestra mensaje de error

; Conversion de Fahrenheit a Celsius
   

fahrenheit_celsius:
    
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
    
    ; FORMULA
    sub ax, 32         
    mov bx, 5  
    mul bx
    mov bx, 9
    div bx      

    call int_to_string  

    lea dx, newline
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue   
    

; Conversion de celsius a fahrenheit

celsius_fahrenheit:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
    
    ; FORMULA
    mov bx, 9   
    mul bx        
    mov bx, 5  
    div bx
    add ax, 32        

    call int_to_string  

    lea dx, newline
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue  ; Pregunta si desea continuar o salir  
    

; Conversion de celsius a kelvin
celsius_kelvin:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
    
    ; FORMULA
    add ax, 273                

    call int_to_string  

    lea dx, newline
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue   ; Pregunta si desea continuar o salir

; Conversion de kelvin a celsius
kelvin_celsius:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
    
    ; FORMULA
    sub ax, 273                

    call int_to_string  

    lea dx, newline
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue    ; Pregunta si desea continuar o salir


; Conversion de  fahrenheit a kelvin 
fahrenheit_kelvin:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  

     ; FORMULA  
    sub ax, 32        
    mov bx, 5  
    mul bx  
    mov bx, 9
    div bx
    add ax, 273    

    call int_to_string  

    lea dx, newline
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue    ; Pregunta si desea continuar o salir


; Conversion de kelvin a fahrenheit
kelvin_fahrenheit:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
    
    ; FORMULA
    sub ax, 273
    mov bx, 9   
    mul bx        
    mov bx, 5  
    div bx
    add ax, 32
    
                 

    call int_to_string  

    lea dx, newline
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue    ; Pregunta si desea continuar o salir


                     
;Un segundo menu para elegir cual conversion especifica dentro de cada categoria longitud                     
conversiones_longitud:
    ; Inicializa los segmentos 
    mov ax, data
    mov ds, ax
    mov es, ax
    
    
    ; Mostrar opciones de conversion
    
    lea dx, newline
    mov ah, 9
    int 21h
    
    lea dx, opciones_longitud
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, '0'  

    cmp al, 1  
    je libras_a_kilos
    cmp al, 2
    je libras_a_kilos
    cmp al, 3
    je libras_a_kilos
    cmp al, 4
    je libras_a_kilos
    cmp al, 5
    je libras_a_kilos
    cmp al, 6
    je libras_a_kilos
      
    jmp invalid_option
    
    
;Un segundo menu para elegir cual conversion especifica dentro de cada categoria segmentos
conversiones_masa:
    ; Inicializa los segmentos 
    mov ax, data
    mov ds, ax
    mov es, ax
    
    
    ; Mostrar opciones de conversion
    
    lea dx, newline
    mov ah, 9
    int 21h
    
    lea dx, opciones_masa
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, '0'  

    cmp al, 1  
    je libras_a_kilos
    cmp al, 2
    je libras_a_kilos
    cmp al, 3
    je libras_a_kilos
    cmp al, 4
    je libras_a_kilos
    cmp al, 5
    je libras_a_kilos
    cmp al, 6
    je libras_a_kilos
      
    jmp invalid_option

        
      
;Se realiza la conversion de libras a kilos
libras_a_kilos:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  

    mov bx, 454   
    mul bx        
    mov bx, 1000  
    div bx        

    call int_to_string  

    lea dx, newline
    mov ah, 9
    int 21h
    lea dx, result_msg
    mov ah, 9
    int 21h
    lea dx, result
    mov ah, 9
    int 21h
    lea dx, newline
    mov ah, 9
    int 21h

    jmp ask_continue   
    


invalid_option:
    lea dx, invalid_msg
    mov ah, 9
    int 21h
    jmp start

ask_continue:
    lea dx, continue_msg
    mov ah, 9
    int 21h
    mov ah, 1
    int 21h
    sub al, '0'   

    cmp al, 1
    je start  
    cmp al, 2
    je exit  

; Funcion para leer la entrada de datos y guardarla en un buffer
read_input:
    lea dx, buffer
    mov ah, 0Ah
    int 21h

    lea si, buffer + 2  
    mov cx, 0           
    mov ax, 0           

convert_loop:
    mov bl, [si]        
    cmp bl, 0           
    je convert_done     
    cmp bl, '0'         
    jb convert_done     
    cmp bl, '9'
    ja convert_done     

    sub bl, '0'         
    mov dx, 10
    mul dx              
    add ax, bx          
    inc si              
    jmp convert_loop    

convert_done:
    ret

int_to_string:
    lea di, result
    mov cx, 10          
    mov bx, 0           
               
               
; Funcion para convertir un numero entero a su representacion en string               
convert_to_string_loop:
    xor dx, dx          
    div cx              
    add dl, '0'         
    push dx             
    inc bx              
    cmp ax, 0           
    jne convert_to_string_loop

    lea di, result
store_loop:
    pop dx              
    mov [di], dl        
    inc di              
    dec bx              
    cmp bx, 0           
    jne store_loop

    mov byte ptr [di], '$'
    ret 

; Salir del programa
exit:
    mov ax, 4C00h
    int 21h

ends
