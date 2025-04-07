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

prog  :   dlist {printf(" End of Declarations : number of statements =  %d \n", dcount);}
      ;
dlist : dlist decl ';' {dcount++; printf(" %d  declaration statements seen \n", dcount);}
      | decl ';'       { dcount++; printf(" %d declaration statement seen \n",dcount);}  
      ;
decl  : type ID {$$.type=$1.type; $$.width = $1.width; 
             printf("Identifier : %s type : %s width : %d offset: %d  \n", $2, 
                     $1.type, $1.width, offset);
             offset+=$1.width;
                 }
      | decl ',' ID 
           {$$.type=$1.type; $$.width = $1.width;
             printf("Identifier : %s type : %s width : %d offset: %d  \n", $3, 
                     $1.type, $1.width, offset);
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
   yyparse (); 
}
