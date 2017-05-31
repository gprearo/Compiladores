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
    PROGRAM = 258,
    PROCEDURE = 259,
    VAR = 260,
    CONST = 261,
    SIMB_BEGIN = 262,
    END = 263,
    IF = 264,
    THEN = 265,
    ELSE = 266,
    INTEGER = 267,
    REAL = 268,
    CHAR = 269,
    ID = 270,
    NUM_INTEGER = 271,
    NUM_REAL = 272,
    INVALID_NUM_INT = 273,
    INVALID_NUM_REAL = 274,
    INVALID_CHAR = 275,
    SIMB_SEMI_COLON = 276,
    SIMB_COLON = 277,
    SIMB_ATRIBUTION = 278,
    SIMB_MINUS = 279,
    SIMB_PLUS = 280,
    SIMB_MUL = 281,
    SIMB_DIV = 282,
    SIMB_DOT = 283,
    SIMB_OPEN_PARENTESIS = 284,
    SIMB_CLOSE_PARENTESIS = 285,
    SIMB_COMMA = 286,
    SIMB_LESS = 287,
    SIMB_GREATER = 288,
    SIMB_DIF = 289,
    SIMB_GREATER_EQUAL = 290,
    ERROR = 291,
    CHARACTER = 292,
    SIMB_EQUAL = 293,
    READ = 294,
    WRITE = 295
  };
#endif
/* Tokens.  */
#define PROGRAM 258
#define PROCEDURE 259
#define VAR 260
#define CONST 261
#define SIMB_BEGIN 262
#define END 263
#define IF 264
#define THEN 265
#define ELSE 266
#define INTEGER 267
#define REAL 268
#define CHAR 269
#define ID 270
#define NUM_INTEGER 271
#define NUM_REAL 272
#define INVALID_NUM_INT 273
#define INVALID_NUM_REAL 274
#define INVALID_CHAR 275
#define SIMB_SEMI_COLON 276
#define SIMB_COLON 277
#define SIMB_ATRIBUTION 278
#define SIMB_MINUS 279
#define SIMB_PLUS 280
#define SIMB_MUL 281
#define SIMB_DIV 282
#define SIMB_DOT 283
#define SIMB_OPEN_PARENTESIS 284
#define SIMB_CLOSE_PARENTESIS 285
#define SIMB_COMMA 286
#define SIMB_LESS 287
#define SIMB_GREATER 288
#define SIMB_DIF 289
#define SIMB_GREATER_EQUAL 290
#define ERROR 291
#define CHARACTER 292
#define SIMB_EQUAL 293
#define READ 294
#define WRITE 295

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
