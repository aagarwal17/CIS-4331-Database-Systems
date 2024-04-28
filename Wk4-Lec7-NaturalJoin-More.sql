--Wk 4, Lec 7 
--More Natural Join Examples (NOT in book or slides)

--Tables needed in this script are under user UV in the course table list

--natural join two tables with more than one common column with the same name
--common columns are included only one time in the query result.
select *
from section NATURAL JOIN takes;

--equivalent to above query, but use JOIN USING, 
--    explicitly listing the common columns used in the join
--common columns are only displayed one time in the query result.
select *
from section JOIN takes 
      USING (course_id, sec_id, semester, year);

--equivalent to above query, but use JOIN ON
--common columns are included twice in the query result.
--JOIN ON allows two tables to have different names for columns used in the join
select *
from section s JOIN takes t 
   ON (s.course_id = t.course_id)
   AND (s.sec_id = t.sec_id)
   AND (s.semester = t.semester)
   AND (s.year = t.year);