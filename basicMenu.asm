.386 												;generate 32-bit machine code
.MODEL FLAT											;use flat memeory  model
INCLUDE io.inc

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD  ; prepare for system call [ExitProcess]

.STACK 4096											;stack of 4096-bytes

.DATA												;global variables
	
	prompt BYTE 'Enter an option:',10,0
	prompt1 BYTE '------------------',10,0
	prompt2 BYTE 'say hello: 0',10,0
	hello BYTE 'hello',10,0
	prompt3 BYTE 'say dog: 1',10,0
	dog BYTE 'dog',10,0
	prompt4 BYTE 'say cat: 2',10,0
	cat BYTE 'cat',10,0
	
	
	
.CODE								
_start:

	
	INVOKE OutputStr,ADDR prompt
	INVOKE OutputStr,ADDR prompt1
	INVOKE OutputStr,ADDR prompt2
	INVOKE OutputStr,ADDR prompt3
	INVOKE OutputStr,ADDR prompt4
	
	INVOKE InputInt
	
	cmp eax, 0
	je first
	
	cmp eax, 1
	je second
	
	cmp eax, 2
	je third
	
	
	first:
		INVOKE OutputStr, ADDR hello
		jmp endProgram
	second:
		INVOKE OutputStr, ADDR dog
		jmp endProgram
	third:
		INVOKE OutputStr, ADDR cat
		jmp endProgram
	endProgram:
	
	
	
	
	
	
	
	
	
	
	INVOKE ExitProcess, 0 							;system call to exit program
	
PUBLIC _start										;make entry point public
END