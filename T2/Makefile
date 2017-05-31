all: t2.l t2.y
	flex t2.l
	yacc -d t2.y
	gcc y.tab.c lex.yy.c -o out
c: 
	flex t1.l

clean:
	rm y.tab.c
	rm lex.yy.c
