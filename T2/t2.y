

%{
#include <stdio.h>
	extern int nlines ;

	int yyerror(char *s) ;
	int yyparse(void);
	int yylex(void);  
	int yywrap()
	{
		return 1;
	}
%}

	%token PROGRAM 
	%token PROCEDURE
	%token VAR
	%token CONST
	%token SIMB_BEGIN
	%token END
	%token IF
	%token THEN
	%token ELSE
	%token INTEGER
	%token REAL
	%token CHAR
	%token ID
	%token NUM_INTEGER
	%token NUM_REAL
	%token INVALID_NUM_INT
	%token INVALID_NUM_REAL
	%token INVALID_CHAR
	%token SIMB_SEMI_COLON
	%token SIMB_COLON
	%token SIMB_ATRIBUTION
	%token SIMB_MINUS
	%token SIMB_PLUS
	%token SIMB_MUL
	%token SIMB_DIV
	%token SIMB_DOT
	%token SIMB_OPEN_PARENTESIS
	%token SIMB_CLOSE_PARENTESIS
	%token SIMB_COMMA
	%token SIMB_LESS
	%token SIMB_GREATER
	%token SIMB_DIF
	%token SIMB_GREATER_EQUAL
	%token ERROR
	%token CHARACTER
	%token SIMB_EQUAL
	%token READ
	%token WRITE


%%

programa: PROGRAM ID SIMB_SEMI_COLON corpo SIMB_DOT {return 0;}
			|PROGRAM ID SIMB_SEMI_COLON corpo  {printf("Linha %d: Erro Sintático: Esperado ponto final.\n", nlines);} ; 

corpo:	dc SIMB_BEGIN comandos END
		| dc SIMB_BEGIN comandos {printf("Linha %d: Erro Sintático: Esperado END.\n", nlines);};

dc:	dc_c dc_v dc_p

dc_c: CONST ID SIMB_EQUAL numero SIMB_SEMI_COLON dc_c
	  | 
	  | CONST ID SIMB_EQUAL numero SIMB_COLON dc_c   {printf("Linha: %d: Erro sintático: Esperado ponto e vírgula \";\".\n", nlines);} ;

dc_v: VAR variaveis SIMB_COLON tipo_var SIMB_SEMI_COLON dc_v
	  | 
	  | VAR variaveis SIMB_SEMI_COLON tipo_var SIMB_SEMI_COLON dc_v {printf("Linha: %d: Erro sintático: Esperado dois pontos \":\".\n", nlines);} 
	  | VAR variaveis SIMB_SEMI_COLON tipo_var SIMB_COLON dc_v {printf("Linha: %d: Erro sintático: Esperado dois pontos \":\" e ponto e vírgula \";\".\n", nlines);} 
	  | VAR variaveis SIMB_COLON tipo_var SIMB_COLON dc_v {printf("Linha: %d: Erro sintático: Esperado ponto e vírgula \";\".\n", nlines);} ;

tipo_var:	REAL
			| INTEGER
			| CHAR ;

variaveis:	ID mais_var ;

mais_var:	SIMB_COMMA variaveis
			| ;

dc_p:	PROCEDURE ID parametros SIMB_SEMI_COLON corpo_p dc_p
		| ;

parametros:	SIMB_OPEN_PARENTESIS lista_par SIMB_CLOSE_PARENTESIS
			| ;

lista_par:	variaveis SIMB_COLON tipo_var  mais_par ;

mais_par:	SIMB_SEMI_COLON lista_par 
			| 
			| SIMB_COMMA lista_par {printf("Linha: %d: Erro sintário: Esperavamos por pronto e virgula \";\".\n", nlines);} ;

corpo_p:	dc_loc SIMB_BEGIN comandos END SIMB_SEMI_COLON ;

dc_loc:		dc_v ;

lista_arg:	SIMB_OPEN_PARENTESIS argumentos SIMB_CLOSE_PARENTESIS
			| ;

argumentos:	ID mais_id;

mais_id:	SIMB_SEMI_COLON argumentos
			| ;

pfalsa:		ELSE cmd 
			| ;

comandos:	cmd SIMB_SEMI_COLON comandos
			|
			| cmd comandos {printf("Linha %d: Erro Sintático: Esperado ponto e vígula \";\".\n", nlines); }
			| cmd SIMB_COMMA comandos {printf("Linha %d: Erro Sintático: Esperado ponto e vígula \";\".\n", nlines); };

cmd:		ID lista_arg
			| IF condicao THEN cmd pfalsa
			| ID SIMB_ATRIBUTION expressao 
			| ID SIMB_ATRIBUTION CHARACTER 
			| READ SIMB_OPEN_PARENTESIS variaveis SIMB_CLOSE_PARENTESIS 
			| WRITE SIMB_OPEN_PARENTESIS variaveis SIMB_CLOSE_PARENTESIS ;

condicao:	expressao relacao expressao ;

relacao:	SIMB_EQUAL
			| SIMB_GREATER
			| SIMB_DIF
			| SIMB_LESS
			| SIMB_GREATER_EQUAL ;

expressao:	termo outros_termos ;

op_un:		SIMB_PLUS
			| SIMB_MINUS
			| ;

outros_termos:	op_ad termo outros_termos
				| ;

op_ad:		SIMB_PLUS
			| SIMB_MINUS ;

termo:		op_un fator mais_fatores ;

mais_fatores: op_mul  fator mais_fatores 
			  | ;

op_mul:		SIMB_MUL 
			| SIMB_DIV ;

fator:		ID 
			| numero
			| SIMB_OPEN_PARENTESIS expressao SIMB_CLOSE_PARENTESIS 
			| error SIMB_OPEN_PARENTESIS expressao {printf("Linha %d: Erro sintático: Esperado fechamento de parenteses.\n", nlines);} ;

numero:		NUM_INTEGER 
			| NUM_REAL ;



%%

int main() {
	return yyparse() ;
}

int yyerror(char *s) {
	fprintf(stdout, "%s\n", s) ;
}
