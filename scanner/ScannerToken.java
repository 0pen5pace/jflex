public class ScannerToken {

    public int m_index;
    public String m_text;
    public int m_line;
    public int m_charBegin;
    public int m_charEnd;

    ScannerToken(int index, String text) {
        st_index = index;
        st_text  = text;
    }

    public String toString() {
        return "TEST " +st_text+ " with the index of " + st_index;
    }
}