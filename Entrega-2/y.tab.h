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
     VOL = 258,
     F_CALL = 259,
     FREQ = 260,
     DUR = 261,
     FUNC = 262,
     NOT = 263,
     STR = 264,
     VAR = 265,
     OUT = 266,
     LEFT_PARENTHESIS = 267,
     RIGHT_PARENTHESIS = 268,
     LEFT_BRACE = 269,
     RIGHT_BRACE = 270,
     EQUALS = 271,
     TYPE = 272,
     ITEM = 273,
     NAME = 274,
     INVALID = 275,
     ENDF = 276
   };
#endif
/* Tokens.  */
#define VOL 258
#define F_CALL 259
#define FREQ 260
#define DUR 261
#define FUNC 262
#define NOT 263
#define STR 264
#define VAR 265
#define OUT 266
#define LEFT_PARENTHESIS 267
#define RIGHT_PARENTHESIS 268
#define LEFT_BRACE 269
#define RIGHT_BRACE 270
#define EQUALS 271
#define TYPE 272
#define ITEM 273
#define NAME 274
#define INVALID 275
#define ENDF 276




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 2068 of yacc.c  */
#line 18 "grammar.y"

	char * strval;



/* Line 2068 of yacc.c  */
#line 98 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


