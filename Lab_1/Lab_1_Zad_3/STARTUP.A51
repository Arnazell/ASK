WINTERFELL SEGMENT CODE
	
poczatek DATA 30h ;pierwszy adres ciagu
koniec DATA 39h ;ostatni adres ciagu
num_a DATA 36h ;siodma cyfra
num_b DATA 39h ;dziesiata cyfra
modulo EQU 4 ; mod 4 (bo zakres 0-3)
	
CSEG AT 0
JMP start
RSEG WINTERFELL
	
start:
	MOV R0, #poczatek
	MOV DPTR, #ciag
	MOV R3, #10 ;ilosc liczb do przepisania
	
	inicjalizacja: ;przepisanie liczb do IRAMu
		MOVC A, @A+DPTR 
		MOV @R0, A
		INC DPTR
		INC R0;
		CLR A;
		DJNZ R3, inicjalizacja
	
	zmiana_adr_gen:
		MOV R0, #num_a ;przenosimy adres 7mej liczby do R0
		MOV R1, #num_b ;przenosimy adres 10tej liczby do R1
	
	generowanie:
		MOV A, @R0 ;do A przenosimy 7ma liczbe
		ADD A, @R1 ;dodajemy 10ta liczbe
		MOV B, #modulo ;do B przenosimy modulo
		DIV AB ;W B pozostaje reszta, czyli liczba pseudolosowa
		MOV A, B ; w A ma zostac liczba pseudolosowa
	
	zmiana_adr_prze:
		MOV R0,#poczatek ; ustawiamy adres pierwszego el
		MOV R1,#poczatek
		INC R1 ; ustawiamy adres elementu R0+1
		MOV R3, #9 ;omijamy ostatni element, czyli 9 iter
		
	przeniesienie: ;przenosimy ciag w IRAM o jeden do przodu
		MOV B, @R1
		MOV @R0,B
		INC R0
		INC R1
		DJNZ R3, przeniesienie
		MOV koniec, A
		JMP zmiana_adr_gen
	
ciag: DB 4, 5, 3, 3, 3, 4, 6, 2, 6, 5
END
