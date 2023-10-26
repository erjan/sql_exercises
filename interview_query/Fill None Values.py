Given a sorted list of positive integers with some entries being None, write a 
function to return a new list where all None values are replaced with the most recent non-None value in the list.

Note: If the first entry in the list is None, assume the previous entry was 0.



def fill_none(input_list):


    prev = 0

    for i in range(len(input_list)):

        if i == 0 and input_list[i] == None:
            input_list[i] = 0
            prev = input_list[i]
        
        
        elif input_list[i] == None:
            input_list[i] = prev
            prev = input_list[i]
        else:
            prev = input_list[i]
    
    return input_list
==================================================================================

#not in place solution

def fill_none(input_list):
    prev_value = 0

    result = []
    for value in values:
        if value is None:
            result.append(prev_value)
        else:
            result.append(value)
            prev_value = value

    return result
