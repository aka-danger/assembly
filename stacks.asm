.386 												;generate 32-bit machine code
.MODEL FLAT											;use flat memeory  model
INCLUDE io.inc

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD  ; prepare for system call [ExitProcess]

.STACK 4096											;stack of 4096-bytes

.DATA												;global variables

n DWORD 10

w BYTE 'Enter how many times to say hello :', 10 , 0
h BYTE 'hello',10,0

prompt BYTE 'choose a mode [00.]',10, 0
prompt1 BYTE '-------------------',10,0
prompt2 BYTE 'simple version: 0',10,0
prompt3 BYTE 'Loop version: 1',10,0
prompt4 BYTE 'enter 3 numbers to add together',10,0

.CODE								
_start:

	INVOKE OutputStr,ADDR prompt
	INVOKE OutputStr, ADDR prompt1
	INVOKE OutputStr, ADDR prompt2
	INVOKE OutputStr, ADDR prompt3
	;STACKS V1
	INVOKE InputInt
	cmp eax,0
	jz simple
		
	loopVersion:
		;STACK TO SAVE USER INPUT (USING LOCAL VARABLES)
			INVOKE OutputStr, ADDR w
			push ebp		; save ebp
			mov ebp,esp		;set stack frame
			sub esp, 4		;reserve space for 1 DWORD [int x]
			
			INVOKE InputInt
			mov [ebp-4],eax	;x = userInput
			
			mov ecx , [ebp-4]	; ecx = x
			
			mov esp, ebp
			pop ebp				;delete stack 
			
			;INVOKE OutputInt, ecx
			
			forLoop:
				INVOKE OutputStr, ADDR h ;print hello
			loop forLoop
			
		jmp endProgram		;jump to end of simple

	simple:	
	
			INVOKE OutputStr, ADDR prompt4
			push ebp		;save tail or head /doesnt move address
			mov ebp, esp	;create stack frame
			sub esp,12		;reserve 3 DWORDs
			
			INVOKE InputInt 
			mov [ebp-4], eax ; int x
			INVOKE InputInt 
			mov [ebp-8], eax ;int y
			INVOKE InputInt 
			mov [ebp-12], eax ;int z 
			
			;calculation
			mov ebx, [ebp-4] ;ebx = x
			add ebx, [ebp-8] ;ebx += y
			add ebx, [ebp-12];ebx += z
			
			mov esp, ebp
			pop ebp			;delete stack
			
			INVOKE OutputInt, ebx
			
		jmp endProgram
	
	endProgram:			
	
	INVOKE ExitProcess, 0 							;system call to exit program
	
PUBLIC _start										;make entry point public
END