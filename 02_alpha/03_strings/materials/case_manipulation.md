# Case Manipulation

Strings feature four methods for manipulating case: `downcase`, `upcase`, `capitalize`, and `swapcase`. `downcase` replaces all uppercase letters with their lowercase counterparts, `upcase` replaces all lowercase letters with their uppercase counterparts, `capitalize` capitalizes the string's first character and lowercases the rest of the string, and `swapcase` inverts the case of each character. All four methods do not modify the original string, but they do have dangerous versions. As a reminder, in Ruby's core library a _dangerous_ method indicates that, unlike its non-dangerous equivalent, the method permanently modifies its receiver.

    "TWO-CASED STRING".downcase #=> "two-cased string"
    "rOlLeR-cOaStEr StRiNg".downcase #=> "roller-coaster string"

    "two-cased string".upcase #=> "TWO-CASED STRING"
    "rOlLeR-cOaStEr StRiNg".upcase #=> "ROLLER-COASTER STRING"

    "TWO-CASED STRING".capitalize #=> "Two-cased string"
    "two-cased string".capitalize #=> "Two-cased string"
    "rOlLeR-cOaStEr StRiNg".capitalize #=> "Roller-coaster string"

    "TWO-CASED STRING".swapcase #=> "two-cased string"
    "two-cased string".swapcase #=> "TWO-CASED STRING"
    "rOlLeR-cOaStEr StRiNg".swapcase #=> "RoLlEr-CoAsTeR sTrInG"