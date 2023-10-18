Write a function called find_bigrams that takes a sentence or paragraph of strings and returns a list of all its bigrams in order.

Note: A bigram is a pair of consecutive words.


def find_bigrams(s):
    d = s.split()

    d = [i.lower() for i in d]

    res = []

    for i in range(len(d) - 1):
        res.append((d[i], d[i + 1]))

    print(res)
    return res
