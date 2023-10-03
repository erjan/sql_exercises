Count the number of words per row in both words lists.




select
    ARRAY_UPPER(STRING_TO_ARRAY(words1,','),1)
    
from google_word_lists;
