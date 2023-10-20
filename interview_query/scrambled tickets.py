

'''
Consider a trip from one city to
another that may contain many layovers. Given the list of flights out
of order, each with a starting city and end city, write a function plan_trip
to reconstruct the path of the trip so the trip tickets are in order.
'''


def plan_trip(flights):
    
    graph = dict()
    for s,e in flights:
        graph[s] = e
    

    #find start city

    start = None
    for city in graph.keys():
        if city not in graph.values():
            start = city
            break
    if not start:
        return []

    res = []

    while start in graph:
        nextdest = graph[start]
        res.append([start, nextdest])
        start = nextdest
    
    return res

    
