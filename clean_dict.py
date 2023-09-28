# Remove charaacters in the dictionary that are not in the doctr tamazight VOCAB

from doctr.datasets import VOCABS
import sys

# Add Tifinagh characters to VOCAB
tifinagh = ""
for i in range(0x2D30, 0x2D67 + 1):
    tifinagh += chr(i)
tifinagh += chr(0x2D6F)
tifinagh += chr(0x2D70)
tifinagh += chr(0x2D7F)
VOCABS['tifinagh'] = tifinagh
VOCABS['tifinagh-ircam'] = "ⴰⴱⴳⴷⴹⴻⴼⴽⵀⵃⵄⵅⵇⵉⵊⵍⵎⵏⵓⵔⵕⵖⵙⵚⵛⵜⵟⵡⵢⵣⵥⵯ"
VOCABS['tamazight'] = VOCABS["french"] + VOCABS['tifinagh']
VOCABS['zgh'] = VOCABS['french'] + VOCABS['tifinagh-ircam']

dictionary = sys.argv[1]
out = sys.argv[2]
vocab = sys.argv[3]

with open(dictionary, 'r', encoding='utf-8') as f:
    lines = f.readlines()

with open(out, 'w', encoding='utf-8') as f:
    for line in lines:
        # Remove lines with characters not in the vocabulary
        # Remove lines longer than 32 characters
        if all(c in VOCABS[vocab] for c in line.strip()) and len(line) <= 32:
            f.write(line)
