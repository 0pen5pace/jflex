

%%

%line
%char
%state COMMENT
%unicode

%debug

%{

private int comment_count = 0;


class Utiliy {

  private static final String errorMsg[] = {
    "Error: Unmatched end-of-comment punctuation.",
    "Error: Unmatched start-of-comment punctuation.",
    "Error: Unclosed string.",
    "Error: Illegal character."
  };

  public static final int E_ENDCOMMENT = 0;
  public static final int E_STARTCOMMENT = 1;
  public static final int E_UNCLOSEDSTR = 2;
  public static final int E_UNMATCHED = 3;

  public static void error(int code) {
    System.err.println(errorMsg[code]);
  }
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
    "," { return 0; }
    ":" { return 1; }
    ";" { return 2; }
    "(" { return 3; }
    ")" { return 4; }
    "[" { return 5; }
    "]" { return 6; }
    "{" { return 7; }
    "}" { return 8; }
    "." { return 9; }
    "+" { return 10; }
    "-" { return 11; }
    "*" { return 12; }
    "/" { return 13; }
    "=" { return 14; }
    "<>" { return 15; }
    "<"  { return 16; }
    "<=" { return 17; }
    ">"  { return 18; }
    ">=" { return 19; }
    "&"  { return 20; }
    "|"  { return 21; }


    {NONNEWLINE_WHITE_SPACE_CHAR}+ { }
    "/*" { yybegin(COMMENT); comment_count++; }

    \"{STRING_TEXT}\" {
        String str =  yytext().substring(1,yylength()-1);
        return 40;
    }
    \"{STRING_TEXT} {
        String str =  yytext().substring(1,yytext().length());
        Utility.error(Utility.E_UNCLOSEDSTR);
        return 41;
    }

    {DIGIT}+ { return 42; }

    {Ident} { return 43; }
}

<COMMENT> {
  "/*" { comment_count++; }
  "*/" { if (--comment_count == 0) yybegin(YYINITIAL); }
  {COMMENT_TEXT} { }
}


{NEWLINE} { }

. {
  System.out.println("Illegal character: <" + yytext() + ">");
	Utility.error(Utility.E_UNMATCHED);
}
