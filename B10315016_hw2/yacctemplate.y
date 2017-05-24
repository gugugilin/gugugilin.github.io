%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "lex.yy.c"
    // #define Trace(t)        printf(t)
    #define Trace(t)        {printf("[%d]:%s",linenum,t);}
    void yyerror(char *msg);
%}

/* tokens */

%union {
    bool bool_types;
    int int_types;
    double real_types;
    char* string_types;
}


%token COMMA COLON SEMICOLON LEFTPARENTHESES RIGHTPARENTHESES LEFTSQUAREBRACKET RIGHTSQUAREBRACKET LEFTBRACKET RIGHTBRACKET

%token ADDITION MINUS MULTIPLICATION DIVISION EXPONENTIATION REMAINDER LESSTHAN NOTMORETHAN NOTLESSTHAN MORETHAN EQUAL NOTEQUAL AND NOT OR

%token ASSIGNMENT ADDASSIGNMENT MINUSASSIGNMENT MULASSIGNMENT DIVASSIGNMENT

%token IDENTIFIERS

%token<int_types> INTEGERCONSTANTS
%token<real_types> REALCONSTANTS
%token<string_types> STRINGCONSTANTS
%token<bool_types> TRUE
%token<bool_types> FALSE

%token BOOL BREAK CASE CONST CONTINUE DEFAULT ELSE  FOR FUNC GO IF IMPORT INT NIL PRINT PRINTLN REAL RETURN STRING STRUCT SWITCH TYPE VAR VOID WHILE READ

%left OR 
%left AND
%left NOT
%left LESSTHAN NOTMORETHAN EQUAL NOTLESSTHAN MORETHAN NOTEQUAL 
%left ADDITION MINUS
%left MULTIPLICATION DIVISION
%left EXPONENTIATION
%nonassoc UMINUS
%nonassoc UPLUS

%start program

%%

program:        statements | declarations
                {
                    Trace("Reducing to program\n");
                };

// function:       FUNC type IDENTIFIERS LEFTPARENTHESES formal_arguments 
//                 RIGHTPARENTHESES LEFTBRACKET statements RIGHTBRACKET
//                 {
//                     Trace("Reducing to function\n");
//                 };

// formal_arguments: /*empty*/ | formal_argument
//                 {
//                     Trace("Reducing to formal_arguments\n");
//                 };

// formal_argument: IDENTIFIERS | formal_argument ',' IDENTIFIERS 
//                 {
//                     Trace("Reducing to formal_argument\n");
//                 };

statements:     /*empty*/ | declarations statements | statement statements
                {
                    Trace("Reducing to statements\n");
                };

statement:      IDENTIFIERS ASSIGNMENT expression
                |
                IDENTIFIERS LEFTSQUAREBRACKET int_exp RIGHTSQUAREBRACKET ASSIGNMENT expression
                |
                PRINT expression
                |
                PRINTLN expression
                |
                READ IDENTIFIERS
                |
                RETURN | RETURN expression
                {
                    Trace("Reducing to statement\n");
                };

//宣告

type:           BOOL | INT | REAL | STRING
                {
                    Trace("Reducing to type\n");
                };

declarations:   /*empty*/ | declaration declarations
                {
                    Trace("Reducing to declarations\n");
                };

declaration:    variable | consts
                {
                    Trace("Reducing to declaration\n");
                };


arrayconstant:  IDENTIFIERS LEFTSQUAREBRACKET num_exp RIGHTSQUAREBRACKET
                {
                    Trace("Reducing to arrayconstant\n");
                };


array:          VAR IDENTIFIERS LEFTSQUAREBRACKET int_exp RIGHTSQUAREBRACKET type
                {
                    Trace("Reducing to array\n");
                };

consts:         CONST IDENTIFIERS ASSIGNMENT constant_exp
                {
                    Trace("Reducing to const\n");
                };


