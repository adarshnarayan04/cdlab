/* lex script to recognize unsigned integers and a few operators  */
 
%{
#include <stdlib.h>  
void yyerror(char*);
#include "y.tab.h"
%}
ws [ \t\n]+
letter [A-Za-z]
digit  [0-9]
id {letter}({letter}|{digit})*
real ({digit}+\.{digit}+)|({digit}*\.{digit}+)
num {digit}+
%%
{ws}        ;
{id}        {yylval.name=(char*)malloc(sizeof(yytext)); 
             strcpy(yylval.name, yytext); return ID;}
{num}       {yylval.intval=atoi(yytext);return INT;}
{real}      {yylval.realval=atof(yytext);return REAL;}
";"         {return ';';}
"*"         {return '*';}
"/"         {return '/';}
"%"         {return '%';}
"+"         {return '+';}
"-"         {return '-';}
"="         {return '=';}
","         {return ',';}
"["         {return '[';}
"]"         {return ']';}
.           {printf("Unrecognized Character : %s \n", yytext);}
%%
int yywrap(void)
{ return 1; }
