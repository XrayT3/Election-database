/*A: the names of the electors in California who violated the state choice*/
SELECT Citizen.name
FROM Citizen 
NATURAL INNER JOIN Elector AS E
JOIN usState AS S ON (E.usState = S.name)
WHERE (E.usState = 'California') AND (S.winningCandidate <> E.vote)
ORDER BY name ASC;
 
/*B: names of Democratic observers in Texas*/
    SELECT ObserverAffilation.name
    FROM ObserverAffilation
    WHERE 
        pollingStation IN(
            SELECT id
            FROM PollingStation
            WHERE (usState = 'Texas')
        )
UNION
    SELECT ObserverAffilation.name
    FROM ObserverAffilation
    WHERE (partyName = 'Democratic Party');
     
 
/*C: citizens who didn't vote in New York*/
SELECT Citizen.name, id
FROM 
    Citizen 
    LEFT OUTER JOIN Voter ON
        (id = citizen) AND (city = 'New York') AND (age >= 21)
WHERE (sign IS NULL)
ORDER BY name;
 
 
/*D: list of states by their influence on elections without the smallest*/
SELECT usState, COUNT(id) AS cnt_electors
FROM Elector
GROUP BY usState
HAVING (COUNT(id) > 3)
ORDER BY cnt_electors DESC;
 
 
/*E: Names of observers and their phone from all states that have Slava Larionov as their supervisor*/
SELECT phone, op.observer, ps.name
FROM ObserverPhone AS OP
JOIN Boss AS B ON (OP.observer = B.observer) AND (OP.pollingStation = B.pollingStation)
JOIN PollingStation as PS ON (B.pollingStation = PS.id)
WHERE (supervisor = 'Slava Larionov')
ORDER BY ps.name;