variable:       VAR IDENTIFIERS type ASSIGNMENT constant_exp 
                | VAR IDENTIFIERS type 
                | array
                {
                    Trace("Reducing to variable\n");
                };


constant_exp:   int_exp | bool_exp | real_exp | STRINGCONSTANTS
                {
                    Trace("Reducing to constant_exp\n");
                };



//表達式



expression:     bool_exp | num_exp | real_exp | STRINGCONSTANTS
                {
                    Trace("Reducing to expression\n");
                };

bool_exp:       LEFTPARENTHESES bool_exp RIGHTPARENTHESES
                | num_exp LESSTHAN num_exp
                | num_exp NOTMORETHAN num_exp
                | num_exp MORETHAN num_exp
                | num_exp NOTLESSTHAN num_exp
                | num_exp EQUAL num_exp
                | num_exp NOTEQUAL num_exp
                | bool_exp AND bool_exp
                | bool_exp OR bool_exp
                | NOT bool_exp
                | TRUE | FALSE
                {
                    Trace("Reducing to bool_exp\n");
                };

num_exp:        LEFTPARENTHESES num_exp RIGHTPARENTHESES
                | num_exp EXPONENTIATION num_exp
                | num_exp ADDITION num_exp
                | num_exp MINUS num_exp
                | num_exp MULTIPLICATION num_exp
                | num_exp DIVISION num_exp
                | MINUS num_exp  %prec UMINUS
                | ADDITION num_exp  %prec UPLUS
                | component
                {
                    Trace("Reducing to num_exp\n");
                };

int_exp:        LEFTPARENTHESES int_exp RIGHTPARENTHESES
                | int_exp EXPONENTIATION int_exp
                | int_exp ADDITION int_exp
                | int_exp MINUS int_exp
                | int_exp MULTIPLICATION int_exp
                | int_exp DIVISION int_exp
                | MINUS int_exp  %prec UMINUS
                | ADDITION int_exp  %prec UPLUS
                | INTEGERCONSTANTS
                {
                    Trace("Reducing to int_exp\n");
                }; 

real_exp:       LEFTPARENTHESES real_exp RIGHTPARENTHESES
                | real_exp EXPONENTIATION real_exp
                | real_exp ADDITION real_exp
                | real_exp MINUS real_exp
                | real_exp MULTIPLICATION real_exp
                | real_exp DIVISION real_exp
                | MINUS real_exp  %prec UMINUS
                | ADDITION real_exp  %prec UPLUS
                | REALCONSTANTS | INTEGERCONSTANTS
                {
                    Trace("Reducing to real_exp\n");
                }; 

component:      INTEGERCONSTANTS | REALCONSTANTS | IDENTIFIERS | arrayconstant 
                {
                    Trace("Reducing to component\n");
                };

//...

semi:           SEMICOLON
                {
                    Trace("Reducing to semi\n");
                };

%%


void yyerror(char *msg)
{
    fprintf(stderr, "%s\n", msg);
}


int main(int argc,char** argv)
{
    /* open the source program file */
    if (argc != 2) {
        printf ("Usage: sc filename\n");
        exit(1);
    }
    yyin = fopen(argv[1], "r");         /* open input file */
    int count=0;
    /* perform parsing */
    while(1)
    {
        if (yyparse() == 1)                 /* parsing */
        {
            count++;
            yyerror("Parsing error !");    /* syntax error */
            break;
        }
        else
            break;
    }
    if(count==0)
        yyerror("\nsave pass!!\n");
    else
        fprintf(stderr,"\nParsing error:%d \n",count);
}


// int main(int argc, char *argv[])
// {
    /* open the source program file */
    // if (argc != 2) {
        // printf ("Usage: sc filename\n");
        // exit(1);
    // }
    // yyin = fopen(argv[1], "r");         /* open input file */

    /* perform parsing */
    // if (yyparse() == 1)                 /* parsing */
        // yyerror("Parsing error !");     /* syntax error */

    // return 0;
// }

