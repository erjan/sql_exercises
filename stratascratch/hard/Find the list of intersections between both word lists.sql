Find the list of intersections between both word lists.



select
    unnest(STRING_TO_ARRAY(words1,','))r1

from google_word_lists

intersect

select
    unnest(STRING_TO_ARRAY(words2,','))r2

from google_word_lists
