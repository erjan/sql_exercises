Given a 2-D matrix P of predicted values and actual 
values, write a function precision_recall to calculate precision and recall metrics.

Return the ordered pair (precision, recall).


def precision_recall(p):
    

    tp = p[0][0]
    fp = p[1][0]

    fn = p[0][1]
    tn = p[1][1]

    precision = tp/(tp+fp)
    recall = tp/(tp+fn)
    return [precision,recall]
