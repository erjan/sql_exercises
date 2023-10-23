



'''
Given a string, find the first non-repeating character in it and return its index. If it doesn’t exist, return -1.

Example questions:

Consider a string where all characters are lowercase alphabets.
'''

def first_uniq_char(s):
    

    for ch in s:

        if s.count(ch) == 1:
            return s.index(ch)
    return -1

-----------------------------------------------------------------------------
def first_uniq_char(s):
    count = {}
    for char in s:
        if char in count:
            count[char] += 1
        else:
            count[char] = 1
    for i in range(len(s)):
        if count[s[i]] == 1:
            return i
    return -1
