Write a program in python to determine the TF (term_frequency) values for each term of this document.

Note: Round the term frequency to 2 decimal points.


def term_frequency(sentences):
    
    s = sentences.split()
    total = len(s)

    d = dict()
    for el in s:

        if el not in d:
            d[el] =1
        else:
            d[el]+=1
    
    for k in d:
        d[k] = round(d[k]/total,2)
    
    return d
