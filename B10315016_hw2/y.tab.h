/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    COMMA = 258,
    COLON = 259,
    SEMICOLON = 260,
    LEFTPARENTHESES = 261,
    RIGHTPARENTHESES = 262,
    LEFTSQUAREBRACKET = 263,
    RIGHTSQUAREBRACKET = 264,
    LEFTBRACKET = 265,
    RIGHTBRACKET = 266,
    ADDITION = 267,
    MINUS = 268,
    MULTIPLICATION = 269,
    DIVISION = 270,
    EXPONENTIATION = 271,
    REMAINDER = 272,
    LESSTHAN = 273,
    NOTMORETHAN = 274,
    NOTLESSTHAN = 275,
    MORETHAN = 276,
    EQUAL = 277,
    NOTEQUAL = 278,
    AND = 279,
    NOT = 280,
    OR = 281,
    ASSIGNMENT = 282,
    ADDASSIGNMENT = 283,
    MINUSASSIGNMENT = 284,
    MULASSIGNMENT = 285,
    DIVASSIGNMENT = 286,
    IDENTIFIERS = 287,
    INTEGERCONSTANTS = 288,
    REALCONSTANTS = 289,
    STRINGCONSTANTS = 290,
    TRUE = 291,
    FALSE = 292,
    BOOL = 293,
    BREAK = 294,
    CASE = 295,
    CONST = 296,
    CONTINUE = 297,
    DEFAULT = 298,
    ELSE = 299,
    FOR = 300,
    FUNC = 301,
    GO = 302,
    IF = 303,
    IMPORT = 304,
    INT = 305,
    NIL = 306,
    PRINT = 307,
    PRINTLN = 308,
    REAL = 309,
    RETURN = 310,
    STRING = 311,
    STRUCT = 312,
    SWITCH = 313,
    TYPE = 314,
    VAR = 315,
    VOID = 316,
    WHILE = 317,
    READ = 318,
    UMINUS = 319,
    UPLUS = 320
  };
#endif
/* Tokens.  */
#define COMMA 258
#define COLON 259
#define SEMICOLON 260
#define LEFTPARENTHESES 261
#define RIGHTPARENTHESES 262
#define LEFTSQUAREBRACKET 263
#define RIGHTSQUAREBRACKET 264
#define LEFTBRACKET 265
#define RIGHTBRACKET 266
#define ADDITION 267
#define MINUS 268
#define MULTIPLICATION 269
#define DIVISION 270
#define EXPONENTIATION 271
#define REMAINDER 272
#define LESSTHAN 273
#define NOTMORETHAN 274
#define NOTLESSTHAN 275
#define MORETHAN 276
#define EQUAL 277
#define NOTEQUAL 278
#define AND 279
#define NOT 280
#define OR 281
#define ASSIGNMENT 282
#define ADDASSIGNMENT 283
#define MINUSASSIGNMENT 284
#define MULASSIGNMENT 285
#define DIVASSIGNMENT 286
#define IDENTIFIERS 287
#define INTEGERCONSTANTS 288
#define REALCONSTANTS 289
#define STRINGCONSTANTS 290
#define TRUE 291
#define FALSE 292
#define BOOL 293
#define BREAK 294
#define CASE 295
#define CONST 296
#define CONTINUE 297
#define DEFAULT 298
#define ELSE 299
#define FOR 300
#define FUNC 301
#define GO 302
#define IF 303
#define IMPORT 304
#define INT 305
#define NIL 306
#define PRINT 307
#define PRINTLN 308
#define REAL 309
#define RETURN 310
#define STRING 311
#define STRUCT 312
#define SWITCH 313
#define TYPE 314
#define VAR 315
#define VOID 316
#define WHILE 317
#define READ 318
#define UMINUS 319
#define UPLUS 320

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 12 "yacctemplate.y" /* yacc.c:1909  */

    bool bool_types;
    int int_types;
    double real_types;
    char* string_types;

#line 191 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
