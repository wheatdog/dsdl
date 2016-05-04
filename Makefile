all: sop div_tt

div_tt: div_tt.c
	gcc div_tt.c -o div_tt

sop: sop.c
	gcc sop.c -o sop
