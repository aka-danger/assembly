.386 												;generate 32-bit machine code
.MODEL FLAT											;use flat memeory  model
INCLUDE io.inc

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD  ; prepare for system call [ExitProcess]

.STACK 4096											;stack of 4096-bytes

.DATA												;global variables

	x DWORD 5;
	y DWORD 6;
	result DWORD 0;

.CODE			
	
	_addFunc PROC NEAR32 							; near32 makes sure that close adresses are used
		;entry
		push ebp
		mov ebp, esp ;set stack frame
		;save registries
		push edx
		push ecx
		push ebx
		push eax
		;save flag registries
		pushfd
		;function body
		mov eax , x
		add eax, y
		mov result, eax
		;exit
		popfd
		pop eax
		pop ebx
		pop ecx
		pop edx
		mov esp, ebp
		pop ebp
		ret ;return to calling function
	_addFunc ENDP
	
					
_start:
	
	call _addFunc
	
	INVOKE OutputInt,result
	
	INVOKE ExitProcess, 0 							;system call to exit program
	
PUBLIC _start										;make entry point public
END