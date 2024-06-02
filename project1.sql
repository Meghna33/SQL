select*
from ipl_ball

select*
from ipl_matches

select*
from deliveries_v02

select*
from deliveries_v03

--1.Get the count of cities that have hosted an IPL match//

select count(city)
from ipl_matches;

--2.Create table deliveries_v02 with all the columns of the table ‘deliveries’ and an additional column ball_result containing values boundary, dot or other depending on the total_run (boundary for >= 4, dot for 0 and other for any other number).

create table deliveries_v02 as select *,  
    CASE WHEN total_runs >= 4 then 'boundary'  
    WHEN total_runs = 0 THEN 'dot' 
    else 'other' 
    END as ball_result  
FROM ipl_ball;


--3.Write a query to fetch the total number of boundaries and dot balls from the deliveries_v02 table//
  
select ball_result,count(*)
from deliveries_v02
group by ball_result
limit 2;
 
--4.Write a query to fetch the total number of boundaries scored by each team from the deliveries_v02 table and order it in descending order of the number of boundaries scored.//
 
select batting_team, count(*) as num_boundary
from deliveries_v02
where ball_result='boudary'
group by batting_team
order by num_boundary desc;
 
 
--5.Write a query to fetch the total number of dot balls bowled by each team and order it in descending order of the total number of dot balls bowled.//
 
select bowling_team, count(*) as num_dot
from deliveries_v02
where ball_result='dot'
group by bowling_team
order by num_dot desc;
 
--6.Write a query to fetch the total number of dismissals by dismissal kinds where dismissal kind is not NA//
 
select dismissal_kind,count(*)
from deliveries_v02
where dismissal_kind is not null
group by dismissal_kind;

--7.Write a query to get the top 5 bowlers who conceded maximum extra runs from the deliveries table.// 
 
select bowler, sum(extra_runs) as extra_run
from deliveries_v02
group by bowler
order by extra_run desc
limit 5;

--8.Write a query to create a table named deliveries_v03 with all the columns of deliveries_v02 table and two additional column (named venue and match_date) of venue and date from table matches//

create table deliveries_v03 as select d.*,
m.match_date, m.venue
from ipl_matches as m
join deliveries_v02 as d
on m.match_id= d.match_id;

--9.Write a query to fetch the total runs scored for each venue and order it in the descending order of total runs scored.

select venue, sum(total_runs) as run_score
from deliveries_v03
group by venue
order by run_score desc;

--10.Write a query to fetch the year-wise total runs scored at Eden Gardens and order it in the descending order of total runs scored.
 
select sum(total_runs) as run_score, extract (Year from match_date) as years
from deliveries_v03
where venue='Eden Gardens'
group by years
order by run_score desc;

