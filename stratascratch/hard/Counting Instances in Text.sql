Find the number of times the words 'bull' and 'bear' occur in the contents. We're counting the number of times the words occur so words like 'bullish' should not be included in our count.
Output the word 'bull' and 'bear' along with the corresponding number of occurrences.

(SELECT 'bear' as word, count(*) as N
FROM google_file_store 
WHERE contents LIKE '%bear %' or contents like '%bears %')
UNION
(SELECT 'bull' as word, count(*) as N
FROM google_file_store 
WHERE contents LIKE '%bull %' or contents like '%bull %')
