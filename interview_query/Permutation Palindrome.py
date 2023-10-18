Given a string str, write a function perm_palindrome 
to determine whether there exists a permutation of str that is a palindrome.


from collections import Counter
def perm_palindrome(s):
    d = dict(Counter(s))

    
    values = list(d.values())

    morethan1 = False
    for v in values:
        if v%2 == 1:
            morethan1+=1
        if morethan1>1:
            return False
    
  
    return True
        
