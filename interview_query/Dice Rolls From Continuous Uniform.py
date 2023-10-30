

'''
You are given a function that generates a floating-point number between 0 and 1 from a continuous uniform distribution.

Write a function dice_rolls that takes the continuous
random generator and simulates a 
dice roll (return a number between 1 and 6, with all numbers having a uniform distribution).
'''

import random

continues_random_function = random.random


def dice_roll():
    s = 100.0 * continues_random_function()

    chunk = int(100 / 6)

    divs = []
    for i in range(0, 95, chunk):
        divs.append(i)


    for chunk in divs:

        if s>=0 and s<=16:
            return 1
        elif 16<s<=32:
            return 2
        elif 32<s<=48:
            return 3
        elif 48<s<=64:
            return 4
        elif 64<s<=80:
            return 5
        elif s >80:
            return 6

---------------------------------------------------------------------------
import random
continues_random_function = random.random

def dice_roll():
    return int(continues_random_function()*6) + 1

