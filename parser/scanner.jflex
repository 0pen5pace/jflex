/* this is the scanner example from the JLex website 
   (with small modifications to make it more readable) */

import java_cup.runtime.Symbol;

%%

%{
  private int comment_count = 0;
%} 

%cup
%implements sym
%class scanner
%line
%char
%state COMMENT
%unicode

%debug

%{
  SymTab symtab;          // externe symbol table

  public void setSymtab(SymTab symtab) {
    this.symtab = symtab;
  }

  private Symbol sym(int sym) {
    return new Symbol(sym);
  }

  private Symbol sym(int sym, Object val) {
    return new Symbol(sym, val);
  }
%}


ALPHA=[A-Za-z]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
NEWLINE=\r|\n|\r\n
WHITE_SPACE_CHAR=[\n\r\ \t\b\012]
STRING_TEXT=(\\\"|[^\n\r\"]|\\{WHITE_SPACE_CHAR}+\\)*
COMMENT_TEXT=([^*/\n]|[^*\n]"/"[^*\n]|[^/\n]"*"[^/\n]|"*"[^/\n]|"/"[^*\n])+
Ident = {ALPHA}({ALPHA}|{DIGIT}|_)*

%% 

<YYINITIAL> {
  ","             { return sym(COMMA); }
  "("             { return sym(LPAR); }
  ")"             { return sym(RPAR); }
  ";"             { return sym(SEMICOLON); }
  "{"             { return sym(BEGIN); }
  "}"             { return sym(END); }
  "=="            { return sym(EQUAL); }
  "!="            { return sym(UNEQUAL); }
  "="             { return sym(ASSIGN); }
  "-"             { return sym(MINUS); }
  "+"             { return sym(PLUS); }
  "*"             { return sym(TIMES); }
  "/"             { return sym(DIV); }

  "function"      { return sym(FUNCTION); }
  "if"            { return sym(IF); }
  "else"          { return sym(ELSE); }
  "var"           { return sym(VAR); }
  "loop"          { return sym(LOOP); }
  "shout"         { return sym(SHOUT); }

  {NONNEWLINE_WHITE_SPACE_CHAR}+ { }

  "/*" { yybegin(COMMENT); comment_count++; }

  \"{STRING_TEXT}\" { return sym(STRING, yytext()); }

    {DIGIT}+       { return sym(NUMBER, yytext()); }

  {Ident} { symtab.enter(yytext(),new SymtabEntry(yytext()));
                            return sym(ID,yytext()); }
}

<COMMENT> {
  "/*" { comment_count++; }
  "*/" { if (--comment_count == 0) yybegin(YYINITIAL); }
  {COMMENT_TEXT} { }
}


{NEWLINE} { }

. { System.out.println("Illegal character: <" + yytext() + ">");
	Utility.error(Utility.E_UNMATCHED);
}
