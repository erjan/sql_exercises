'''
Given two strings, string1 and string2, write a function str_map to determine if there exists
a one-to-one correspondence (bijection) between the characters of string1 and string2.

For the two strings, our correspondence must be between characters in the same position/index.
'''


from collections import Counter

def str_map(string1, string2):
    
    if len(string1)!= len(string2):
        return False
      
    d = Counter(string1)
    d2 = Counter(string2)

    for k,v in d.items():
        if d2[k] !=v:
            return False
    return True

-------------------------------------------------------------------------------------------------------
def str_map(string1, string2):
    # check whether the strings are the same length
    if len(string1) != len(string2):
        return False
            
    char_map = dict()
    for char1, char2 in zip(string1, string2):
        if char1 not in char_map:
            char_map[char1] = char2
        elif char_map[char1] != char2:
            return False
    for char1, char2 in zip(string2, string1):
        if char1 not in char_map:
            char_map[char1] = char2
        elif char_map[char1] != char2:
            return False

    return True


        
