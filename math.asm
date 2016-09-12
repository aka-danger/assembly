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
	number2 DWORD 5
	
.CODE								
_start:


	;only eax can multiply anc divide
	;can only be a memory variable or a reg
	mov eax, number
	mul number2
	
	INVOKE OutputStr,ADDR edxStr
	INVOKE OutputInt,edx
	;INVOKE OutputStr, nl
	
	;INVOKE OutputStr,ADDR edxStr
	;INVOKE OutputInt,edx
	;INVOKE OutputStr, nl
	

	
	
	INVOKE ExitProcess, 0 							;system call to exit program
	
PUBLIC _start										;make entry point public
END