%option noyywrap
%{
  // no C code is placed here
%}
  
ws [ \t\n]+                           
digit  [0-9]
octalnum 0[0-7]+
number {digit}+
delimiter ,|;
				 
%%

{ws}      {;}  --> do nothing
{octalnum} {printf(" (Token, Lexeme) = (OCTAL NUMBER, %s)\n", yytext); return (3);}
{number}  {printf(" (Token, Lexeme) = (DECIMAL NUMBER, %s)\n", yytext); return (2);}
{delimiter} {printf(" (Token, Lexeme) = (DELIMITER, '%s')\n", yytext); return (5);}

%%
int main()
{ while(yylex()); 
  return 0;
}
