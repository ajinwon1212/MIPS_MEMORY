f = open("/content/gdrive/MyDrive/memojang/Assembly.txt", 'r')            // 어셈블리어로 작성된 파일
ml = open("/content/gdrive/MyDrive/memojang/MachineLanguage.txt", 'w')            // address는 이름으로 저장하고 나머지 명령어는 2진수로 변환해 저장할 파일
Instructions = f.readlines()                        // 파일 읽어오기

Instruction_type = 0            // 명령어 타입 
a = []            // jump 명령어로 이동할 address 이름을 순서대로 저장하는 배열
b = []            // a 배열의 address 이름에 대응하는 라인 위치를 저장하는 배열
register = [('$zero', '00000'), ('$at', '00001'), ('$v0', '00010'), ('$v1', '00011'), ('$a0', '00100'), ('$a1', '00101'), ('$a2', '00110'), ('$a3', '00111'), 
            ('$t0', '01000'), ('$t1', '01001'), ('$t2', '01010'), ('$t3', '01011'), ('$t4', '01100'), ('$t5', '01101'), ('$t6', '01110'), ('$t7', '01111'), 
            ('$s0', '10000'), ('$s1', '10001'), ('$s2', '10010'), ('$s3', '10011'), ('$s4', '10100'), ('$s5', '10101'), ('$s6', '10110'), ('$s7', '10111'), 
            ('$t8', '11000'), ('$t9', '11001'), ('$k0', '11010'), ('$k1', '11011'), ('$gp', '11100'), ('$sp', '11101'), ('$fp', '11110'), ('$ra', '11111')]
// 레지스터 이름에 대응하는 2진수 저장해놓는 배열열
#register = [('$0', '00000'), ('$1', '00001'), ('$2', '00010'), ('$3', '00011'), ('$4', '00100'), ('$5', '00101'), ('$6', '00110'), ('$7', '00111'), 
#            ('$8', '01000'), ('$9', '01001'), ('$10', '01010'), ('$11', '01011'), ('$12', '01100'), ('$13', '01101'), ('$14', '01110'), ('$15', '01111'), 
#            ('$16', '10000'), ('$17', '10001'), ('$18', '10010'), ('$19', '10011'), ('$20', '10100'), ('$21', '10101'), ('$22', '10110'), ('$23', '10111'), 
#            ('$24', '11000'), ('$25', '11001'), ('$26', '11010'), ('$27', '11011'), ('$gp', '11100'), ('$sp', '11101'), ('$fp', '11110'), ('$31', '11111')]

line = 0          // 현재 읽는 라인 위치
opcode = '000000'
rs = '00000'
rt = '00000'
rd = '00000'
shamt = '00000'
funct = '000000'
imm = '0000000000000000'            // immediate
address = '00000000000000000000000000'                        // 값 초기화

