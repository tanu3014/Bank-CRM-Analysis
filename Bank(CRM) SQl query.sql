use bank_crm;

-- Objective Answer 2

Select 
	CustomerId,Surname,EstimatedSalary from customerinfo 
where
	substring(`Bank DOJ`,4,2) in (10,11,12) 
order by 
	EstimatedSalary desc
limit 5;

-- Objective Answer 3
Select 
    round(Avg(NumOfProducts),2) as avg_product
from 
	bank_churn
where
	HasCrCard = 1;

    
-- Objective Answer 5

SELECT 
    AVG(case when Exited =1 then creditScore end) as exited_cr_score,
	AVG(case when Exited =0 then creditScore end) as remain_cr_score
FROM 
    bank_churn;

-- objective answer 6
select 
	GenderCategory as Gender,
    round(Avg(EstimatedSalary),2) as AvgEstimatedSalary,
    count(case when IsActiveMember=1 then c.CustomerId end) as Active_Member
from customerinfo c
join 
	gender g on c.GenderID=g.GenderID
join 
	bank_churn b on c.CustomerId=b.CustomerId
group by
	GenderCategory;
    
-- Objective Answer 7

select 
	case when creditscore <= 579 then "Poor"
    when creditscore between 580 and 669 then "Fair"
	when creditscore between 670 and 739 then "Good"
    when creditscore between 740 and 799 then "Very Good"
    when creditscore>=800 then "Excellent"
    end as `credit score segments`,
    count(case when exited =1 then customerid end) as exit_rate
from 
	bank_churn
group by 
	`credit score segments`
order by 
	exit_rate desc;
    
    
-- Objective answer 8

Select GeographyLocation as Region, count(case when IsActiveMember = 1 then c.CustomerId end) as ActiveCustomers
from bank_churn b 
join customerinfo c on b.CustomerId=c.CustomerId
join geography g on c.GeographyID=g.GeographyID
where Tenure>5
group by region;

-- Objective Answer 10
select
	NumOfProducts,count(*) as Exited_Customer 
from 
	bank_churn
where 	
	exited =1
group by
	NumOfProducts
order by 
	Exited_Customer desc;

-- Objective answer 11

Select 
	right(`Bank DOJ` ,4) as Year, 
	count(customerid) as no_of_customer_joined
from 
	customerinfo
group by 
	Year
order by
	Year;

-- Objective Answer 12

select 
	NumOfProducts, 
    round(Avg(Balance),2) as avg_account_balance,
    Count(*) as customer_exited
 from 
	bank_churn
 where 
	Exited = 1
 group by
	NumOfProducts;
 
 -- Objective answer 15
 
 select 
	GeographyID, 
	GenderCategory as Gender, 
    round(avg(EstimatedSalary),2) as avg_income,
    rank() over(partition by GeographyID order by  avg(EstimatedSalary) desc) as gender_rank
 from 
	customerinfo c
join 
	gender g on c.GenderID=g.GenderID
group by 
	GeographyID,Gender;
    
-- Objective answer 16

select 
	case when Age between 18 and 30 then "18-30"
		 when Age between 30 and 50 then "30-50"
		 when Age>50 then "50+"
	end as `Age brackets`,
    Avg(Tenure)  as avg_tenure
from 
	customerinfo c
join 
	bank_churn b on c.CustomerID=b.CustomerID
where Exited = 1
group by 
	`Age brackets`;
    
-- objective answer 19

select 
	case when creditscore <= 579 then "Poor"
    when creditscore between 580 and 669 then "Fair"
	when creditscore between 670 and 739 then "Good"
    when creditscore between 740 and 799 then "Very Good"
    when creditscore>=800 then "Excellent"
    end as `credit score bucket`,
    count(case when exited =1 then customerid end) as exit_rate,
    dense_rank() over(order by count(case when exited =1 then customerid end) desc) as `bucket rank`
from 
	bank_churn
group by 
	`credit score bucket`;
    
-- Objective answer 20

with cardinfo as (select 
	case when Age between 18 and 30 then "Adult"
		 when Age between 30 and 50 then "Middle-Aged"
		 when Age>50 then "Old-Aged"
	end as `Age bucket`,
    count(HasCrCard) as HasCreditCard
from
	customerinfo c
join 
	bank_churn b on c.CustomerId=b.CustomerId
where HasCrCard= 1
group by 1)
select * from cardinfo 
where HasCreditCard< (select avg(HasCreditCard) from cardinfo);

-- Objective answer 21

Select 
	GeographyLocation as Location,
    Avg(Balance) as avg_balance, 
    count(case when Exited=1 then customerId end) as churned_cx,
    dense_rank() over(order by  count(case when Exited=1 then customerId end) desc) as `ChurnRank`,
    dense_rank() over ( order by avg(balance) desc )as balance_rank
from 
	bank_churn
join 
	customerinfo using(CustomerId)
join 
	geography using(GeographyID)
group by 
	Location;
    
-- Objective answer 22

select c.CustomerId, Surname,Concat(c.CustomerId,"_",c.Surname) as customerid_surname
from customerinfo c
join bank_churn ot on c.CustomerId=Ot.CustomerId;

-- Objective answer 23

Select *, 
	case when Exited = 1 then 'Exit' else 'Retain' end as exit_category
from 
	bank_churn;
    
-- Objective answer 25

select 
	CustomerId,
	Surname as lastname, 
    case when IsActiveMember = 1 then 'Active' else 'Non-active' end as active_status
from 
	bank_churn
join 
	customerinfo using(CustomerId)
where 
	Surname Like  "%on";
		
   -- Answer to objective 26     
        
SET SQL_SAFE_UPDATES = 0;

UPDATE bank_churn
SET IsActiveMember = 0
WHERE Exited = 1 ;

UPDATE bank_churn
SET IsActiveMember = 1
WHERE Exited = 0 ;



-- Subjective answer 9

Select 
	GeographyLocation as Region,
	Count(c.customerID) as num_of_customers,
    Avg(balance) as avg_balance
from 
	bank_churn b
join 
	customerinfo c on b.CustomerId=c.CustomerId
join 
	geography g on c.GeographyID=g.GeographyID
group by 
	Region;


	
 
 



 















