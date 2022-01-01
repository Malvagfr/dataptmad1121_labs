--Challenge 1 - Most Profiting Authors - top 3 most profiting authors 

--Step 1: Calculate the royalty of each sale for each author and the advance for each author and publication
--Advance of each title and author
select 
ti.title_id as title_id,
tiau.au_id as au_id,
ti.advance * tiau.royaltyper / 100 as advance
from titles as ti 
inner join titleauthor as tiau on ti.title_id=tiau.title_id
--Royalty of each sale
select 
sa.title_id as title_id,
tiau.au_id as au_id,
ti.price * sa.qty * ti.royalty / 100 * tiau.royaltyper / 100 as sales_royalty
from sales as sa 
inner join titles as ti on sa.title_id=ti.title_id
inner join titleauthor as tiau on ti.title_id=tiau.title_id


--Step 2: Aggregate the total royalties for each title and author
select 
royalties_by_autor_title.title_id,
royalties_by_autor_title.au_id,
royalties_by_autor_title.sales_royalty,
ti.advance * tiau.royaltyper / 100 as advance
from
(select 
title_id,
au_id,
sum(sales_royalty) as sales_royalty
from  
--royalties by sale,autor and title
(select 
sa.title_id as title_id,
tiau.au_id as au_id,
ti.price * sa.qty * ti.royalty / 100 * tiau.royaltyper / 100 as sales_royalty
from sales as sa 
inner join titles as ti on sa.title_id=ti.title_id
inner join titleauthor as tiau on ti.title_id=tiau.title_id ) as royalties_by_sale_autor_title
group by royalties_by_sale_autor_title.title_id,royalties_by_sale_autor_title.au_id) as royalties_by_autor_title
inner join titles as ti on royalties_by_autor_title.title_id=ti.title_id
inner join titleauthor as tiau on ti.title_id=tiau.title_id


--Step 3: Calculate the total profits of each author
select TOP 3
royalties_advance_by_autor_title.au_id,
sum(royalties_advance_by_autor_title.advance) + sum(royalties_advance_by_autor_title.sales_royalty) as profiles
from
(select 
royalties_by_autor_title.title_id,
royalties_by_autor_title.au_id,
royalties_by_autor_title.sales_royalty,
ti.advance * tiau.royaltyper / 100 as advance
from
(select 
title_id,
au_id,
sum(sales_royalty) as sales_royalty
from  
--royalties by sale,autor and title
(select 
sa.title_id as title_id,
tiau.au_id as au_id,
ti.price * sa.qty * ti.royalty / 100 * tiau.royaltyper / 100 as sales_royalty
from sales as sa 
inner join titles as ti on sa.title_id=ti.title_id
inner join titleauthor as tiau on ti.title_id=tiau.title_id ) as royalties_by_sale_autor_title
group by royalties_by_sale_autor_title.title_id,royalties_by_sale_autor_title.au_id) as royalties_by_autor_title
inner join titles as ti on royalties_by_autor_title.title_id=ti.title_id
inner join titleauthor as tiau on ti.title_id=tiau.title_id) as royalties_advance_by_autor_title
group by royalties_advance_by_autor_title.au_id
order by profiles desc 


--Challenge 2 - Alternative Solution

--Challenge 3