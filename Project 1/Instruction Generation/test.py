import random as rand
import math

f = open("TestInstructions.txt", "w")


for i in range(64):
    f.write('{0:025b}'.format(rand.randint(0, math.pow(2, 25) - 1)) + '\n')

f.close()