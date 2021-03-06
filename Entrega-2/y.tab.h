/* A Bison parser, made by GNU Bison 2.5.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2011 Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     OUT = 258,
     LEFT_PARENTHESIS = 259,
     RIGHT_PARENTHESIS = 260,
     LEFT_BRACE = 261,
     RIGHT_BRACE = 262,
     EQUALS = 263,
     TYPE = 264,
     PLUS = 265,
     STREAM = 266,
     EOL = 267,
     ENDFUNCTION = 268,
     CALL = 269,
     ITEM = 270,
     NAME = 271,
     FUNCTION = 272
   };
#endif
/* Tokens.  */
#define OUT 258
#define LEFT_PARENTHESIS 259
#define RIGHT_PARENTHESIS 260
#define LEFT_BRACE 261
#define RIGHT_BRACE 262
#define EQUALS 263
#define TYPE 264
#define PLUS 265
#define STREAM 266
#define EOL 267
#define ENDFUNCTION 268
#define CALL 269
#define ITEM 270
#define NAME 271
#define FUNCTION 272




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 2068 of yacc.c  */
#line 29 "grammar.y"

	char * strval;



/* Line 2068 of yacc.c  */
#line 90 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


