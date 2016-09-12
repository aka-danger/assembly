.386 												;generate 32-bit machine code
.MODEL FLAT											;use flat memeory  model
INCLUDE io.inc

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD  ; prepare for system call [ExitProcess]

.STACK 4096											;stack of 4096-bytes

.DATA												;global variables

n DWORD 10
nl BYTE ' ',10,0

array DWORD 3 DUP (?)

.CODE								
_start:

	; array[n] -> (address of element) = (start address) + ([index of element] * [size of element]))
	
	lea ebx, array
	mov DWORD PTR [ebx], 5  					;array[0] = 5
	mov eax, ebx
	;INVOKE OutputInt, [eax]						;print (array[0])
	
	lea ebx, array
	mov ecx, 1
	imul ecx, 4
	add ebx, ecx
	mov DWORD PTR [ebx], 10						;array[1] = 10
	;INVOKE OutputInt, [ebx]						;print (array[1])
	

	lea ebx, array
	mov ecx, 2
	imul ecx, 4
	add ebx, ecx
	mov DWORD PTR [ebx], 33						;array[2] = 33
	;INVOKE OutputInt, [ebx]						;print (array[2])
	
	;THIS METHOD DOES NOT WORK!!!!!!!! 
	;BECAUSE: IT DEC INSTEAD OF INC
	;	mov ecx, 3
	;forLoop:
	;	INVOKE OutputInt, ecx
	;loop forLoop
	
	mov ecx, 0									;init ecx	
	forLoop:
		cmp ecx, 2								
		jg forLoopEnd							;if(ecx > 2) [end loop]
	forLoopBody:
		
		lea ebx, array
		mov edx, ecx
		imul edx, 4 
		add ebx , edx
		
		INVOKE OutputInt,[ebx]					;print array contents
		INVOKE OutputStr, ADDR nl			
		
		inc ecx
		jmp forLoop							
	forLoopEnd:
	

	INVOKE ExitProcess, 0 							;system call to exit program
	
PUBLIC _start										;make entry point public
END