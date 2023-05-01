f = open("/content/gdrive/MyDrive/memojang/Assembly.txt", 'r')
ml = open("/content/gdrive/MyDrive/memojang/MachineLanguage.txt", 'w')
Instructions = f.readlines()

Instruction_type = 0
a = []
b = []
#register = [('$zero', '00000'), ('$at', '00001'), ('$v0', '00010'), ('$v1', '00011'), ('$a0', '00100'), ('$a1', '00101'), ('$a2', '00110'), ('$a3', '00111'), 
#            ('$t0', '01000'), ('$t1', '01001'), ('$t2', '01010'), ('$t3', '01011'), ('$t4', '01100'), ('$t5', '01101'), ('$t6', '01110'), ('$t7', '01111'), 
#            ('$s0', '10000'), ('$s1', '10001'), ('$s2', '10010'), ('$s3', '10011'), ('$s4', '10100'), ('$s5', '10101'), ('$s6', '10110'), ('$s7', '10111'), 
#            ('$t8', '11000'), ('$t9', '11001'), ('$k0', '11010'), ('$k1', '11011'), ('$gp', '11100'), ('$sp', '11101'), ('$fp', '11110'), ('$ra', '11111')]

register = [('$0', '00000'), ('$1', '00001'), ('$2', '00010'), ('$3', '00011'), ('$4', '00100'), ('$5', '00101'), ('$6', '00110'), ('$7', '00111'), 
            ('$8', '01000'), ('$9', '01001'), ('$10', '01010'), ('$11', '01011'), ('$12', '01100'), ('$13', '01101'), ('$14', '01110'), ('$15', '01111'), 
            ('$16', '10000'), ('$17', '10001'), ('$18', '10010'), ('$19', '10011'), ('$20', '10100'), ('$21', '10101'), ('$22', '10110'), ('$23', '10111'), 
            ('$24', '11000'), ('$25', '11001'), ('$26', '11010'), ('$27', '11011'), ('$gp', '11100'), ('$sp', '11101'), ('$fp', '11110'), ('$31', '11111')]

line = 0
opcode = '000000'
rs = '00000'
rt = '00000'
rd = '00000'
shamt = '00000'
funct = '000000'
imm = '0000000000000000'
address = '00000000000000000000000000'

