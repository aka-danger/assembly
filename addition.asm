.386 												;generate 32-bit machine code
.MODEL FLAT											;use flat memeory  model
INCLUDE io.inc

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD  ; prepare for system call [ExitProcess]

.STACK 4096											;stack of 4096-bytes

.DATA												;global variables
	
	eaxStr BYTE "eax = ", 0, 0
	ebxStr BYTE "ebx = ", 0, 0
	ecxStr BYTE "ecx = ", 0, 0
	edxStr BYTE "edx = ", 0, 0
	
	nl BYTE " ", 10 , 0

	number DWORD 5
	
.CODE								
_start:

	mov eax, number
	add eax, 5
	INVOKE OutputStr, ADDR eaxStr
	INVOKE OutputInt,eax
	INVOKE OutputStr, ADDR nl
	
	mov ebx, number
	add ebx, 10
	INVOKE OutputStr, ADDR ebxStr
	INVOKE OutputInt,ebx
	INVOKE OutputStr, ADDR nl
	
	
	mov ecx, number
	add ecx, 2
	INVOKE OutputStr, ADDR ecxStr
	INVOKE OutputInt,ecx
	INVOKE OutputStr, ADDR nl
	
	mov edx, number
	add edx, 3
	INVOKE OutputStr, ADDR edxStr
	INVOKE OutputInt,edx
	INVOKE OutputStr, ADDR nl
	
	;conclusion
	;all registers can do ADDITION
	
	INVOKE ExitProcess, 0 							;system call to exit program
	
PUBLIC _start										;make entry point public
END