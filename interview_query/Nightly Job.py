'''
Every night between 7 pm and midnight, two computing jobs from two different sources are randomly started with each one lasting an hour.

Unfortunately, when the jobs simultaneously run, they cause a failure in some of the company’s other nightly jobs, resulting in downtime for the company that costs $1000. 

The CEO, who has enough time today to hear one word, needs a single number representing the annual (365 days) cost of this problem.

Note: Write a function to simulate this problem and output an estimated cost 

Bonus - How would you solve this using probability?
'''


import numpy as np

def simulate_overlap():
    n = 10000
    task1 = np.random.randint(0, 300, size = n)
    task2 = np.random.randint(0, 300, size = n)
    
    total_cost = 0
    for i in range(n):

        diff = abs(task1[i] - task2[i])
        if diff<=60:
            total_cost += 1
    

    return (total_cost/n)*365*1000

