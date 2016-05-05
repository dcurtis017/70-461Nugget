/**
-->Aggregate Basics
group by 
having pretty much a where clause for a group by
goruping sets allows us to add subtotals and grand totals to a results set

-->Analytical Functions
cume_dist cummulative distribution of data across a group
first_value, last_value first/last value in a group ex: which employee sold the first car
lag, lead help solve the problem of joining a table to itself to compare data. lead can look at the next row and compare to...lag is the opposite
percentile_cont/percentile_disc continuous/discreet...percent based on a weight we pass in
percent_rank

-->Ranking Functions
rank
dense_rank
ntile things like quartiles ex: ntiles(4) splits the group into 4 segments (quartiles)
row_number

-->Spacial Aggregates
union combines multiple spacial objects into one
envelope
collection
convex hull

*/