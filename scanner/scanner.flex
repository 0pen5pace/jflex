

%%

%class scanner
%line
%char
%state COMMENT
%unicode
%standalone

%debug

%{

private int comment_count = 0;

public static String printToken(int index, String text) {
    return "Text: " + text + "\n"
          +"ID: " + index+ "\n\n";
}
%}

ALPHA=[A-Za-z]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
NEWLINE=\r|\n|\r\n|\u000A
WHITE_SPACE_CHAR=[\n\r\ \t\b\012]
STRING_TEXT=(\\\"|[^\n\r\"]|\\{WHITE_SPACE_CHAR}+\\)*
COMMENT_TEXT=([^*/\n]|[^*\n]"/"[^*\n]|[^/\n]"*"[^/\n]|"*"[^/\n]|"/"[^*\n])+
Ident = {ALPHA}({ALPHA}|{DIGIT}|_)*

%%

<YYINITIAL> {
    "," { return printToken(0,yytext()); }
    ":" { return printToken(1,yytext()); }
    ";" { return printToken(2,yytext()); }
    "(" { return printToken(3,yytext()); }
    ")" { return printToken(4,yytext()); }
    "[" { return printToken(5,yytext()); }
    "]" { return printToken(6,yytext()); }
    "{" { return printToken(7,yytext()); }
    "}" { return printToken(8,yytext()); }
    "." { return printToken(9,yytext()); }
    "+" { return printToken(10,yytext()); }
    "-" { return printToken(11,yytext()); }
    "*" { return printToken(12,yytext()); }
    "/" { return printToken(13,yytext()); }
    "=" { return printToken(14,yytext()); }
    "<>" { return printToken(15,yytext()); }
    "<"  { return printToken(16,yytext()); }
    "<=" { return printToken(17,yytext()); }
    ">"  { return printToken(18,yytext()); }
    ">=" { return printToken(19,yytext()); }
    "&"  { return printToken(20,yytext()); }
    "|"  { return printToken(21,yytext()); }


    {NONNEWLINE_WHITE_SPACE_CHAR}+ { }
    "/*" { yybegin(COMMENT); comment_count++; }

    \"{STRING_TEXT}\" {
        String str =  yytext().substring(1,yylength()-1);
        return printToken(40,yytext());
    }
    \"{STRING_TEXT} {
        String str =  yytext().substring(1,yytext().length());
        System.err.println("Error: Unclosed string.");
        return printToken(41,yytext());
    }

    {DIGIT}+ { return printToken(42,yytext()); }

    {Ident} { return printToken(43,yytext()); }
}

// Count the opening comment symbols /* . If all opening comment symbols have been terminated with a closing comment symbole start the magic again.
<COMMENT> {
  "/*" { comment_count++; }
  "*/" { if (--comment_count == 0) yybegin(YYINITIAL); }
      // Do nothing with the text between the comment
  {COMMENT_TEXT} { }
}

// Don't do anything with comments. Just ignore, hence the empty brackets
{NEWLINE} { }

// Throw an error for any other characters that do not match any previous roules.
. {
    System.out.println("Illegal character: <" + yytext() + ">");
	System.err.println("Error: Illegal character.");
}
