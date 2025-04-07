/*C declarations*/
%{ #include <stdio.h>
   #include <string.h>
   extern int yylineno, yychar;
   void yyerror(char *);
   int yylex();
   int dcount = 0;
   int offset=0;
%}

/* YACC Declarations */

%union
{ 
  char* name;
  struct attr
  { char * type;
    int width;
  } typeattr; 
}
%token <name> ID 
%token <typeattr> INT FLOAT
%type <typeattr> type decl

%%

prog  :   dlist;
      
dlist : dlist decl ';' {dcount++;}
      | decl ';'       { dcount++;} 
      ;
decl  : type ID {$$.type=$1.type; $$.width = $1.width; 
             printf("%s  %s  \n", $2, 
                     $1.type);
             offset+=$1.width;
                 }
      | decl ',' ID 
           {$$.type=$1.type; $$.width = $1.width;
             printf("%s  %s  \n", $3, 
                     $1.type);
             offset+=$1.width;
            }

      ;
type  : INT {$$.type=$1.type; $$.width = $1.width;}
      | FLOAT{$$.type=$1.type; $$.width = $1.width;}
      ;

%%
void yyerror(char *s)
     {printf(" %s  line number : %d near symbol %c  \n", s, yylineno, (char) yychar); }
    
int main ()
{  // yydebug = 1;
  symtable_init(0, NULL);
   yyparse (); 
}
