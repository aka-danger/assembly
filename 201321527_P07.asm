.386 												;generate 32-bit machine code
.MODEL FLAT											;use flat memeory  model
INCLUDE io.inc

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD  ; prepare for system call [ExitProcess]

.STACK 4096											;stack of 4096-bytes

.DATA												;global variables

n DWORD 10

w BYTE 'hello', 10 , 0

.CODE								
_start:


	INVOKE OutputInt,2
	
	push 0
	call ExitProcess
	
PUBLIC _start								
END