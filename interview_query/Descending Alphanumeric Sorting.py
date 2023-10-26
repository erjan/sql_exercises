'''
You are given an array of strings arr, where each string is in the format: <letters><number>. For example, you might see "a1", "b32", or "caba522".

Write a function called custom_sort(arr), which sorts the list of strings in two ways: first by the letter, in alphabetical order, and second by the numbers in descending order.

'''

def custom_sort(arr):
    res = []
    for a in arr:
        name = ""

        i = 0
        while i < len(a):
            if not a[i].isdigit():
                name += a[i]
            else:
                break
            i += 1

        digs = a[i:]
        digs = int(digs)
        res.append([name, digs])

    res = sorted(res, key=lambda x: (x[0], -x[1]))

    temp = []

    for a, b in res:
        c = str(a) + str(b)
        temp.append(c)

    return temp

-----------------------------------------------------------------------------------------------------
def custom_sort(arr):
    def get_letter_and_num(s):
        # Find the position where the number starts
        pos = next((i for i, c in enumerate(s) if c.isdigit()), len(s))
        return s[:pos], int(s[pos:])

    # Using sorted with a custom key for sorting
    return sorted(arr, key=lambda x: (get_letter_and_num(x)[0], -get_letter_and_num(x)[1]))
