.386 												;generate 32-bit machine code
.MODEL FLAT											;use flat memeory  model
INCLUDE io.inc

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD  ; prepare for system call [ExitProcess]

.STACK 4096											;stack of 4096-bytes

.DATA												;global variables
space BYTE ' ',0,0
nl BYTE ' ',10,0
value BYTE 'value ',0,0
.CODE	

;function to print arrays
;printArray(Array:DWORD,size:DWORD) 
;param(array)->[ebp+12]
printArray PROC NEAR32
	push ebp
	mov ebp, esp
	push edx
	push ecx
	push ebx
	pushfd
	;body
	mov ecx, 0									;init ecx	
	forL:
		cmp ecx, 10								
		jge forLEnd							
	forLBody:
		mov ebx, [ebp + 8]
		mov edx, ecx
		imul edx, 4 
		add ebx , edx
		
		push [ebx]
		call OutputInt 
		
		inc ecx
		jmp forL							
	forLEnd:
	;end
	popfd
	pop ebx
	pop ecx
	pop edx
	mov esp, ebp
	pop ebp
	ret 4					;relese paramters
printArray ENDP

;function for prac
;array = [ebp+12]
;i = [ebp +8]
func PROC NEAR32
	push ebp
	mov ebp, esp
	push edx
	push ecx
	push ebx
	push eax
	pushfd
	;body
	mov edx, [ebp+8]
	cmp edx, 10
	jge funcEnd
	funcRec:
		mov eax, [ebp+12]			;set to address
		mov ebx, edx
		imul ebx, 4 
		add eax , ebx
		
		mov ecx, [eax]
		imul ecx, 2
		add ecx, 1
		mov [eax], ecx
		
		sub eax, ebx
		
		push eax
		inc edx
		push edx
		call func
	funcEnd:
		;exit
		popfd
		pop eax
		pop ebx
		pop ecx
		pop edx
		mov esp, ebp
		pop ebp
		ret 8
func ENDP
							
_start:

	
	push ebp
	mov ebp, esp
	sub esp, 4				;reserve one local variable which is an array
	
	;FILL ARRAY WITH VALUES
	mov ecx, 0									;init ecx	
	forLoop:
		cmp ecx, 10								
		jge forLoopEnd							
	forLoopBody:
		lea ebx, [ebp - 4]
		mov edx, ecx
		imul edx, 4 
		add ebx , edx
		
		;PROMPT USER
		;push value
		;call OutputStr
		;push ecx
		;call OutputInt
		;push nl
		;call OutputStr
		INVOKE OutputStr, ADDR value
		INVOKE OutputInt,  ecx
		INVOKE OutputStr,ADDR nl
		
		call InputInt
		mov [ebx], eax
				
		inc ecx
		jmp forLoop							
	forLoopEnd:
	
	lea edx, [ebp-4]
	push edx				;array address
	call printArray
	
	INVOKE OutputStr,ADDR nl
	
						;size
	lea edx, [ebp-4]
	push edx
	push 0	
	call func
	
	lea edx, [ebp-4]
	push edx				;array address
	call printArray
	
	mov esp, ebp
	pop ebp					
	
	push 0
	call ExitProcess							
	
PUBLIC _start										
END