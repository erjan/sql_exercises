/*

Write a query to find the node type of Binary 
Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.

*/


SELECT N, 
case when p is null then 'Root'
when (select count(*) from bst where p = b.n) > 0 then 'Inner'
else 'Leaf' end 

FROM BST AS B ORDER BY N;
