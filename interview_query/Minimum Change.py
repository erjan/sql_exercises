Write a function find_change to find the minimum number
of coins that make up the given amount of change
cents. Assume we only have coins of value 1, 5, 10, and 25 cents.


  def minimum_change(cents):  
    res = 0

    d = [25,10,5,1]
    cur = 0
    for val in d:

        full,rem = divmod(cents, val)
        res += full
        cents = cents%val
    return res

