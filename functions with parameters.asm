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

	;function (int a, int b, int c)
	;	return a * b + c;
	_addFunc PROC NEAR32
		;entry
		push ebp
		mov ebp, esp
		push edx
		push ecx
		push ebx
		pushfd
		;body
		
		;[ebp + 4] is the return address dont use it
		mov ebx, [ebp + 16]	; ebx = c
		add ebx, [ebp+12]	; ebx += b
		imul ebx, [ebp+8]	; ebx *= a
		mov eax, ebx		; eax = ebx
		;exit
		popfd
		pop ebx
		pop ecx
		pop edx
		mov esp, ebp
		pop ebp
		ret 12				; how many bytes for the parameters if (ebp + 12 = 8) if (ebp + 16 = 12)
	_addFunc ENDP
						
_start:
	;push onto the stack first
	push ebp
	mov ebp, esp
	push 1 			; c
	push 2			; b
	push 2			; a
	
	call _addFunc
	mov result, eax
	INVOKE OutputInt, result
	
	mov esp, ebp
	pop ebp
	INVOKE ExitProcess, 0 							;system call to exit program
	
PUBLIC _start										;make entry point public
END