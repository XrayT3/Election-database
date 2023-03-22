# Election-database

The topic of my work is elections. Or rather, the US presidential elections.

In my er-diagram, a voter is any American who can vote.
And elector is a member of an electoral college

Candidates, electors and vice presidential candidates are always different people. But all of them are citizens of the US. Citizens may be a voter and be identified by sign and name or citizen’s ID. Every candidate and vice presidential candidate has a party. Also the party can have observers. But observers may not belong to the party (recursive relationship type). 
Each state has electors who make up the electoral college. 
And every state has polling stations that can have observers.


P.S. [How the US elections work](youtube.com/watch?v=OUS9mM8Xbbw&list=LL&index=6).

# Entity–relationship model

![1062149](https://user-images.githubusercontent.com/25695606/226966683-57d0c406-6e47-474d-8e49-5906d611a673.png)

