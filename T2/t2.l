/*Declarações*/
%{
	#include "y.tab.h"

	int yyerror(char *s);
	void yytoken(char *token); //Cabeçalho função de token
	int nlines = 1; //Contador de linhas para indicar onde ocorreu um erro
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

%{
/*Caso "COMMENT"*/
%}
"{"			{printf("comentario\n"); BEGIN(COMMENT) ; }
%{/*Ignora pulo de linha e o simbolo de fecha chaves que será tratado a seguir*/
%}
<COMMENT>[^}\n]+
%{
%}
<COMMENT>\n		++nlines;
%{/*Caso fim de arquivo, o comentário não foi fechado e dá erro de fim de arquivo em comentário*/
%}
<COMMENT><<EOF>>	yyerror("Fim do arquivo inesperado! Dentro de comentário");
%{/*Caso o comentário seja terminado corretamente, volta para as regras fora do caso "COMMENT"*/
%}
<COMMENT>"}"	{	BEGIN(INITIAL);}

%{/*Definição de regras sem rotina*/
%}

%{/*Palavras reservadas -> cria o token correspondente*/
%}
program		{return PROGRAM;}
procedure	{return PROCEDURE;}
var		{return VAR;}
const		{return CONST;}

begin		{return SIMB_BEGIN;}
end		{return END;}
if		{return IF;}
then		{return THEN;}
else		{return ELSE;}
read		{return READ;}
write		{return WRITE;}

integer		{return INTEGER;}
real		{return REAL;}
char		{return CHAR;}

%{/*Tokens de tipos específicos -> cria o token correspondente*/
%}
{ident}		{return ID;}
{num_int}	{return NUM_INTEGER;}
{num_real}	{return NUM_REAL;}
{character} {return CHARACTER;}

%{/*Nova linha -> incrementa o numero de linhas*/
%}
{nl}		{nlines++;}

%{/*Espaço em branco -> faz nada*/
%}
{ws}		{}

%{/*Tokens de erro -> Gera a mensagem de erro correspondente*/
%}
{num_int_erro} {printf("Erro léxico: Número inteiro inválido na linha %d\n", nlines);}
{num_real_erro} {printf("Erro léxico: Número real inválido na linha %d\n", nlines);}
{character_erro} {printf("Erro léxico: Caracter inválido na linha %d\n", nlines);}

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
\=		{return SIMB_EQUAL;}


%{/*Caractere avulso -> Gera mensagem de erro correspondente*/
%}
.		{yyerror("Entrada não identificada");}

%%
/*Código em C*/


/*Função que gera o token correspondente*/
void yytoken(char *token) {
   printf("%s - %s\n", yytext, token);
}

