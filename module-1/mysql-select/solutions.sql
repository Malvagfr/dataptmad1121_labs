--Challenge 1 - Who Have Published What At Where?
--what titles each author has published at which publishers
select
au.au_id as "AUTHOR ID"
,au.au_lname as "LAST NAME"
,au.au_Fname as "FIRST NAME"
,ti.title as "TITLE"
,pu.pub_name as "PUBLISHER"
from dbo.authors as au
inner join dbo.titleauthor as tiau on au.au_id=tiau.au_id
inner join dbo.titles as ti on tiau.title_id=ti.title_id
inner join dbo.publishers as pu on ti.pub_id=pu.pub_id
--select count(*) from dbo.titleauthor --uncomment for test the result


--Challenge 2 - Who Have Published How Many At Where?
--how many titles each author has published at each publisher?
with title_author_publisher as (
select
au.au_id as "AUTHOR ID"
,au.au_lname as "LAST NAME"
,au.au_Fname as "FIRST NAME"
,ti.title as "TITLE"
,pu.pub_name as "PUBLISHER"
from dbo.authors as au
inner join dbo.titleauthor as tiau on au.au_id=tiau.au_id
inner join dbo.titles as ti on tiau.title_id=ti.title_id
inner join dbo.publishers as pu on ti.pub_id=pu.pub_id),

number_titles_by_au_pub as (select 
"AUTHOR ID",
"LAST NAME",
"FIRST NAME",
"PUBLISHER",
count("TITLE") as "TITLE COUNT"
FROM title_author_publisher
GROUP BY "AUTHOR ID","LAST NAME","FIRST NAME","PUBLISHER")
select * from number_titles_by_au_pub --uncomment for see the result
--select SUM("TITLE COUNT") from number_titles_by_au_pub --uncomment for test the result


--Challenge 3 - Best Selling Authors
--Who are the top 3 authors who have sold the highest number of titles?
select top 3
au.au_id as "AUTHOR ID"
,au.au_lname as "LAST NAME"
,au.au_Fname as "FIRST NAME"
,sum(sal.qty) as TOTAL
from dbo.authors as au
left join dbo.titleauthor as tiau on au.au_id=tiau.au_id
left join dbo.sales as sal on tiau.title_id=sal.title_id
group by au.au_id,au.au_lname,au.au_Fname
order by TOTAL desc

--Challenge 4 - Best Selling Authors Ranking
select 
au.au_id as "AUTHOR ID"
,au.au_lname as "LAST NAME"
,au.au_Fname as "FIRST NAME"
,isnull(sum(sal.qty),0) as TOTAL
from dbo.authors as au
left join dbo.titleauthor as tiau on au.au_id=tiau.au_id
left join dbo.sales as sal on tiau.title_id=sal.title_id
group by au.au_id,au.au_lname,au.au_Fname
order by TOTAL desc
