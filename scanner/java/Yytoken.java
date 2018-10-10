/** The tokens returned by the scanner. */
class Yytoken {
  public int m_index;
  public String m_text;
  public int m_line;
  public int m_charBegin;
  public int m_charEnd;
  public String m_type;

  Yytoken(int index, String text, int line, int charBegin, int charEnd, String type) {
    m_index = index;
    m_text = text;
    m_line = line;
    m_charBegin = charBegin;
    m_charEnd = charEnd;
    m_type = type;
  }

  public String toString() {
    return "vv-------==========-------vv"
        + "\nText   : "
        + m_text
        + "\nindex : "
        + m_index
        + "\nline  : "
        + m_line
        + "\ncBeg. : "
        + m_charBegin
        + "\ncEnd. : "
        + m_charEnd
        + "\nType. : "
        + m_type
        + "\n^^-------==========-------^^";
  }
}
