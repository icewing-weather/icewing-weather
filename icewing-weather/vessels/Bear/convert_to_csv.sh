#!/bin/bash
# Convert OCR line output to CSV
#
# For now, this replaces whitespace with commas and performs a few
# other operations with sed

# Fixups for specific mistranscriptions
sed -i'' s#e#c#g $1  # Replace "e" with "c", since OCR misinterprets the long c used in the Bear's typewriter
sed -i'' s#\\si\\s#,1,#g $1  # Replace "i" with "1", when it occurs on its own
sed -i'' s#\\s5\\s#,S,#g $1  # Replace "5" with "S", when it occurs on its own

# Fixups for whitespace
sed -i'' s#'\\n'#,#g $1
sed -i'' s#\\s\\+#,#g $1
