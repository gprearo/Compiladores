%option noyywrap
%{
	#include<stdio.h>
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

%}

/*Declarações*/
%{
	void yyerror(char *message); //Cabeçalho função de erro
	void yytoken(char *token); //Cabeçalho função de token
	int nlines; //Contador de linhas para indicar onde ocorreu um erro
%}

/*Vai para o espaço de definição das regras do caso "COMMENT" */
%x COMMENT 

/*Definição dos tokens de tipos*/
/*Espaço em branco: tabulação e espaço*/
ws		[ \t]* 
/*Dígito numérico de 0 a 9*/
digit		[0-9] 
/*Letra do alfabeto maiúsculo ou minúsculo*/
alpha		[A-Za-z]
/*Cadeia de letras e números*/
alpha_num	({alpha}|{digit})*
/*Identificador, iniciado com uma letra, e seguido por uma cadeia de letras e/ou números*/
ident		{alpha}{alpha_num}*
/*Numero inteiro*/
num_int		{digit}+ 
/*Número inteiro com erro de escrita*/
num_int_erro {digit}+{alpha}+{alpha_num}
/*Número real*/
num_real	{digit}+\.{digit}+ 
/*Número real com erro de escrita*/
num_real_erro ({num_int_erro}\.{alpha_num}+)|({num_int}\.{num_int}*{alpha}+{alpha_num}*)
/*Nova linha*/
nl		\n

/*Tipo character (char), composto por um caractere qualquer (.) entre apóstrofes ('')*/
character \'.\'
/*Tipo character (char) com erro de escrita*/
character_erro \'.[^\']+\'*

%%
%{/*Definição de regras*/
%}

%{/*Definição de regras com rotina*/
%}

%{/*Rotina que identifica um comentário, escrito entre chaves ({}) e o erro caso as chaves não sejam fechadas*/
/*Caso "COMMENT"*/
%}
"{"			BEGIN(COMMENT);
%{/*Ignora pulo de linha e o simbolo de fecha chaves que será tratado a seguir*/
%}
<COMMENT>[^}\n]+
%{/*Incrementa o numero de linhas a cada nova linha*/
%}
<COMMENT>\n		++nlines;
%{/*Caso fim de arquivo, o comentário não foi fechado e dá erro de fim de arquivo em comentário*/
%}
<COMMENT><<EOF>>	yyerror("Fim do arquivo inesperado! Dentro de comentário");
%{/*Caso o comentário seja terminado corretamente, volta para as regras fora do caso "COMMENT"*/
%}
<COMMENT>"}"		BEGIN(INITIAL);

%{/*Definição de regras sem rotina*/
%}

%{/*Palavras reservadas -> cria o token correspondente*/
%}
program		{return PROGRAM;}
procedure	{return PROCEDURE;}
var		{return VAR;}
const		{return CONST;}

begin		{return BEGIN;}
end		{return END;}
if		{return IF;}
then		{return THEN;}
else		{return ELSE;}

integer		{return INTEGER;}
real		{return REAL;}
char		{return CHAR;}

%{/*Tokens de tipos específicos -> cria o token correspondente*/
%}
{ident}		{return ID;}
{num_int}	{return NUM_INT;}
{num_real}	{return NUM_REAL;}
{character} {return CHAR;}

%{/*Nova linha -> incrementa o numero de linhas*/
%}
{nl}		{nlines++;}

%{/*Espaço em branco -> faz nada*/
%}
{ws}		{}

%{/*Tokens de erro -> Gera a mensagem de erro correspondente*/
%}
{num_int_erro} {yyerror("Número inteiro inválido");}
{num_real_erro} {yyerror("Número real inválido");}
{character_erro} {yyerror("Caracter inválido!");}

%{/*Tokens de símbolos -> cria o token correspondente*/
%}
\;		{return SIMB_SEMI_COLON;}
\:		{return SIMB_COLON;}
\:=		{return SIMB_ATRIBUTION;}
\-		{return SIMB_MINUS;}
\+		{return SIMB_PLUS;}
\*		{return SIMB_MUL;}
\/		{return SIMB_DIV ;}
\.		{return SIMB_DOT;}
\(		{return SIMB_OPEN_PARENTESIS;}
\)		{return SIMB_CLOSE_PARENTESIS;}
\,		{return SIMB_COMMA;}
">"		{return SIMB_GREATER;}
"<"		{return SIMB_LESS;}
"<>"		{return SIMB_DIF;}
">="		{return SIMB_GREATER_EQUAL;}
\=		{return SIMB_EQUAL}


%{/*Caractere avulso -> Gera mensagem de erro correspondente*/
%}
.		{yyerror("Entrada não identificada");}

%%
/*Código em C*/

/*Função que gera mensagem de erro*/
void yyerror(char *message)
{
   printf("Erro: \"%s\" na linha %d. Token = %s\n", message, nlines, yytext);
}

/*Função que gera o token correspondente*/
void yytoken(char *token) {
   printf("%s - %s\n", yytext, token);
}

int main()
{
	yylex();
	return 0;
}
