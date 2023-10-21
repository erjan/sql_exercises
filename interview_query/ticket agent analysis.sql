'''
The support team at your company is trying to analyze ticketing data to improve response times. They have noticed that a significant number of tickets have no assigned agent, making it difficult to track the progress of these tickets.

Write a SQL query to count the total number of tickets, the number of tickets assigned to agents, and the number of tickets that are not assigned to any agent.

Note: Tickets that are not assigned to any agent have NULL in their agent_id field.
'''

SELECT 
count(id) as total_tickets,
ifnull(sum(case when agent_id is not null then 1 end),0) as tickets_with_agent,
sum(case when agent_id is null then 1 end) as tickets_without_agent
 FROM tickets
