Given a list of numbers nums and an integer window_size, write a function moving_window to find the moving window average.



  def moving_window(input_list,window_size):

    window_start = 0
    window_end = 0

    res = 0

    out = []

    while window_end< len(input_list):
        res += input_list[window_end]
        out.append(res/(window_end-window_start+1))

        window_end+=1

        if window_end-window_start>=window_size:
            res -= input_list[window_start]
            window_start+=1
    
    return out
