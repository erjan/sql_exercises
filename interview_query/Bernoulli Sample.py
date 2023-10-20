Write a function to get a sample from a Bernoulli trial.

import random

def bernoulli_sample(p):
    x=random.random()
    if x<=p:
        return 1
    else:
        return 0
