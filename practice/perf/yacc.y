%{
void yyerror(char *);
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int yylex(void);
%}

%union
{
char* name;
int val;
}


%token <val>NUM
%token <name>ID
%token LOGAND
%type <val> S
%type <val> E
%type <val> F
%type <val> G
%type <val> H
%type <val> I

%left '%' LOGAND '-'
%right '!' '='

%%
S : ID '=' E ';'  {printf("%s = %d \n",$1,$3);}
  ;
E: E LOGAND F { $$=$1 && $3;}
  | F { $$=$1;}
  ;
F: F '-' G { $$=$1 - $3;}
  | G { $$=$1;}
  ;
G: G '%' H { $$=$1 % $3;}
  | H { $$=$1;}
  ;
H: '!' H { $$= ! $2;}
  | I { $$=$1;}
  ;
I: '(' E ')' { $$=$2;}
  | NUM { $$=$1;}
;
%%

void yyerror(char *mess)
{
printf("%s\n", mess);
}
int main()
{
yyparse();
return 1;
}
