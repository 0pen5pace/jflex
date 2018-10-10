

%%

%class scanner
%line
%char
%state COMMENT
%unicode
//%standalone

%debug

%{

private int comment_count = 0;

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
    "," { return (new ScannerToken(0,yytext())); }
    ":" { return (new ScannerToken(1,yytext())); }
    ";" { return (new ScannerToken(2,yytext())); }
    "(" { return (new ScannerToken(3,yytext())); }
    ")" { return (new ScannerToken(4,yytext())); }
    "[" { return (new ScannerToken(5,yytext())); }
    "]" { return (new ScannerToken(6,yytext())); }
    "{" { return (new ScannerToken(7,yytext())); }
    "}" { return (new ScannerToken(8,yytext())); }
    "." { return (new ScannerToken(9,yytext())); }
    "+" { return (new ScannerToken(10,yytext())); }
    "-" { return (new ScannerToken(11,yytext())); }
    "*" { return (new ScannerToken(12,yytext())); }
    "/" { return (new ScannerToken(13,yytext())); }
    "=" { return (new ScannerToken(14,yytext())); }
    "<>" { return (new ScannerToken(15,yytext())); }
    "<"  { return (new ScannerToken(16,yytext())); }
    "<=" { return (new ScannerToken(17,yytext())); }
    ">"  { return (new ScannerToken(18,yytext())); }
    ">=" { return (new ScannerToken(19,yytext())); }
    "&"  { return (new ScannerToken(20,yytext())); }
    "|"  { return (new ScannerToken(21,yytext())); }


    {NONNEWLINE_WHITE_SPACE_CHAR}+ { }
    "/*" { yybegin(COMMENT); comment_count++; }

    \"{STRING_TEXT}\" {
        String str =  yytext().substring(1,yylength()-1);
        return (new ScannerToken(40,yytext()));
    }
    \"{STRING_TEXT} {
        String str =  yytext().substring(1,yytext().length());
        System.err.println("Error: Unclosed string.");
        return (new ScannerToken(41,yytext()));
    }

    {DIGIT}+ { return (new ScannerToken(42,yytext())); }

    {Ident} { return (new ScannerToken(43,yytext())); }
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
