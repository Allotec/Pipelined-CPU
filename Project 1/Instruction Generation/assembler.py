#Syntax For all Instructions
#LOAD INSTRUCTION
#Load Immediate -> li rd, LoadIndex, imm
#R4 INSTRUCTION FORMAT
#Signed Integer Multiply-Add Low with Saturation -> simal rd, rs1, rs2, rs3
#Signed Integer Multiply-Add High with Saturation -> simah rd, rs1, rs2, rs3
#Signed Integer Multiply-Subtract Low with Saturation -> simsl rd, rs1, rs2, rs3
#Signed Integer Multiply-Subtract High with Saturation -> simsh rd, rs1, rs2, rs3
#Signed Long Integer Multiply-Add Low with Saturation -> slimal rd, rs1, rs2, rs3
#Signed Long Integer Multiply-Add High with Saturation -> slimah rd, rs1, rs2, rs3
#Signed Long Integer Multiply-Subtract Low with Saturation -> slimsl rd, rs1, rs2, rs3
#Signed Long Integer Multiply-Subtract High with Saturation -> slimsh rd, rs1, rs2, rs3
#R3 INSTRUCTION FORMAT
#No Operation -> nop
#Add Halfword -> ah rd, rs1, rs2
#Add Halfword Saturated -> ahs rd, rs1, rs2
#Broadcast Word -> bcw rd, rs1
#Carry Generate Halfword -> cgh rd, rs1, rs2
#Count Leading Zeros in Words -> clz rd, rs1
#Max Signed Word -> max rd, rs1, rs2
#Min Signed Word -> min rd, rs1, rs2
#Multiply Sign -> msgn rd, rs1, rs2
#Count Ones in Halfwords -> popcnth rd, rs1
#Rotate Bits Right -> rot rd, rs1, rs2
#Rotate Bits in Word -> rotw rd, rs1, rs2
#Shift Left Halfword Immediate -> shlhi rd, rs1, rs2
#Subtract From Halfword -> sfh rd, rs1, rs2
#Subtract From Halfword Saturated -> sfhs rd, rs1, rs2
#Bitwise Logical XOR -> xor rd, rs1, rs2


input = open("InstructionInput.txt", "r")
output = open("InstructionOutput.txt", "w")

r4Dict = {
    "simal" : "000",
    "simah" : "001",
    "simsl" : "010",
    "simsh" : "011",
    "slimal" : "100", 
    "slimah" : "101", 
    "slimsl" : "110",
    "slimsh" : "111" 
}

r3Dict = {
    "nop" : "00000000",
    "ah" : "00000001",
    "ahs" : "00000010",
    "bcw" : "00000011",
    "cgh" : "00000100",
    "clz" : "00000101",
    "max" : "00000110",
    "min" : "00000111",
    "msgn" : "00001000",
    "popcnth" : "00001001",
    "rot" : "00001010",
    "rotw" : "00001011",
    "shlhi" : "00001100",
    "sfh" : "00001101",
    "sfhs" : "00001110",
    "xor" : "00001111"
}

lines = input.readlines()
splitInstruction = []

for i in range(len(lines)):
    splitInstruction.insert(i, lines[i].strip().split(" "))
    for j in range(len(splitInstruction[i])):
        splitInstruction[i][j] = splitInstruction[i][j].replace(',', '')

    if splitInstruction[i][0] in r4Dict:
        output.write("10" + r4Dict[splitInstruction[i][0]] + '{0:05b}'.format(int(splitInstruction[i][4])) + '{0:05b}'.format(int(splitInstruction[i][3])) + '{0:05b}'.format(int(splitInstruction[i][2])) + '{0:05b}'.format(int(splitInstruction[i][1])) + '\n')
    elif splitInstruction[i][0] in r3Dict:
        if(splitInstruction[i][0] == "bcw" or splitInstruction[i][0] == "clz" or splitInstruction[i][0] == "popcnth"):
            output.write("11" + r3Dict[splitInstruction[i][0]] + "00000" + '{0:05b}'.format(int(splitInstruction[i][2])) + '{0:05b}'.format(int(splitInstruction[i][1])) + '\n')
        else:
            output.write("11" + r3Dict[splitInstruction[i][0]] + '{0:05b}'.format(int(splitInstruction[i][3])) + '{0:05b}'.format(int(splitInstruction[i][2])) + '{0:05b}'.format(int(splitInstruction[i][1])) + '\n')
    else:
        output.write("0" + '{0:03b}'.format(int(splitInstruction[i][2])) + '{0:016b}'.format(int(splitInstruction[i][3])) + '{0:05b}'.format(int(splitInstruction[i][1])) + '\n')


input.close()
output.close()
