'''
You’re given a table that represents search results from searches 
  on Facebook. The query column is the search term, the position column represents 
  each position the search result came in, and the rating column represents the human rating of the search result from 1 to 5 where 5 is high relevance and 1 is low relevance.
'''


select  query,
round(avg(rating/position),2) as avg_rating

 FROM search_results

 group by query
