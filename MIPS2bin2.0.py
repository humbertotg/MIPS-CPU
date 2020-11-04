import ply.lex as lex
import ply.yacc as yacc

tags = {}
cuadruplos = []
IDStack = []
temp = 0


reserved = {
   'add' : 'ADD',
   'sub' : 'SUB',
   'and' : 'AND',
   'or' : 'OR',
   'slt' : 'SLT',
   'lw' : 'LW',
   'sw' : 'SW',
   'beq' : 'BEQ',
   'j' : 'J',
   'addi' : 'ADDI',
   'ori' : 'ORI',
   'lui' : 'LUI',
   'jr' : 'JR',
 }

tokens = [
    'OPENPAR',
    'CLOSEPAR',
    'COMA',
    'ID',
    'REG',
    'TWOP',
    'IMME',

] + list(reserved.values())

t_OPENPAR = r'\('
t_CLOSEPAR = r'\)'
t_TWOP = r'\:'
t_COMA = r'\,'

t_ignore = ' \t'

opCodes = {
    0 : "000000",
    "lw" :	"100011",
    "sw" :	"101011",
    "beq" :	"000100",
    "j"	: "000010",
    "addi" : "001000",
    "ori" : "001101",
    "lui" : "001111",
    "jr" : "000000"
}
funct = {
    "add" :	"100000",
    "sub" :	"100010",
    "and" :	"100100",
    "or" :	"100101",
    "slt" :	"101010",
    "jr"  : "001000"
}


def t_ID(t):
    r'[a-zA-Z_][a-zA-Z_0-9]*'
    t.type = reserved.get(t.value,'ID')
    return t

def t_REG(t):
    r'\$r[0-9]+'
    t.type = 'REG'
    return t

def t_IMME(t):
    r'0x[0-9]+'
    t.type = 'IMME'
    return t

def t_error(t):
    print("Illegal characters!")
    t.lexer.skip(1)

def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)

lexer = lex.lex()

def isRType(inst):
    if(inst == 'add' or inst == 'sub' or inst == 'and' or inst == 'or' or inst == 'slt'):
        return bool(1)
    return bool(0)

def p_MAIN(p):
    '''
    A : TAG ADD REG COMA REG COMA REG A
    A : TAG SUB REG COMA REG COMA REG A
    A : TAG AND REG COMA REG COMA REG A
    A : TAG OR REG COMA REG COMA REG A
    A : TAG SLT REG COMA REG COMA REG A
    A : TAG LW REG COMA IMME OPENPAR REG CLOSEPAR A
    A : TAG SW REG COMA IMME OPENPAR REG CLOSEPAR A
    A : TAG BEQ REG COMA REG COMA ID A
    A : TAG J ID A
    A : TAG ADDI REG COMA REG COMA IMME A
    A : TAG ORI REG COMA REG COMA IMME A
    A : TAG LUI REG COMA IMME A
    A : TAG JR REG A
    |
    '''
    global result
    if(len(p) > 1):
        inst = ""
        if(not isRType(p[2])):
            inst += opCodes[p[2]]
            if(p[2] == "lw" or p[2] == 'sw'):
                reg = p[7]
                inst += format(int(reg[2::]),"05b")
                reg = p[3]
                inst += format(int(reg[2::]),"05b")
                reg = p[5]
                reg = reg[2::]
                inst += bin(int(reg,16))[2::].zfill(16) 
            if(p[2] == "addi" or p[2] == "ori"):
                reg = p[3]
                inst += format(int(reg[2::]),"05b")
                reg = p[5]
                inst += format(int(reg[2::]),"05b")
                reg = p[7]
                reg = reg[2::]
                inst += bin(int(reg,16))[2::].zfill(16) 
            if(p[2] == "jr"):
                reg = p[3]
                inst += format(int(reg[2::]),"05b")
                inst += "000000000000000"
                inst += funct[p[2]]
            if(p[2] == "beq"):
                reg = p[3]
                inst += format(int(reg[2::]),"05b")
                reg = p[5]
                inst += format(int(reg[2::]),"05b")
                dif = tags[p[7]] - p.lineno(2)
                if(dif < 0):
                    dif = dif * -1
                    dif = (dif^65535) + 1
                inst += format(dif,"016b")
            if(p[2] == "lui"):
                inst += "00000"
                reg = p[3]
                inst += format(int(reg[2::]),"05b")
                reg = p[5]
                reg = reg[2::]
                inst += bin(int(reg,16))[2::].zfill(16)
            if(p[2] == "j"):
                inst += bin(tags[p[3]])[2::].zfill(26)

        else:
            inst += "000000"
            reg = p[5]
            inst += format(int(reg[2::]),"05b")
            reg = p[7]
            inst += format(int(reg[2::]),"05b") 
            reg = p[3]
            inst += format(int(reg[2::]),"05b") 
            inst += "00000"
            inst += funct[p[2]]
        inst = "arr(" + str(p.lineno(2) - 1) + ") <= \"" + inst + "\";"
        print(inst)
        result += inst + "\n"
        
def p_TAG(p):
    '''
    TAG : ID TWOP
    |
    '''
    if(len(p) > 1):
        p[0] = p[1]
        tags[p[1]] = p.lineno(2) - 1

def p_error(p):
    print(p)
    print("\tINCORRECTO")

parser = yacc.yacc()

file1 = open('archivo.txt','r')
info = file1.read()
out = open("o.txt","w")
result = ""

parser.parse(info)
out.write(result)
out.close()
file1.close()
print(tags)



'''
Lines = file1.readlines()
s = ""
for line in Lines:
  try:
    s += line.strip()
  except EOFError:
    break
parser.parse(s)
'''



