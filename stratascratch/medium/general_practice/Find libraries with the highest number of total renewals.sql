Find libraries with the highest number of total renewals.
Output all home library definitions along with the corresponding total renewals.
Order records by total renewals in descending order.



select

home_library_definition,

sum(total_renewals)

from library_usage

group by home_library_definition
