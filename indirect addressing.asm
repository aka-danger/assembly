.386
.MODEL FLAT
INCLUDE io.inc

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD  ; prepare for system call [ExitProcess]

.STACK 4096

.DATA
n DWORD 5
nl BYTE ' ',10,0
z DWORD 12

.CODE								
_start:
	;INDIRECT ADDRESSING
	;NOTE: THE OutputInt AND OUTPUTSTR ALTER EAX
	lea edx, n
	INVOKE OutputInt,n ; the address of n

	mov DWORD PTR [edx], 11
	INVOKE OutputInt,n ; the address of n
	
	
	
	
	INVOKE ExitProcess, 0 							;system call to exit program
	
PUBLIC _start										;make entry point public
END

