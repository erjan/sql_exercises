'''
Write a function to determine the mode of an array of integers.

The list may have one mode, more than one mode, or no mode at all. If the list has multiple modes, return them in ascending order.
'''

def mode (nums : list):

    d = dict()

    for n in nums:
        if n not in d:
            d[n] = 1
        else:
            d[n]+=1
    
    mode = max(d.values())
    res = set()

    for k in d.keys():
        if d[k] == mode:
            res.add(k)
    
    return list(res)
    

    
