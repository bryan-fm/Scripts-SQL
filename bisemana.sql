CREATE PROCEDURE createDatesTable(
IN year_param int)
begin

DECLARE first_year_day date;
DECLARE first_day date;
DECLARE row_num int;
DECLARE dates_on_year int;

SET first_year_day = MAKEDATE(2023,1);
SET first_day  = ADDDATE( first_year_day , MOD((9-DAYOFWEEK(first_year_day)),7));
set row_num = 1;
set dates_on_year = (select count(*) from bisemanas b where year(year_param) = year(first_day));

WHILE (row_num <= 26 and dates_on_year = 0) DO 
begin

INSERT INTO bisemanas( 
	inicio,
	fim
)VALUES( 
    first_day,
	DATE_ADD(first_day, INTERVAL 13 DAY)
);

SET first_day = DATE_ADD(first_day, INTERVAL 14 DAY);
SET row_num = row_num + 1;
END;
END WHILE;
END ;

call createDatesTable(2023);
