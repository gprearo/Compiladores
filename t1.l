%option noyywrap
%{
	#include<stdio.h>
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
/*Definição de regras*/

/*Definição de regras com rotina*/

/*Rotina que identifica um comentário, escrito entre chaves ({}) e o erro caso as chaves não sejam fechadas*/
/*Caso "COMMENT"*/
"{"			BEGIN(COMMENT);
/*Ignora pulo de linha e o simbolo de fecha chaves que será tratado a seguir*/
<COMMENT>[^}\n]+
/*Incrementa o numero de linhas a cada nova linha*/
<COMMENT>\n		++nlines;
/*Caso fim de arquivo, o comentário não foi fechado e dá erro de fim de arquivo em comentário*/
<COMMENT><<EOF>>	yyerror("Fim do arquivo inesperado! Dentro de comentário");
/*Caso o comentário seja terminado corretamente, volta para as regras fora do caso "COMMENT"*/
<COMMENT>"}"		BEGIN(INITIAL);


/*Definição de regras sem rotina*/

/*Palavras reservadas -> cria o token correspondente*/
program		{yytoken("program");}
procedure	{yytoken("procedure");}
var		{yytoken("var");}
const		{yytoken("const");}

begin		{yytoken("begin");}
end		{yytoken("end");}
if		{yytoken("if");}
then		{yytoken("then");}
else		{yytoken("else");}

integer		{yytoken("integer");}
real		{yytoken("real");}
char		{yytoken("char");}

/*Tokens de tipos específicos -> cria o token correspondente}
{ident}		{yytoken("id");}
{num_int}	{yytoken("num_int");}
{num_real}	{yytoken("num_real");}
{character} {yytoken("character") ;}

/*Nova linha -> incrementa o numero de linhas*/
{nl}		{nlines++;}
/*Espaço em branco -> faz nada}
{ws}		{}

/*Tokens de erro -> Gera a mensagem de erro correspondente*/
{num_int_erro} {yyerror("Número inteiro inválido");}
{num_real_erro} {yyerror("Número real inválido");}
{character_erro} {yyerror("Caracter inválido!");}

/*Tokens de símbolos -> cria o token correspondente*/
\;		{yytoken("simb_ponto_virgula");}
\:		{yytoken("simb_dois_pontos");}
\:=		{yytoken("simb_atribuicao");}
\-		{yytoken("simb_menos");}
\+		{yytoken("simb_mais");}
\*		{yytoken("simb_vezes");}
\/		{yytoken("simb_divisao");}
\.		{yytoken("simb_ponto");}
\(		{yytoken("simb_abre_parentese");}
\)		{yytoken("simb_fecha_parentese");}
\,		{yytoken("simb_virgula");}
">"		{yytoken("simb_maior");}
"<"		{yytoken("simb_menor");}
"<>"		{yytoken("simb_dif");}
">="		{yytoken("simb_maior_igual");}

/*Caractere avulso -> Gera mensagem de erro correspondente*/
.		{yytoken("Entrada não identificada");}

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

/*C
int main()
{
	yylex();
	return 0;
}
