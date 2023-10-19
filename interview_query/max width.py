
'''
Given an array of words and a max_width parameter, write a function justify to format the text such that each line has exactly max_width characters. Pad extra spaces ’ ‘ when necessary so that each line has exactly max_width characters.

Extra spaces between words should be distributed as evenly as possible. If the number of spaces on a line does not divide evenly between words, place excess spaces on the right-hand side of each line.

Note: You may assume that there is no word in words that is longer than max_width.
'''


def justify(words, max_width):
    
    res = []
    cur = []
    num_of_letters = 0

    for w in words:
        if num_of_letters + len(w) + len(cur) > max_width:
            for i in range(max_width - num_of_letters):
                cur[i % (len(cur) - 1 or 1)] += ' '
            res.append(''.join(cur))
            cur, num_of_letters = [], 0
        cur += [w]
        num_of_letters += len(w)

    # Treat the last line in the same way as the other lines
    for i in range(max_width - num_of_letters):
        cur[i % (len(cur) - 1 or 1)] += ' '
    res.append(''.join(cur))

    return res
