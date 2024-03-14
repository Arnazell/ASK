Stala EQU 1000
DanaL DATA 20h
DanaH DATA 21h
WynikL DATA 30h
WynikH DATA 31h
CSEG AT 0
JMP start
CSEG AT 100h
	start:
	;zmiana wartosci komorek pamieci
	MOV 20h, #18h
	MOV 21h, #00h

	MOV A,DanaL
	ADD A,#low(Stala)
	MOV WynikL,A
	MOV A,DanaH
	ADDC A,#high(Stala)
	MOV WynikH,A
END