'''
  Given a 2D terrain represented by an array of non-negative integers, where each integer represents the height of a terrain level at that index, implement an algorithm to calculate the total amount of rainwater that can be trapped in this terrain. Consider that rainwater can only be trapped between two terrain levels with higher heights, and the trapped water cannot flow out through the edges.

The algorithm should have an optimal time complexity of O(n) and a space complexity of O(n). Provide a detailed explanation of the algorithm and its implementation in Python.
  '''


def trapped_rainwater(terrainLevels):
    
   n = len(terrainLevels)

   leftmax = [0]*n
   rightmax = [0]*n

   leftmax[0] = terrainLevels[0]

   for i in range(1,n):
       leftmax[i] = max(leftmax[i-1], terrainLevels[i])
   rightmax[n-1] = terrainLevels[n-1]

   for i in range(n-2,-1,-1):
       rightmax[i] = max(rightmax[i+1], terrainLevels[i])
    
   total = 0
   for i in range(n):
       minheight = min(leftmax[i], rightmax[i])
       total += minheight-terrainLevels[i]
   return total
