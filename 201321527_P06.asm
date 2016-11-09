.386 												;generate 32-bit machine code
.MODEL FLAT											;use flat memeory  model
INCLUDE io.inc

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD  ; prepare for system call [ExitProcess]

.STACK 4096											;stack of 4096-bytes

.DATA												;global variables

	prompt BYTE "Enter base number",10,0
	prompt1 BYTE "Enter Power number",10,0
	
	sym BYTE "^",0,0
	sym1 BYTE " = ",0,0
	
	nl BYTE " ",10,0

.CODE		

	;[ebp+8] -> param1 [base]
	;[ebp+12] -> param2 [exp]
	_power PROC NEAR32
		;entry
		push ebp
		mov ebp, esp
		push edx
		push ecx
		push ebx
		pushfd
		;body
		cmp DWORD PTR[ebp+12], 1	
		jge _powerRec				;if(exp>=1)
		;else						 
		mov eax,1
		jmp _powerEnd				
	_powerRec:						;recursion part
		mov ebx, [ebp+8]			;base
		mov ecx, [ebp+12]			;exp
		sub ecx, 1					;exp -1
		
		push ecx					
		push ebx
		call _power					;recursive call
		imul eax, [ebp+8]			
		jmp _powerEnd
		
	_powerEnd:
		;exit
		popfd
		pop ebx
		pop ecx
		pop edx
		mov esp, ebp
		pop ebp
		ret 8
	_power ENDP

						
_start:
	
	push ebp
	mov ebp, esp
	
	;[user input for base number]
	lea eax,prompt
	push eax 
	call OutputStr					;output messsage [base]
	call InputInt					;input [base]
	mov ebx, eax					;save value in ebx
	
	;[user input for power]
	lea eax, prompt1
	push eax
	call OutputStr					;output message [power]
	call InputInt					;input [power]
	mov ecx, eax
	
	;push parameter to stack
	push ecx						;power
	push ebx						;base
	
	call _power						;call power function
	mov edx,eax						;save result in edx
	
	;RESULT OUTPUT
	lea eax, [ebx]
	push eax
	call OutputInt					;output [base]
	
	lea eax, sym
	push eax
	call OutputStr					;output [^]
	
	lea eax, [ecx]
	push eax
	call OutputInt					;output [power]
	
	lea eax, sym1
	push eax
	call OutputStr					;output [ = ]
	
	lea eax,[edx]
	push eax
	call OutputInt					;output [result]
	
	
	mov esp, ebp
	pop ebp

	push 0
	call ExitProcess
	;INVOKE ExitProcess, 0 							;system call to exit program
	
PUBLIC _start										;make entry point public
END