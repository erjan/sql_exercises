'''
Given a list of strings of letters from a to z, create a function, sum_alphabet, that returns a list of the alphabet sum of each word in the string.

The alphabet sum is the sum of the ordinal position of each of the string’s letters in the standard English alphabet ordering. So, the letter a will have a value of 1, z will have a value of 26, and so on.

As an example of the alphabet sum of a string, the string sport will have an alphabet sum of 19 + 16 + 15 + 18 + 20 = 88.
'''

import string
def sum_alphabet(words):
    
    s = [i for i in range(1, 27)]
    d = dict(zip(string.ascii_lowercase, s))

    res = []
    for w in words:
        cursum  = 0
        for ch in w:
            cursum += d[ch]
        res.append(cursum)
    
    return res