for x in range(len(Instructions)):            // 명령어 한 줄씩 진행
  Instructions[x] = Instructions[x].replace(',', ' ')            // 어셈블리어 형식 맞추기 위해 특수기호들 제거
  Instructions[x] = Instructions[x].replace('(', ' ')       // 이때 편의상 lw 또는 sw의 경우 lw $s1 100($s2) -> lw $s1 100 $s2 처럼 괄호 내부를 띄어쓰기 해서 해석
  Instructions[x] = Instructions[x].replace(')', '')
  Instructions[x] = Instructions[x].replace(':', '')
  w = Instructions[x].split()            // 명령어가 띄어쓰기 단위로 w에 배열로 저장됨
  if (len(w) < 1):            // 빈칸이면 생략
    continue
  if (len(w) > 4):            // add $t1 $t2 $t3 처럼 명령어는 4 단어 이하로 구성되므로 4 초과하는 부분은 주석이기 때문에 삭제 (그래서 4 단어짜리 명령어 아닌 줄에 주석 넣으면 안됨!)
    w = w[0:4]
  if (len(w) == 1):            // 한 단어로 이뤄진 줄인 경우
    if (w[0] != 'nop' and w[0] != 'syscall'):  // nop나 syscall 명령어가 아니라면 이는 address를 나타내므로 a 배열에 address 이름을, b 배열에 address 라인 위치를 저장하고 다음 줄로 진행
      a.append(w[0])
      print(line)            // print문은 잘 되고있는지 확인하려고 넣은 것
      b.append(line)
      print(b)
    continue
  if (w[0] == 'add' or w[0] == 'addu'):            // 일반적인 명령어의 경우 진행, opcode, funct, 명령어 타입을 2진수로 변환
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
    shamt = str(format(int(w[3]),'b').zfill(5))            // zfill은 비트 수 맞춰주는 용도
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
  elif (w[0] == 'addi' or w[0] == 'addiu' or w[0] == 'move' or w[0] == 'li'):            // 유사한 명령어 하나로 구현했으므로 회로에 맞게 해석
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
    if (w[0] == 'srl' or w[0] == 'sll'):            // 레지스터 이름에 따라 해당하는 2진수로 변환하는데 add 명령어와 다른 어순을 쓰는 경우는 아래처럼 어순에 맞게 rs rt rd에 할당
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
    else:                        // add와 같은 어순을 쓰는 경우
      for r in register:
        if (w[2] == r[0]):
          rs = r[1]
        if (w[3] == r[0]):
          rt = r[1]
        if (w[1] == r[0]):
          rd = r[1]
    ml.write(opcode + rs + rt + rd + shamt + funct + '\n')            // 32비트 한 줄로 합쳐서 씀 (R type 경우)
  elif (Instruction_type == 2):
    if (w[0] == 'lw' or w[0] == 'sw'):
      for r in register:
        if (w[3] == r[0]):
          rs = r[1]
        if (w[1] == r[0]):
          rt = r[1]
      if (int(w[2]) < 0):
        w[2] = 2**16 + int(w[2])            // 2진수 음수 표현을 위해 2의 16승을 더해줌
      imm = str(format(int(w[2]),'b').zfill(16))             // 비트 수 맞춰서 immediate에 할당
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
    ml.write(opcode + rs + rt + imm + '\n')            // 32비트 한 줄로 합쳐서 씀 (I type 경우)
  elif (Instruction_type == 3):
    address = w[1]
    ml.write(opcode + address + '\n')            // 32비트 한 줄로 합쳐서 씀 (J type 경우)
  else:
    ml.write(str(w) + '\n')
  line += 1                        // 다음 줄로 넘어갈 때 line에 1 추가해주고 나머지 값들 초기화
  Instruction_type = 0
  opcode = '000000'
  rs = '00000'
  rt = '00000'
  rd = '00000'
  shamt = '00000'
  funct = '000000'
  imm = '0000000000000000'


f.close()            // 다 끝나면 파일 닫음
ml.close()

ml_1 = open("/content/gdrive/MyDrive/memojang/MachineLanguage.txt", 'r') // address는 이름으로 저장하고 나머지 명령어는 2진수로 변환해 저장한 파일
ml_f = open("/content/gdrive/MyDrive/memojang/MachineLanguageWithAdress.txt", 'w')  // a, b 배열 활용해서 address도 2진수로 변환해 저장할 파일
ins = ml_1.readlines()

lin = 0            // 라인 나타낼 변수 위에서 line 이름 변수 써서 다른 이름으로 할당했는데 그냥 line 초기화해서 써도 되긴 함

for x in ins:
  x = x.replace('\n', '')  // 위에선 단어별로 배열로 했기 때문에 상관없었지만 이번 경우 한줄 통째로 쓰므로 엔터를 삭제해줘야함
  if (x[0:6] == '000100' or x[0:6] == '000101'):            // beq나 bne 명령어인 경우 address와 떨어진 줄 수를 나타내줘야함
    for i in range(len(a)):
      if (x[16:] == a[i]):
        if (b[i]-lin-1 < 0):
          b[i] = 2**16 + b[i]         // 2진수 음수 표현
        x = x[0:16] + str(format(b[i]-lin-1,'b').zfill(16))
  elif (x[0:6] == '000010' or x[0:6] == '000011'):            // j나 jal 명령어인 경우 address의 라인 위치를 나타내줘야함
    for i in range(len(a)):
      if (x[6:] == a[i]):
        x = x[0:6] + str(format(b[i],'b').zfill(26))
  ml_f.write(x + '\n')
  lin += 1

ml_1.close()
ml_f.close()
