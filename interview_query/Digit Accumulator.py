You are given a string that represents some floating-point number. 
Write a function, digit_accumulator, that returns the sum of every digit in the string.

def digit_accumulator(s):
    
    res = 0

    for ch in s:

        if ch.isdigit():
            res += int(ch)
    return res

---------------------------------------------------------------------
def digit_accumulator(s):
    accumulator = 0
    for char in s:
        if char in '0123456789':
            accumulator += int(char)
    return accumulator
