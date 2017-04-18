%option noyywrap
%{
	#include<stdio.h>
%}

%{
	void yyerror(char *message);
	void yytoken(char *token);
	int nlines;
%}

%x COMMENT 

ws		[ \t]*
digit		[0-9]
alpha		[A-Za-z]
alpha_num	({alpha}|{digit})*
ident		{alpha}{alpha_num}*
num_int		{digit}+
num_int_erro {digit}+{alpha}+{alpha_num}
num_real	{digit}+\.{digit}+
num_real_erro ({num_int_erro}\.{alpha_num}+)|({num_int}\.{num_int}*{alpha}+{alpha_num}*)
nl		\n
character \'.\'

character_erro \'.[^\']+\'*

%%


"{"			BEGIN(COMMENT);
<COMMENT>[^}\n]+
<COMMENT>\n		++nlines;
<COMMENT><<EOF>>	yyerror("Fim do arquivo inesperado! Dentro de comentário");
<COMMENT>"}"		BEGIN(INITIAL);



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

{ident}		{yytoken("id");}
{num_int}	{yytoken("num_int");}
{num_real}	{yytoken("num_real");}
{nl}		{nlines++;}
{ws}		{}

{num_int_erro} {yyerror("Número inteiro inválido");}
{num_real_erro} {yyerror("Número real inválido");}

{character} {yytoken("character") ;}
{character_erro} {yyerror("Caracter inválido!"); }

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


.		{yytoken("Entrada não identificada");}

%%

void yyerror(char *message)
{
   printf("Erro: \"%s\" na linha %d. Token = %s\n", message, nlines, yytext);
}

void yytoken(char *token) {
   printf("%s - %s\n", yytext, token);
}


int main()
{
	yylex();
	return 0;
}
