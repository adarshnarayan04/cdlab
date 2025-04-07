%option noyywrap 

%{
    void yyerror(char*);
    #include "y.tab.h"
%}

ws [ \t\n]+
id [_a-zA-Z][_a-zA-Z0-9]*
int [0-9]+

%%
{ws}      ;
{id}      { yylval.name = strdup(yytext); return ID; }
{int}     { yylval.intval = atoi(yytext); return INT; }
"="       { return '='; }
";"       { return ';'; }
"+"       { return '+'; }
"-"       { return '-'; }
"*"       { return '*'; }
"/"       { return '/'; }
"%"       { return '%'; }
.         ; //yyerror not used ( can used here {yyerror("Invalid \n");})
%%
