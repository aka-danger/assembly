.386 												;generate 32-bit machine code
.MODEL FLAT											;use flat memeory  model

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD  ; prepare for system call [ExitProcess]

.STACK 4096											;stack of 4096-bytes

.DATA												;global variables

.CODE								
_start:

	INVOKE ExitProcess, 0 							;system call to exit program
	
PUBLIC _start										;make entry point public
END