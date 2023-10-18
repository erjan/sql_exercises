Given two sorted lists, write a function to merge them into one sorted list.

Bonus: What’s the time complexity?

def merge_list(t1, t2):

    p1 = 0
    p2 = 0

    res = []

    while p1 < len(t1) and p2 < len(t2):

        if t1[p1]< t2[p2]:
            res.append(t1[p1])
            p1+=1
        elif t1[p1]>= t2[p2]:
            res.append(t2[p2])
            p2+=1
    

    if p1 < len(t1):
        res.extend(t1[p1:])
    elif p2 < len(t2):
        res.extend(t2[p2:])
    return res
