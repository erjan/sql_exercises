'''
Let’s say there are many vehicles on a long road. At each mile along the road, a checkpoint indicates the length traveled across the road.

You are given a list called vehicles which indicates the number of vehicles between each checkpoint. For example, the list [7,4,3] would mean that there are seven vehicles before the first checkpoint, four vehicles between the first and second checkpoints, and three vehicles between the second and third checkpoints.

Write a function range_vehicles that will give the number of vehicles between the start and end checkpoints.

Note: start may be 0
'''

def range_vehicles(vehicles, start, end):
    

    res = 0
    for i in range(len(vehicles)):

        if i >= start and i < end:
            res+= vehicles[i]
    
    return res
-----------------------------------------------------------
def range_vehicles(vehicles, start, end):
    return sum(vehicles[start:end])