for x in range(len(Instructions)):
  Instructions[x] = Instructions[x].replace(',', ' ')
  Instructions[x] = Instructions[x].replace('(', ' ')
  Instructions[x] = Instructions[x].replace(')', '')
  Instructions[x] = Instructions[x].replace(':', '')
  w = Instructions[x].split()
  if (len(w) < 1):
    continue
  if (len(w) > 4):
    w = w[0:4]
  if (len(w) == 1):
    if (w[0] != 'nop' and w[0] != 'syscall'):
      a.append(w[0])
      print(line)
      b.append(line)
      print(b)
    continue
  if (w[0] == 'add' or w[0] == 'addu'):
    opcode = '000000'
    funct = '100000'
    Instruction_type = 1
  elif (w[0] == 'and'):
    opcode = '000000'
    funct = '100100'
    Instruction_type = 1
  elif (w[0] == 'jr'):
    opcode = '000000'
    funct = '001000'
    Instruction_type = 1
  elif (w[0] == 'nor'):
    opcode = '000000'
    funct = '100111'
    Instruction_type = 1
  elif (w[0] == 'or'):
    opcode = '000000'
    funct = '100101'
    Instruction_type = 1
  elif (w[0] == 'slt'):
    opcode = '000000'
    funct = '101010'
    Instruction_type = 1
  elif (w[0] == 'sll'):
    opcode = '000000'
    shamt = str(format(int(w[3]),'b').zfill(5))
    funct = '000000'
    Instruction_type = 1
  elif (w[0] == 'srl'):
    opcode = '000000'
    shamt = str(format(int(w[3]),'b').zfill(5))
    funct = '000010'
    Instruction_type = 1
  elif (w[0] == 'sub' or w[0] == 'subu'):
    opcode = '000000'
    funct = '100010'
    Instruction_type = 1
  elif (w[0] == 'div' or w[0] == 'divu'):
    opcode = '000000'
    funct = '011010'
    Instruction_type = 1
  elif (w[0] == 'mult' or w[0] == 'multu'):
    opcode = '000000'
    funct = '011000'
    Instruction_type = 1
  elif (w[0] == 'mfhi'):
    opcode = '000000'
    funct = '010000'
    Instruction_type = 1
  elif (w[0] == 'mflo'):
    opcode = '000000'
    funct = '010010'
    Instruction_type = 1
  elif (w[0] == 'mul'):
    opcode = '000000'
    funct = '011001'
    Instruction_type = 1
  elif (w[0] == 'addi' or w[0] == 'addiu' or w[0] == 'move' or w[0] == 'li'):
    opcode = '001000'
    Instruction_type = 2
  elif (w[0] == 'andi'):
    opcode = '001100'
    Instruction_type = 2
  elif (w[0] == 'beq'):
    opcode = '000100'
    Instruction_type = 2
  elif (w[0] == 'bne'):
    opcode = '000101'
    Instruction_type = 2
  elif (w[0] == 'lw'):
    opcode = '100011'
    Instruction_type = 2
  elif (w[0] == 'ori'):
    opcode = '001101'
    Instruction_type = 2
  elif (w[0] == 'slti'):
    opcode = '001010'
    Instruction_type = 2
  elif (w[0] == 'sw'):
    opcode = '101011'
    Instruction_type = 2
  elif (w[0] == 'j' or w[0] == 'b'):
    opcode = '000010'
    Instruction_type = 3
  elif (w[0] == 'jal'):
    opcode = '000011'
    Instruction_type = 3
  if (Instruction_type == 1):
    if (w[0] == 'srl' or w[0] == 'sll'):
      for r in register:
        if (w[2] == r[0]):
          rt = r[1]
        if (w[1] == r[0]):
          rd = r[1]
    elif (w[0] == 'jr'):
      for r in register:
        if (w[1] == r[0]):
          rs = r[1]
    elif (w[0] == 'mult' or w[0] == 'multu' or w[0] == 'div' or w[0] == 'divu'):
      for r in register:
        if (w[1] == r[0]):
          rs = r[1]
        if (w[2] == r[0]):
          rt = r[1]
    elif (w[0] == 'mfhi' or w[0] == 'mflo'):
      for r in register:
        if (w[1] == r[0]):
          rd = r[1]
    else:
      for r in register:
        if (w[2] == r[0]):
          rs = r[1]
        if (w[3] == r[0]):
          rt = r[1]
        if (w[1] == r[0]):
          rd = r[1]
    ml.write(opcode + rs + rt + rd + shamt + funct + '\n')
  elif (Instruction_type == 2):
    if (w[0] == 'lw' or w[0] == 'sw'):
      for r in register:
        if (w[3] == r[0]):
          rs = r[1]
        if (w[1] == r[0]):
          rt = r[1]
      if (int(w[2]) < 0):
        w[2] = 2**16 + int(w[2])
      imm = str(format(int(w[2]),'b').zfill(16))
    elif (w[0] == 'beq' or w[0] == 'bne'):
      for r in register:
        if (w[1] == r[0]):
          rs = r[1]
        if (w[2] == r[0]):
          rt = r[1]
      imm = w[3]
    elif (w[0] == 'move'):
      for r in register:
        if (w[2] == r[0]):
          rs = r[1]
        if (w[1] == r[0]):
          rt = r[1]
      imm = '0000000000000000'
    elif (w[0] == 'li'):
      for r in register:
        if (w[1] == r[0]):
          rt = r[1]
      rs = '00000'
      imm = str(format(int(w[2]),'b').zfill(16))
    else:
      for r in register:
        if (w[2] == r[0]):
          rs = r[1]
        if (w[1] == r[0]):
          rt = r[1]
      if (int(w[3]) < 0):
        w[3] = 2**16 + int(w[3])
      imm = str(format(int(w[3]),'b').zfill(16))
    ml.write(opcode + rs + rt + imm + '\n')
  elif (Instruction_type == 3):
    address = w[1]
    ml.write(opcode + address + '\n')
  else:
    ml.write(str(w) + '\n')
  line += 1
  Instruction_type = 0
  opcode = '000000'
  rs = '00000'
  rt = '00000'
  rd = '00000'
  shamt = '00000'
  funct = '000000'
  imm = '0000000000000000'


f.close()
ml.close()

ml_1 = open("/content/gdrive/MyDrive/memojang/MachineLanguage.txt", 'r')
ml_f = open("/content/gdrive/MyDrive/memojang/MachineLanguageWithAdress.txt", 'w')
ins = ml_1.readlines()

lin = 0

for x in ins:
  x = x.replace('\n', '')
  if (x[0:6] == '000100' or x[0:6] == '000101'):
    for i in range(len(a)):
      if (x[16:] == a[i]):
        if (b[i]-lin-1 < 0):
          b[i] = 2**16 + b[i]
        x = x[0:16] + str(format(b[i]-lin-1,'b').zfill(16))
  elif (x[0:6] == '000010' or x[0:6] == '000011'):
    for i in range(len(a)):
      if (x[6:] == a[i]):
        x = x[0:6] + str(format(b[i],'b').zfill(26))
  ml_f.write(x + '\n')
  lin += 1

ml_1.close()
ml_f.close()
