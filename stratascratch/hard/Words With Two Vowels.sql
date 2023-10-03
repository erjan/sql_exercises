Find all words which contain exactly two vowels in any list in the table.



with h as(
select 
UNNEST(string_to_array(words1, ',')) as word
from google_word_lists
union
select 
UNNEST(string_to_array(words2, ',')) as word
from google_word_lists)


select * from h where  not word ~ '([aeiou].*){3}'
and word ~ '([aeiou].*){2}'
