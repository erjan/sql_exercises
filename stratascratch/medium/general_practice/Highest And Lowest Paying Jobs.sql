Find the ratio and the difference between the highest and lowest total pay for each job title. Output the job title along with the corresponding difference, ratio, highest total pay, and the lowest total pay. Sort records based on the ratio in descending order.



select 

jobtitle,

max(totalpay)max_totalpay, min(totalpay)min_totalpay,
max(totalpay)-min(totalpay)as difference,
max(totalpay)/min(totalpay)::numeric as ratio


from sf_public_salaries
where totalpay > 0
group by jobtitle
order by ratio desc
