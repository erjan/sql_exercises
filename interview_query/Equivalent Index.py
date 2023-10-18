Given a list of integers, find the index at which the sum of the left 
half of the list is equal to the right half.

If there is no index where this condition is satisfied return -1.


def equivalent_index(nums):

     
     
     totalsum = sum(nums)
     lsum = 0
     rsum = 0
     key = -1
     for i in range(len(nums)):

          lsum += nums[i]

          rsum = 0
          for j in range(i+1, len(nums)):

               rsum += nums[j]
          if lsum == rsum:
               key = i
               break
     
     return key


