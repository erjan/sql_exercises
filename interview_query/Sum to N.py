Given a list of integers, and an integer N, 
write a function sum_to_n to find all combinations that sum to the value N.



  def sum_to_n(integers , target):


    def recursive(curlist, candidates, output):

        if sum(curlist) == target:
            output.append(curlist)
            return output
        
        else:
            for i in range(len(candidates)):
                if sum(curlist) + candidates[i] <=target:
                    recursive( curlist + [candidates[i]] ,candidates[i:],output ) 
                
    
        return output
    
    x = recursive([], integers, [])
    return x


