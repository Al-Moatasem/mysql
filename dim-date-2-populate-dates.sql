use database_name;

drop procedure if exists usp_dim_date

delimiter //

CREATE PROCEDURE usp_dim_date( first_year int, last_year int)
begin
	declare start_date date;
    declare end_date date;
    declare i date;
    
    set start_date = str_to_date( concat(first_year,'-',1,'-',1), '%Y-%m-%d'); -- %Y = four digits 2019, 2020, %m = two digits
    set end_date = str_to_date( concat(last_year,'-',12,'-',31), '%Y-%m-%d');
    set i = start_date;
    
    while i <= end_date do
		insert into dim_date(
			`date` ,
			date_key , -- yyyymmdd 20190903
			`year` ,
			month_num,
			month_name , -- September
			month_name_short , -- Sep
			month_year , -- mmmm yyyy September 2019
			month_short_year , -- mmm yyyy Sep 2019
			year_month_num ,  -- yyyymm 201909
			quarter_num ,
			quarter_name , -- Q3
			quarter_year , -- Q3-2019
			quarter_year_short , -- Q3-19
			day_of_month , -- 1..31
			day_name , -- Tuesday
			day_name_short , -- Tue
			day_of_week , -- 1..7
			weekday_flag  -- weekday, weekend
        )
		
        select 
			-- a refrence for date/time specifier
            -- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html
            
			
            -- date » 2019-09-03
            i,
            -- date_key yyyymmdd 20190903
			year(i)*10000 + month(i) * 100 + day(i),
            -- `year` 2019
            year(i),
			-- month_num 09
            month(i),
			-- month_name capital M » September
            date_format(i, '%M'),
			-- month_name_short small b » Sep
			date_format(i, '%b'),
			-- month_year  capital Y four digits year » September 2019
			date_format(i, '%M %Y'),
			-- month_short_year » Sep 2019
			date_format(i, '%b %Y'),
			-- year_month_num » 201909
			year(i)*100 + month(i),
			-- quarter_num » 1..4,
			quarter(i),
			-- quarter_name , -- Q3
			concat( 'Q', quarter(i) ),
			-- quarter_year , -- Q3-2019
            concat( 'Q', quarter(i), '-', year(i) ),
			-- quarter_year_short  small y two digits year » Q3-19
            concat( 'Q', quarter(i), '-', date_format(i, '%y') ),
			-- day_of_month samll d » 1..31
            date_format(i, '%d'),
			-- day_name capital W » Tuesday
            date_format(i, '%W'),
			-- day_name_short samll a » Tue
            date_format(i, '%a'),
			-- day_of_week small w » 1..7
            date_format(i, '%w'),
			-- weekday_flag 0 = Sunday, .. 6 = Saturday »  weekday, weekend
            case 
				when date_format(i, '%w') = 5 or date_format(i, '%w') = 6 then 'weekend'
                else 'weekday'
            end
        ;
	
    
    set i = date_add( i, interval 1 day );
    
    end while;

end
;
//
delimiter ;

-- call usp_dim_date(2011,2020)