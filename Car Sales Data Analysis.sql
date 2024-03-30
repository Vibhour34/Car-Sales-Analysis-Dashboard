create database Car_Sales_DB;
use Car_Sales_DB;

select * from cars_dataset;

alter table cars_dataset rename column ï»¿model to model;
alter table cars_dataset rename column Make to Brand;

select * from cars_dataset;

select * from car_sales_by_brand;

alter table car_sales_by_brand rename column Make to Brand;

select * from car_sales_by_brand;

#1 Checking Null Values
select * from cars_dataset where
model is null or year is null or price is null or
transmission is null or mileage is null or fuelType is null or
tax is null or engineSize is null or Brand is null;

select * from car_sales_by_brand where
year is null or Month is null or Brand is null or Quantity is null or Pct is null;

#2 Checking Duplicate Values
select * from cars_dataset group by
model, year, price, transmission, mileage, fuelType, tax, engineSize, Brand having count(*)>1;

select * from car_sales_by_brand group by
year, Month, Brand, Quantity, Pct having count(*)>1;

#3 Total Revenue for each brand
select Brand, sum(price) as total_revenue from cars_dataset group by Brand order by total_revenue desc;

#4 Total Brand count
select count(distinct brand) as total_brands from car_sales_by_brand;

#5 Total Sold Quantitites for particular brand in every year
select Brand, year, sum(quantity) as total_quantity from car_sales_by_brand where brand in ("Audi","BMW","Ford","Volkswagen","Toyota","Skoda","Hyundai") group by year,brand order by year asc, total_quantity desc;

#6 Total revenue for these particular brand
select Brand, sum(price) as total_revenue from cars_dataset where brand in ("Audi","BMW","Ford","Volkswagen","Toyota","Skoda",
"Hyundai") group by Brand order by total_revenue desc;

#7 Top 5 most expensive cars with their brand and model name
select Brand,model,year,price from cars_dataset order by price desc limit 5;

#8 Total no of models for particular brand car
select Brand,count(distinct model) from cars_dataset group by brand;

#9 Top 5 revenue generated car models with their brand
select model,sum(price) as total_revenue,brand from cars_dataset group by model,brand order by total_revenue desc limit 5;

#10 Brand market share analysis
select Brand,sum(quantity) as total_sales,round(sum(quantity)*100/(select sum(quantity) from car_sales_by_brand),2) as market_share from car_sales_by_brand where brand in ("Audi","BMW","Ford","Volkswagen","Toyota","Skoda","Hyundai") group by brand order by total_sales desc;

#11 Top 5 fuel efficient model name with their brand,transmission mode,engine size and fuel type
select Brand,model, max(mileage), transmission, engineSize, fuelType from cars_dataset group by model,brand, transmission, engineSize, fuelType order by max(mileage) desc limit 5;

#12 Top 5 cars with Average price and sales quantity by brand, fuel type, and transmission mode
select t1.Brand, t1.fuelType, t1.transmission, avg(t1.price) as Avg_price, sum(t2.quantity) as total_sales from cars_dataset as t1 join car_sales_by_brand as t2 on t1.Brand = t2.Brand and t1.year=t2.year group by t1.Brand, t1.fuelType, t1.transmission order by Avg_price desc limit 5;