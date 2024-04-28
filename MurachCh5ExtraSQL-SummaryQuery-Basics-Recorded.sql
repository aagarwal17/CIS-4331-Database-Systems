--Murach Ch5
--Extra SQL Code Demo for Sumary Query Basics

--Topics covered: 
--Basic summary query, DISTINCT, *

--To run these queries, you must first create & populate the table testagg as follows:
-- 1. Open the script file MurachCh5-CreateTestAGG.sql in Oracle SQL Developer
-- 2. Run the entire script

--Table testagg content:
--     SCORE
------------
--      86.5
--      86.5
--        91
--      NULL
      
--Print how many scores there are totally. 
-- i.e. including unqiue values, NULLs and duplicates.
SELECT COUNT(*) 
FROM testagg;

--Print how many scores are known totally.
SELECT COUNT(score) 
FROM testagg;

--Print how many unqiue scores are known totally.
SELECT COUNT(DISTINCT score) 
FROM testagg;

--Print the total of all scores that are known.
SELECT SUM(score) 
FROM testagg;

--Print the average of all scores that are known.
SELECT SUM(score) / COUNT(score)
FROM testagg;

--Print the average of all scores that are known.
SELECT AVG(score) 
FROM testagg;

--Print the average of all scores. 
SELECT SUM(score) / COUNT(*)
FROM testagg;