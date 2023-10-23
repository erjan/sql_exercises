You are given a singly linked list, write a function to find and return the last node of the list. If the list is empty, return null.


"""
head object example : {"data":1,"next":{"data":2,"next":{"data":3,"next":None}}}
"""
def get_last_node(h):

    if not h:
        return None

    cur = h
    while cur["next"] is not None:
        cur = cur["next"]

    
    return cur
    

