create DATABASE database_name;

use database_name;

drop table if EXISTS dim_date;

create TABLE dim_date (
	`date` date,
	date_key int primary key, -- yyyymmdd 20190903
	`year` smallint,
	month_num tinyint,
	month_name varchar(10), -- September
	month_name_short varchar(3), -- Sep
	month_year varchar(15), -- mmmm yyyy September 2019
	month_short_year varchar(10), -- mmm yyyy Sep 2019
	year_month_num MEDIUMINT,  -- yyyymm 201909
	quarter_num tinyint,
	quarter_name varchar(2), -- Q3
	quarter_year varchar(7), -- Q3-2019
	quarter_year_short varchar(5), -- Q3-19
	day_of_month tinyint, -- 1..31
	day_name varchar(10), -- Tuesday
	day_name_short varchar(3), -- Tue
	day_of_week tinyint, -- 1..7
	weekday_flag varchar(7) -- weekday, weekend
-- 	year_offset smallint, 
-- 	month_offset smallint,
-- 	day_offset smallint,
-- 	past_future_flag varchar(10) -- -1 past, 0 today, 1 future
	,
    created_at datetime not null  default now(),
    updated_at datetime not null  default now() on update now()

)
;
