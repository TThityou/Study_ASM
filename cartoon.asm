
STACK  SEGMENT stack
	DB 100 DUP (?)
STACK  ENDS

DATA  SEGMENT
	ASSUME CS : DATA, SS : STACK
	ORG 0108H
MAIN PROC FAR

				MOV DX,0
				MOV AH,0
				MOV AL,2;?????§³
				INT 10H
	start:
				mov  ah,08;????
				int  21h
				cmp  al,'r'
				jz  starton
				cmp  al,'q'
				jz  exiton
	

 starton:
				MOV DX,0
				MOV AH,0
				MOV AL,2;?????§³
				INT 10H
				CALL BG1                ;?????????BG1
				CALL BG2
				CALL BG3
				CALL BG4
				JMP start

	exiton: MOV AH,4CH
					INT 21H
					RET
MAIN ENDP

;?????9
BG1 PROC NEAR                
	MOV DX, 0F06H;1----------------------------------------------------??¦Ë

					;0A0FH;6
					;0A06H;5
					;0506H;4
					;050FH;3
					;0F0FH;2
					;0F06H;1

	R11:																
	
			INC DX;DX????+1
			CALL PUT
			CALL DELAY
			CMP DX,0F0FH;2                   
			JE U11;                        
			JMP R11;                      
	U11:                          
			SUB DX,0100H
			CALL PUT
			CALL DELAY
			CMP DX,050FH;3
			JE L11
			JMP U11

	L11:                          
			DEC DX
			CALL PUT
			CALL DELAY
			CMP DX,0506H;4
			JE D11
			JMP L11


	D11:                           
			ADD DX,0100H
			CALL PUT
			CALL DELAY
			CMP DX,0A06H;5
			JE R12
			JMP D11
	
	R12:															
		INC DX;DX????+1
		CALL PUT
		CALL DELAY
		CMP DX,	0A0FH;6                    
		JE QUIT1;                         
		JMP R12;                       ?????

	QUIT1:                         ;???
		RET
BG1 ENDP

;?????9
BG2 PROC NEAR 
               
	MOV DX, 0F15H;1----------------------------------------------------??¦Ë
					;0A1EH;6
					;0A15H;5
					;0515H;4
					;051EH;3
					;0F1EH;2
					;0F15H;1

	;0515H;4		;051EH;3
	;0A15H;5		;0A1EH;6
	;0F15H;1		;0F1EH;2


	R21:																
	
			INC DX;DX????+1
			CALL PUT
			CALL DELAY
			CMP DX,0F1EH;2                    
			JE U21;                        
			JMP R21;                      
	U21:                          
			SUB DX,0100H
			CALL PUT
			CALL DELAY
			CMP DX,051EH;3
			JE L21
			JMP U21

	L21:                          
			DEC DX
			CALL PUT
			CALL DELAY
			CMP DX,0515H;4
			JE D21
			JMP L21


	D21:                           
			ADD DX,0100H
			CALL PUT
			CALL DELAY
			CMP DX,0A15H;5
			JE R22
			JMP D21
	
	R22:															
		INC DX;DX????+1
		CALL PUT
		CALL DELAY
		CMP DX,	0A1EH;6                    
		JE QUIT2;                         ??????CON1
		JMP R22;                       ?????????LOOP1

	QUIT2:                         ;???
		RET
BG2 ENDP

;??????6
BG3 PROC NEAR                
	MOV DX, 052FH;1----------------------------------------------------??¦Ë			
										;0526H;2				;052FH;1
					
										;0A26H;6				;0A2FH;5

										;0F26H;3				;0F2FH;4
	L31:                          
			DEC DX
			CALL PUT
			CALL DELAY
			CMP DX,0526H;2
			JE D31
			JMP L31
	D31:                           
			ADD DX,0100H
			CALL PUT
			CALL DELAY
			CMP DX,0F26H;3
			JE R31
			JMP D31

	R31:															
			INC DX;DX????+1
			CALL PUT
			CALL DELAY
			CMP DX,0F2FH;4                  
			JE U31;                        
			JMP R31;  

	U31:                          
			SUB DX,0100H
			CALL PUT
			CALL DELAY
			CMP DX,0A2FH;5
			JE L32
			JMP U31
	L32:                          
			DEC DX
			CALL PUT
			CALL DELAY
			CMP DX,0A26H;6
			JE QUIT3
			JMP L32

	QUIT3:                         ;???
		RET
BG3 ENDP

;?????X			
BG4 PROC NEAR                
	MOV DX, 0737H;1----------------------------------------------------??¦Ë
					
					;0526H;2				;052FH;1			
										
					;0A26H;6				;0A2FH;5		   0737H;1			073FH;3

					;0F26H;3				;0F2FH;4		   1036H;4			1040H;2

	DR:
			;ADD DX,0101H 
			CALL PUT                          
			CALL DELAY
			ADD DX,0101H
			CMP DX,1040H;2
			JE WHERE
			JMP DR

	WHERE:MOV DX, 073FH;3----------------------------------------------------??¦Ë
	
	LD:	
			;SUB DX,0101H														
			CALL PUT
			CALL DELAY			
			DEC DX
			ADD DX,0100H
			CMP DX,1036H;4                
			JE QUIT4;                        
			JMP LD;  
	QUIT4:                         ;???
			RET

BG4 ENDP

PUT PROC NEAR                ;PUT?????===??¦Ë??????1?????*
	;???¦Ë??
	MOV AH,02;??????
	MOV BH,0;???
	INT 10H

	MOV AH,0AH									;????§Õ???
	MOV AL,2AH									;"*"--2A,'$'--24
	MOV BH,0
	MOV CX,1										;???1??
	INT 10H
	RET
PUT ENDP

DELAY PROC NEAR             ;DELAY?????===???
	PUSH CX
	PUSH DX
	MOV DX,50
	DL500:MOV CX,2801
	DL10MS:LOOP DL10MS
	DEC DX
	JNZ DL500
	POP DX
	POP CX
	RET
DELAY ENDP

DATA  ENDS
END  






