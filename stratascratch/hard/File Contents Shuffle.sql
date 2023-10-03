Sort the words alphabetically in 'final.txt' and make a new file named 'wacky.txt'. Output the file contents in one column and the filename 'wacky.txt' in another column. Lowercase all the words. To simplify the question, there is no need to remove the punctuation marks.



If coding in python, the file contents should be contained in a list.


with h as(
select 

'wacky.txt' as filename,
unnest(string_to_array(lower(contents),' ')) as x

from google_file_store where filename ilike 'final%'
order by x )


select  filename, array_to_string( array_agg(x), ' ') as x from h
group by filename
