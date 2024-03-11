from typing import List, Dict

def create_value_count(A: List) -> Dict:
    val_cnt = {}
    for a in A:
        if a in val_cnt:
            val_cnt[a] += 1
        else:
            val_cnt[a] = 1
    return val_cnt


def automatic_histogram(dataset, x):
    element_count = create_value_count(dataset)

    unique_elements = list(element_count.keys())

    i = 0
    step = len(unique_elements) // x
    if len(unique_elements) % x != 0:
        step += 1
    buckets = {}
    while i < len(unique_elements):
        tup = tuple(unique_elements[i:i+step])
        buckets[tup] = 0
        i += step
    
    histogram = {}
    for e, count in element_count.items():
        for bucket in buckets:
            if e in bucket:
                if len(bucket) > 1:
                    bucket_str = str(min(bucket))+'-'+str(max(bucket))
                else:
                    bucket_str = str(bucket[0])
                if bucket_str in histogram:
                    histogram[bucket_str] += count
                else:
                    histogram[bucket_str] = count
                break
    return histogram
