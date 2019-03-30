# Interpolation

Ruby supports **string interpolation**, the insertion of an placeholder expression to be evaluated and string-converted when the interpreter creates the string. Within a double-quoted string, precede the expression with `#` and wrap it in curly braces. Only double-quoted (not single-quoted) strings support interpolation.

    b_and_e_artist = "Goldilocks"
    num_bears = 3
    "#{b_and_e_artist} and the #{num_bears} bears" #=> "Goldilocks and the 3 bears"

Double-quoted strings also permit naked (unescaped) single quotation marks. To use single quotation marks within a single-quoted string, escape the quotation marks with a backslash. The backslash marks `'` as an ordinary character, without its special significance as a string demarcation.

    'How Goldilocks broke into the 3 bears\'s house and stole their food'

