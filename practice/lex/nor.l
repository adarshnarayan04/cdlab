%option noyywrap

%{

%}

digit [0-9]+
char [a-z]+

%%
{digit} {printf("Token found:%s \n",yytext);return 1;}
{char} {printf("Token found:%s \n",yytext);return 1;}

%%

int main()
{
     while(yylex()); 
     return 0;
}