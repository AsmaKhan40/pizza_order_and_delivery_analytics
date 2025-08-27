select * from `enhanced_pizza_sell_data_2024-25`;

alter table `enhanced_pizza_sell_data_2024-25` 
rename column  `ï»¿Order ID` to `Order ID`;

start transaction;

select * from `enhanced_pizza_sell_data_2024-25`
where `Order ID` IS null OR 
`Restaurant Name` IS null OR
`Location` IS null OR
`Order Time` IS null OR
`Delivery Time` IS null OR
`Delivery Duration (min)`IS null OR
`Pizza Size`IS null OR
`Pizza Type`IS null OR
`Toppings Count`IS null OR
`Distance (km)`IS null OR
`Traffic Level`IS null OR
`Payment Method`IS null OR
`Is Peak Hour`IS null OR
`Is Weekend`IS null OR
`Delivery Efficiency (min/km)`IS null OR
`Topping Density`IS null OR
`Order Month`IS null OR
`Payment Category`IS null OR
`Estimated Duration (min)`IS null OR
`Delay (min)`IS null OR
`Is Delayed`IS null OR
`Pizza Complexity`IS null OR
`Traffic Impact` IS null OR
`Order Hour`IS null OR
`Restaurant Avg Time` IS null ;

select distinct(`Restaurant Name`) from `enhanced_pizza_sell_data_2024-25`;
update `enhanced_pizza_sell_data_2024-25`
set `Restaurant Name`= "Marco's Pizza"
where `Restaurant Name`= "Marcoâ€™s Pizza";

select distinct(`Pizza Size`) from `enhanced_pizza_sell_data_2024-25`;
select distinct(`Pizza Type`) from `enhanced_pizza_sell_data_2024-25`;
select distinct(`Traffic Level`) from `enhanced_pizza_sell_data_2024-25`;
select distinct(`Payment Method`) from `enhanced_pizza_sell_data_2024-25`;
select distinct(`Order Month`) from `enhanced_pizza_sell_data_2024-25`;
select distinct(`Payment Category`) from `enhanced_pizza_sell_data_2024-25`;
select distinct(`Is Delayed`) from `enhanced_pizza_sell_data_2024-25`;

select `Delivery Efficiency (min/km)` from `enhanced_pizza_sell_data_2024-25`;
update  `enhanced_pizza_sell_data_2024-25`
set `Delivery Efficiency (min/km)`=Truncate (`Delivery Efficiency (min/km)`,3);
    
select `Topping Density`,`Restaurant Avg Time` from `enhanced_pizza_sell_data_2024-25`;
update  `enhanced_pizza_sell_data_2024-25`
set `Topping Density`=Truncate (`Topping Density`,3),
    `Restaurant Avg Time`=Truncate (`Restaurant Avg Time`,3);
    
commit;

SELECT `Order ID`, COUNT(*) AS duplicate_count
FROM `enhanced_pizza_sell_data_2024-25`
GROUP BY `Order ID`
HAVING COUNT(*) > 1;

SELECT *
FROM `enhanced_pizza_sell_data_2024-25`
WHERE STR_TO_DATE(`Order Time`, '%H:%i:%s') >= STR_TO_DATE(`Delivery Time`, '%H:%i:%s');

ALTER TABLE `enhanced_pizza_sell_data_2024-25` ADD COLUMN `Delay_Category` VARCHAR(20);

SET SQL_SAFE_UPDATES = 0;
UPDATE `enhanced_pizza_sell_data_2024-25`
SET `Delay_Category` = CASE
    WHEN `Delay (min)` = 0 THEN 'No Delay'
    WHEN `Delay (min)` <= 5 THEN 'Low Delay'
    WHEN `Delay (min)` <= 15 THEN 'Medium Delay'
    ELSE 'High Delay'
END;
SET SQL_SAFE_UPDATES = 1;

alter table `enhanced_pizza_sell_data_2024-25`
drop column `Is Delayed`; 


