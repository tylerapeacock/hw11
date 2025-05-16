	;; ASCII to hexadecimal program
	;; Tyler Peacock
	;; CMSC313 MW0830
	SECTION .data
inputBuf:
	db 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A

	SECTION .bss
outputBuf:
	resb 80
	
	SECTION .text
	global _start

_start:
	;; code here
	mov ecx,0 		;ecx counts num of chars converted to bytes
	mov edx,0 		;edx is num of bytes to print from outputBuf
	mov eax,[inputBuf]
	push 0
conversionStart:
	mov ebx,eax
	and ebx, 0xF0000000 	;mask
	shr ebx,28 		;shift data to rightmost position in register
	cmp ebx, 9
	jle numconv 		;check if ebx is alphabetic or numeric
	jg charconv 		;jump accordingly
numconv:
	add ebx,48 		;ascii conversion for number
	jmp movetobuf
charconv:
	add ebx,55 		;ascii conversion for alphabetic character
	jmp movetobuf
movetobuf:	
 	mov [outputBuf+edx],bl	;move to output buffer
	inc edx 		;increment edx after new byte added

	test ecx,1
	jz noSpace 		;test if ecx is even, if not add a space
	
	mov bl,0x20 		;add space to output buffer
	mov [outputBuf+edx],bl
	inc edx 		;increase edx after new  byte added
noSpace:	 		;jump here to avoid adding a space
	rol eax,4 		;rotate eax to set up next char
	
	inc ecx
	cmp ecx,7 		;loop thorugh 8 times for 8 chars
	jle conversionStart

	pop eax
	cmp eax,0		;0 on stack for first pass, 1 for second pass
	jne finish 		;jump to finish
	mov eax,[inputBuf+4] 	;load next data
	mov ecx,0 		;reset count 
	push 1
	jmp conversionStart
finish:	
	mov bl,0xA
	mov [outputBuf+edx],bl
	inc edx			;add linefeed char and increment edx
	;; invoke sys_write
	mov eax,4 		;sys_write opcode
	mov ebx,1 		;stdout
	mov ecx,outputBuf 	;location of data to print
 				;maybe change edx here?
	int 80h
	
	;; invoke sys_exit
	mov ebx,0
	mov eax,1
	int 80h
