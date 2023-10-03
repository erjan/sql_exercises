Find the top 3 most common letters across all the words from both the tables (ignore filename column). Output the letter along with the number of occurrences and order records in descending order based on the number of occurrences.


with h as(
select 
lower(unnest(string_to_array(contents, ' '))) as x
from google_file_store
union all
select 
lower(unnest(string_to_array(words1, ','))) as x
from google_word_lists
union all 
select 
lower(unnest(string_to_array(words2, ',')))as x
from google_word_lists)

select x , count(*) as i from (
select unnest(regexp_split_to_array(x, ''))  as x from h)k
group by x order by i desc limit 3
