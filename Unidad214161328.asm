SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1

segment .data
	msg1 db "ingrese un número", 0xA,0xD
	len1 equ $- msg1

segment .bss
	num1 resb 2

section  .text
	global _start  ;must be declared for using gcc
_start:  ;tell linker entry point

	mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, msg1
	mov edx, len1
	int 0x80
	
	mov eax, SYS_LEE
	mov ebx, STDIN
	mov ecx, num1
	mov edx, 2
	int 0x80
	
;guardo el numero obtenido en cx
    mov ecx, 0
    mov cl, [num1]
    sub cl, '0'
    mov di, 2
    mov ebx, 2
    
;sale si cx es menos a 2
    cmp bl, cl
    JA salir

;si es mayor o igual a 2 entonces se pregunta si es par o impar
compara:

;para conocer si es par o impar
    mov eax, 0
    mov al, cl
    mov dl, 0
    div di

; si el residuo guardado en dx es 0 significa que es par de lo contrario impar
    cmp dx, 0
    je espar
    
;si el numero dado es impar    
    mov eax, 0
    mov al, cl
    mov bl, 3
    mul bl
    
 ;para sumarle el uno
    mov ebx, 0
    mov bl, 1
    add al, bl
    
    jmp imprimir

; si el valor obtenido es par
espar:
    mov ebx, 0
    mov bl, 2
    mov eax, 0
    mov al, cl
    div bl
    
imprimir:
;el registro esi para guardar el resultado
    mov esi, 0
    mov esi, eax
    add eax, 48
    mov [num1], eax
    
; se imprime el numero
    mov eax, SYS_PRINT
    mov ebx, STDOUT
    mov ecx, num1
    mov edx, 2
    int 0x80
    
; se obtiene el resultado de di para saber si se volvera a iterar
    mov ecx, 0
    mov ecx, esi
    mov edx, 1
    
    cmp cl, dl
    
ja compara
   

salir:

    mov eax, SYS_SALIDA
	xor ebx, ebx
	int 0x80
	
	
	