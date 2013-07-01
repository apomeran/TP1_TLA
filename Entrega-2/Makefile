all:
	yacc -d grammar.y
	lex lex2.l
	gcc -o jp3Compiler lex.yy.c y.tab.c -ly
compile:
	./parser < myprogram2.py > output.asm
	nasm -f elf -o program.o output.asm
	ld -o program program.o
