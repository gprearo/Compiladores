
%{
#define PROGRAM 260
#define PROCEDURE 261
#define VAR 262 
#define CONST 263
#define BEGIN 264
#define END 265
#define IF 266
#define THEN 267
#define ELSE 268
#define INTEGER 269
#define REAL 270
#define CHAR 271
#define ID 272
#define NUM_INT 273
#define NUM_REAL 274
#define INVALID_NUM_INT 275
#define INVALID_NUM_REAL 276
#define INVALID_CHAR 277
#define SIMB_SEMI_COLON 278
#define SIMB_COLON 279
#define SIMB_ATRIBUTION 280
#define SIMB_MINUS 281
#define SIMB_PLUS 282
#define SIMB_MUL 283
#define SIMB_DIV 284
#define SIMB_DOT 285
#define SIMB_OPEN_PARENTESIS 286
#define SIMB_CLOSE_PARENTESIS 287
#define SIMB_COMMA 288
#define SIMB_LESS 289
#define SIMB_GREATER 290
#define SIMB_DIF 291
#define SIMB_GREATER_EQUAL 292
#define ERROR 293
#define CHARACTER 294
#define SIMB_EQUAL 295


	int yyparse(void);
	int yylex(void);  
	int yywrap()
	{
		return 1;
	}
%}

	%token PROGRAM 
	%token PROCEDURE
	%token VAR 262define CONST 263
	%token BEGIN
	%token END
	%token IF
	%token THEN
	%token ELSE
	%token INTEGER
	%token REAL
	%token CHAR
	%token ID
	%token NUM_INT
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


%%

programa: PROGRAM ID SIMB_SEMI_COLON corpo SIMB_DOT {return ;} ;

corpo:	dc BEGIN comandos END ;

dc:	dc_c dc_v dc_p ;

dc_c: CONST ID SIMB_ATRIBUTION numero SIMB_SEMI_COLON dc_c
	  | ;

dc_v: VAR variaveis SIMB_COLON tipo_var SIMB_SEMI_COLON dc_v
	  | ;

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
			| ;

corpo_p:	dc_loc BEGIN comandos END SIMB_SEMI_COLON ;

dc_loc:		dc_v ;

lista_arg:	SIMB_OPEN_PARENTESIS argumentos SIMB_CLOSE_PARENTESIS 
			| ;

argumentos:	ID mais_id ;

mais_id:	SIMB_SEMI_COLON argumentos 
			| ;

pfalsa:		ELSE cmd 
			| ;

comandos:	cmd SIMB_SEMI_COLON comandos 
			| ;

cmd:		ID lista_arg 
			| IF condicao THEN cmd pfalsa
			| ID SIMB_ATRIBUTION expressao
			| BEGIN comandos END ;

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
			| SIMB_OPEN_PARENTESIS expressao SIMB_CLOSE_PARENTESIS ;

numero:		NUM_INTEGER 
			| NUM_REAL ;
