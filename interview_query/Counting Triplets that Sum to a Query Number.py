Imagine you have been given an array of integers, and a query number k. Your 
task is to write a function that finds all the triplets in the array that sum up to the query number k.

def count_triplets(nums, k):
    triplets = 0

    n = len(nums)
    nums.sort()

    for i in range(n-2):

        for j in range(i+1, n-1):


            complement = k- nums[i]-nums[j]

            l = j+1
            r = n-1

            while l<=r:

                mid = (l+r)//2

                if complement == nums[mid]:
                    triplets+=1
                    break
                elif complement>nums[mid]:
                    l = mid+1
                else:
                    r = mid-1
    return triplets

     
