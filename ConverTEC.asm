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
    sub ax, 3200      ;Se escalan los valores para AX ya que este se escalo para guardar campo para los decimales con dos ceros demas   
    mov bx, 5  
    imul bx
    mov bx, 9
    idiv bx      

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
    imul bx        
    mov bx, 5  
    idiv bx
    add ax, 3200     ;Se escalan los valores para AX ya que este se escalo para guardar campo para los decimales con dos ceros demas    

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
    add ax, 27300      ;Se escalan los valores para AX ya que este se escalo para guardar campo para los decimales con dos ceros demas           

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
    sub ax, 27300      ;Se escalan los valores para AX ya que este se escalo para guardar campo para los decimales con dos ceros demas           

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
    sub ax, 3200       ;Se escalan los valores para AX ya que este se escalo para guardar campo para los decimales con dos ceros demas  
    mov bx, 5  
    imul bx  
    mov bx, 9
    idiv bx
    add ax, 27315     ;Se escalan los valores para AX ya que este se escalo para guardar campo para los decimales con dos ceros demas

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
    sub ax, 27315        ;Se escalan los valores para AX ya que este se escalo para guardar campo para los decimales con dos ceros demas
    mov bx, 9   
    imul bx        
    mov bx, 5  
    idiv bx
    add ax, 3200     ;Se escalan los valores para AX ya que este se escalo para guardar campo para los decimales con dos ceros demas
    
                 

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


                     
;Un segundo menu para elegir cual conversion especifica dentro de cada categoria                      
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
    je pulgadas_centimetros
    cmp al, 2
    je pies_centimetros
    cmp al, 3
    je yardas_centimetros
    cmp al, 4
    je millas_kilometros
    cmp al, 5
    je centimetros_pulgadas
    cmp al, 6
    je centimetros_pies
    cmp al, 7
    je centimetros_yardas
    cmp al, 8
    je kilometros_millas
      
    jmp invalid_option

;Realiza la conversion de pulgadas a centimetros
pulgadas_centimetros:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
    
    ; FORMULA
    mov bx, 254   
    imul bx        
    mov bx, 100  
    idiv bx
    
                 

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
    
    
;Realiza la conversion de pies a centimetros
pies_centimetros:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
    
    ; FORMULA
    mov bx, 3048   
    imul bx        
    mov bx, 100  
    idiv bx
    
                 

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
    
    
;Realiza la conversion de yardas a centimetros
yardas_centimetros:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
    
    ; FORMULA
    mov bx, 9144   
    imul bx        
    mov bx, 100  
    idiv bx
    
                 

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
    
    
    
;Realiza la conversion de millas a kilometros
millas_kilometros:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
    
    ; FORMULA
    mov bx, 16093   
    imul bx        
    mov bx, 10000  
    idiv bx
    
                 

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
    
     
;Realiza la conversion de centimetros a pulgadas
centimetros_pulgadas:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
    
    ; FORMULA
    mov bx, 100   
    imul bx        
    mov bx, 254  
    idiv bx
    
                 

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
    
    
;Realiza la conversion de centimetros a pies
centimetros_pies:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
    
    ; FORMULA
    mov bx, 100   
    imul bx        
    mov bx, 3048  
    idiv bx
    
                 

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
    
    
;Realiza la conversion de centimetros a yardas
centimetros_yardas:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
    
    ; FORMULA
    mov bx, 100   
    imul bx        
    mov bx, 9144  
    idiv bx
    
                 

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
    
       
;Realiza la conversion de kilometros a millas     

kilometros_millas:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
    
    ; FORMULA
    mov bx, 10000   
    imul bx        
    mov bx, 16093  
    idiv bx
    
                 

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

    
    
;Un segundo menu para elegir cual conversion especifica dentro de cada categoria 

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
    je onzas_kilos
    cmp al, 2
    je libras_kilos
    cmp al, 3
    je toneladas_kilos
    cmp al, 4
    je kilos_onzas
    cmp al, 5
    je kilos_libras
    cmp al, 6
    je kilos_toneladas
      
    jmp invalid_option

        
      
;Realiza la conversion de Onzas a Kilos

onzas_kilos:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  

    mov bx, 1000   
    imul bx        
    mov bx, 35274  
    idiv bx        

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


;Realiza la conversion de libras a kilos
libras_kilos:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  

    mov bx, 1000   
    imul bx        
    mov bx, 2205  
    idiv bx        

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
    
;Realiza la conversion de toneladas a kilos
toneladas_kilos:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  

    mov bx, 1000   
    imul bx        
         

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

;Realiza la conversion de kilos a onzas    
kilos_onzas:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  

    mov bx, 35274   
    imul bx        
    mov bx, 1000  
    idiv bx        

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
    
    
;Realiza la conversion de kilos a libras
kilos_libras:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  

    mov bx, 2205   
    imul bx        
    mov bx, 1000  
    idiv bx        

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
    
    
;Realiza la conversion de kilos a toneladas    
kilos_toneladas:
    lea dx, valor_entrada
    mov ah, 9
    int 21h

    call read_input  
       
    mov bx, 1000  
    idiv bx        

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

;Consulta si se quiere seguir realizando otras conversiones
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
    mov bx, 100     ;los valores se escalan por 100 para reservar dos decimales para cada resultado(los dos ceros del 100) 
    mul bx
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
    mov cx, bx
    sub cx, 2
    jle no_decimal
    
    
store_loop:
    pop dx              
    cmp bx, 2          
    jne no_point
    mov byte ptr [di], '.'  
    inc di 
    
no_point:
    mov [di], dl        
    inc di              
    dec bx              
    cmp bx, 0           
    jne store_loop

    jmp finish_string
    
    
no_decimal:             ; Caso especial: menos de 2 dígitos
    cmp bx, 0
    je add_zeros
store_no_decimal:
    pop dx
    mov [di], dl
    inc di
    dec bx
    jnz store_no_decimal
add_zeros:
    mov byte ptr [di], '.'  ; Agregar punto
    inc di
    mov byte ptr [di], '0'  ; Agregar ceros
    inc di
    mov byte ptr [di], '0'
    inc di

finish_string:
    mov byte ptr [di], '$'  ; Terminar cadena
    ret

; Salir del programa
exit:
    mov ax, 4C00h
    int 21h

ends
