%option noyywrap
%{
  // no C code is placed here
%}
  
ws [ \t\n]+                           
digit  [0-9]
delimiter ,|;|:
float [0-9]*[.][0-9]*e?E?[+]?[-]?[0-9]*
binary 0b[0-1]+|0B[0-1]+
char ['][^\'][']
hexa 0[xX][0-9a-fA-F]+
leftpar [({\[]
rightpar [)\]}]
keyword int|char|return
comment [/][/][^\t^\n]+
op [+]|[-]|[*]
assignop [=]
string ["][^\"]+["]
identifier [a-zA-z0-9]+
relop >|<|<=|>=
function main|fs|rdi|rcx|cltq
label [.][L][A-Z0-9]+
directive [.][^L^\n]+
bit64 [%][r][a-z]+
bit32 [%][e][a-z]+
long movl|xorl|subl|imull|leal|addl|cmpl
stack call|ret|pushq
jump jle|je|jmp
quad addq|leaq|subq
operand [\$][0-9]+
number [-]?[0-9]+
				 
%%

{ws}      {;}
{delimiter} {printf("DELIMITER: %s\n", yytext); return (5);}
{label} {printf("Label : %s \n",yytext); return(2);}
{directive} {printf("Assembler Directive : %s \n",yytext); return(2);}
{operand} {printf("Immediate Operand : %s \n",yytext); return(2);}
{number} {printf("Number : %s \n",yytext); return(2);}
{function} {printf("Function : %s\n ",yytext); return(2);}
{bit64} {printf("64 bit register operand : %s \n",yytext); return(2);}
{bit32} {printf("32 bit register operand : %s \n",yytext); return(2);}
{long} {printf("Long Word Instructions : %s \n",yytext); return(2);}
{quad} {printf("Quad Word Instrutions : %s \n",yytext); return(2);}
{stack} {printf("Stack Word Instructions : %s \n",yytext); return(2);}
{jump} {printf("Jump Instructions : %s \n",yytext); return(2);}
{leftpar} {printf("LEFT PAR : %s\n", yytext); return (3);}
{rightpar} {printf("RIGHT PAR : %s\n", yytext); return (3);}

%%
int main()
{ while(yylex()); 
  return 0;
}
