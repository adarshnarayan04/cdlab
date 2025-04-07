%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}
%union
{ int intval;
  float realval;
  char* name;
  struct attr
  { char *place;
    short type; 
  } twoattr;
}

%right '='
%left '+' '-'
%left '*' '/' '%'
%token <name> ID
%token <intval> INT 
%token <realval> REAL
%type  <twoattr> E
%%
Dlist: Dlist A ';' {printf("Reduced by Dlist A ; to D \n");}
         | {printf("Reduced by epilson to Dlist \n");} 
A: ID '=' E  {printf("Reduce by ID = E ;\n");}
   ;
E: E '*' E {printf(" Reduce E * E to E \n");} 
   | E '/' E  {printf(" Reduce E / E to E \n");}
   | E '%' E  {printf(" Reduce E mod E to E \n");}
   | E '+' E  {printf(" Reduce E + E to E \n");}
   | E '-' E  {printf(" Reduce E - E to E \n");}
   | ID      {printf(" Reduce ID to E : %s\n", $1);}
   | INT     {printf(" Reduce ID to E \n");}
   ;
%%

void yyerror (char* mess)
{ fprintf(stderr, "%s\n", mess); }

int main()
{ 
  yyparse(); 
  return 0;
}
