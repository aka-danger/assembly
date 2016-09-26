.386 												;generate 32-bit machine code
.MODEL FLAT											;use flat memeory  model
INCLUDE io.inc

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD  ; prepare for system call [ExitProcess]

.STACK 4096											;stack of 4096-bytes

.DATA												;global variables

	x DWORD 10
	y DWORD 3
	result DWORD 0
	
.CODE		

	;with functions that return somthing you always 
	;make sure that eax it the returner
	;and you need to not push and pop eax within the function
	_addFunc PROC NEAR32
		;entry
		push ebp
		mov ebp, esp
		sub esp, 8
		push edx
		push ecx
		push ebx
		pushfd
		;function body
		mov ebx, x
		mov [ebp-4], ebx
		mov ebx, y
		mov [ebp - 8], ebx
		
		mov eax, [ebp-4]
		add eax, [ebp-8]
		;exit
		popfd
		pop ebx
		pop ecx
		pop edx
		mov esp, ebp
		pop ebp
		ret
	_addFunc ENDP
						
_start:
	
	call _addFunc
	mov result, eax
	
	INVOKE OutputInt,result
	
	INVOKE ExitProcess, 0 							;system call to exit program
	
PUBLIC _start										;make entry point public
END