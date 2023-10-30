'''
Given an integer 
�
n, write a function traverse_count to determine the number of paths from the top left corner of an 
�
×
�
n×n grid to the bottom right. You may only move right or down.
'''

def traverse_count(n):
    dp = [[0 for _ in range(n)] for _ in range(n)]

    # first row is all 1s - cuz
    for i in range(n):
        dp[0][i] = 1

    for i in range(n):
        dp[i][0] = 1

    for i in range(1, n):
        for j in range(1, n):
            dp[i][j] = dp[i - 1][j] + dp[i][j - 1]

    res = dp[-1][-1]

    return res
