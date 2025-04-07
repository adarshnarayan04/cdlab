%option noyywrap
%{
void yyerror(char *);
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "y.tab.h"
%}

id [a-zA-Z_][a-zA-Z0-9]*
digit [0-9]
ws [\t\n]
%%
{ws} ;
{digit}+ {yylval.val=atoi(yytext); return NUM;}
{id} {yylval.name=strdup(yytext); return ID;}
"-" { return '-';}
";" { return ';';}
"=" { return '=';}
"%" { return '%';}
"!" { return '!';}
"(" { return '(';}
")" { return ')';}
"&&" { return LOGAND;}
. {yyerror("Invalid character \n");}
%%
