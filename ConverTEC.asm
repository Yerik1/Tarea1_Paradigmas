data segment
    ; mensajes en consola
    bienvenida db "Bienvenido a ConverTec" , 0Dh, 0Ah, "Por favor indique que tipo de conversion desea realizar:" , 0Dh, 0Ah,"Presione:", 0Dh, 0Ah, "$"
    temperatura db "1. Fahrenheit a Celsius" , 0Dh, 0Ah, "2. Celsius a Kelvin" , 0Dh, 0Ah, "3. Kelvin a Celsius" , 0Dh, 0Ah, "4. Fahrenheit a Kelvin", 0Dh, 0Ah, "$"
    distancia1 db "5. Pulgadas a Centimetros", 0Dh, 0Ah, "6. Pies a Centimetros", 0Dh, 0Ah, "7. Yardas a Centimetros", 0Dh, 0Ah, "8. Millas a Kilometros", 0Dh, 0Ah, "$"
    distancia2 db "9. Centimetros a Pulgadas", 0Dh, 0Ah, "10. Centimetros a Pies", 0Dh, 0Ah, "11. Centimetros a Yardas", 0Dh, 0Ah, "12. Kilometros a Millas", 0Dh, 0Ah, "$"  
    masa db "13. Onzas a Kilos", 0Dh, 0Ah, "14. Libras a Kilos", 0Dh, 0Ah, "15. Toneladas a Kilos", 0Dh, 0Ah, "16. Kilos a Onzas", 0Dh, 0Ah, "17. Kilos a Libras", 0Dh, 0Ah, "18. Kilos a Toneladas", 0Dh, 0Ah,"$"
ends

stack segment
    dw   128  dup(0)
ends
        
        
        
        
code segment
start:
    ;Inicializa los segmentos 
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
            
    lea dx, bienvenida
    mov ah, 9
    int 21h   
    
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
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
