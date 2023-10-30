'''
Write a function that takes an input as the number of 
tosses and a probability of heads and return a list of
randomly generated results equal in length to the
number of tosses. Each result represents the outcome of a coin toss, where ‘H’ represents heads and ’T’ represents tails.
'''

import random
def coin_toss(tosses, probability_of_heads):

    res = []
    for i in range(tosses):

        if random.random()<=probability_of_heads:
            res.append('H')
        else:
            res.append('T')
    return res


    
