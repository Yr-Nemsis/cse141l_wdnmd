"""
usage: python assembler.py [assembly file] [machine code file]

requires python 3.x

This assembler is assuming the bit breakdown as follows:
R-Type: 3 bits opcode, 3 bits destination register, 3 bits operand register
I-Type: 3 bits opcode, 3 bits destination register, 3 bits immediate
J-Type: 3 bits opcode, 6 bits immediates
"""

import sys

print (sys.version)

# map registers to binary
registers_three_bit = {
    "$r0": "000",
    "$r1": "001",
    "$r2": "010",
    "$r3": "011",
    "$r4": "100",
    "$r5": "101",
    "$r6": "110",
    "$r7": "111"
}

# map opcode to binary
opcode = {
    "add": "000",
    "and": "001",
    "xor": "010",
    "beq": "011",
    "move": "100",
    "load": "101",
    "store": "110",
    "rtl": "111"
}

# classify instructions into different types
rtype = ['add', 'and', 'xor', 'rtl', 'load', 'store']
itype = ['move']
jtype = ['beq']

# NOTE: THIS WILL BE DIFFERENT FOR YOU!
comment_char = '//'


with open(sys.argv[1], "r") as read:
    with open(sys.argv[2], "w") as write:
    # with automatically handles file (no need for open and close)
        line = read.readline() # read a line

        # for every line
        while(line):
            line = line.replace(",", "")
            # strip takes away whitespace from left and right
            line = line.strip()

            # split your comments out
            line = line.split(comment_char, 1)


            # store instruction and comment
            inst = line[0].strip()

            if (len(line) > 1):
                comment = line[1].strip()
            else:
                comment = ''

            # split instruction into arguments
            inst = inst.split()

            # initialize the string that contains the machine code binary
            writeline = ''

            # write the opcode
            if inst[0] in opcode:
                writeline += opcode[inst[0]]
            else:
                # if it an instruction that doesn't exist, exit
                sys.exit()

            # if it's r-type or b-type, then you know you have 2 args after (this might be different for you)
            if inst[0] in rtype:
                writeline += registers_three_bit[inst[1]]
                writeline += registers_three_bit[inst[2]]
            elif inst[0] in itype:
                writeline += registers_three_bit[inst[1]]
                # immediate just goes straight in
                writeline += inst[2]
            elif inst[0] in jtype:
                writeline += inst[1]


            # SystemVerilog ignores comments prepended with // with readmemb or readmemh
            if (comment != ''):
                writeline += '   //' + comment
            writeline += '\n'

            # write the line into the desired file
            write.write(writeline)

            # read the next line
            line = read.readline()
