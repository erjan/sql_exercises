'''
You’re given numlists, a list where each element is a list of at least five numbers.

Write a function list_fifths that returns a list of the fifth-largest number from each element in numlists. Return the list in ascending order.
'''


def list_fifths(numlists):
  
    res = []

    for lst in numlists:

        x = sorted(lst)[-5]
        res.append(x)
    
    return sorted(res)

--------------------------------------
def list_fifths(numlists):
    final_list = []
    n = len(numlists)
    for i in range(n):
        numlists[i].sort(reverse=True)
        final_list.append(numlists[i][4])
    final_list.sort()
    return final_list
