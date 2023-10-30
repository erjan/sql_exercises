Given two nonempty lists of user_ids and tips, write a function most_tips to find the user that tipped the most.


def most_tips(user_ids, tips):
    

    resid = -1
    maxtip = 0
    for user_id, cur_tip in zip(user_ids, tips):

        if cur_tip> maxtip:

            maxtip = cur_tip
            resid = user_id
    
    return resid


------------------------------------------------------------------
from collections import Counter

def most_tips(user_ids,tips):
    dct = Counter() 
# create an index and value for each user_id
    for i, v in enumerate(user_ids):
        dct[v] += tips[i]
        # sorts and gets the highest tip user_id
    return(dct.most_common()[0][0])
