CREATE PROCEDURE createDatesTable(
IN start_date date)
BEGIN

DECLARE first_day date;
DECLARE row_num int;
DECLARE dates_on_year int;

SET first_day  = start_date;
set row_num = 1;
set dates_on_year = (select count(*) from bisemanas b where year(inicio) = year(first_day));

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

call createDatesTable('2023-01-02');