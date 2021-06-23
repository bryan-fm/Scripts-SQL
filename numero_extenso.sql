create or replace FUNCTION `numero_extenso`(`n` DECIMAL(10,2)) RETURNS varchar(150) CHARSET latin1
BEGIN
    declare ans varchar(150);
    declare dig1, dig2, dig3, dig4, dig5, dig6, dig7, dig8 int;

DECLARE num1,num2 varchar(150);
set ans = '';
IF n != '' THEN  

set num1 = SUBSTRING_INDEX(n, ".", 1);
set num2 = SUBSTRING_INDEX(n, '.', -1);

set dig8 = CAST(RIGHT(CAST(floor(num1 / 10000000) as CHAR(8)), 1) as SIGNED);
set dig7 = CAST(RIGHT(CAST(floor(num1 / 1000000) as CHAR(8)), 1) as SIGNED);
set dig6 = CAST(RIGHT(CAST(floor(num1 / 100000) as CHAR(8)), 1) as SIGNED);
set dig5 = CAST(RIGHT(CAST(floor(num1 / 10000) as CHAR(8)), 1) as SIGNED);
set dig4 = CAST(RIGHT(CAST(floor(num1 / 1000) as CHAR(8)), 1) as SIGNED);
set dig3 = CAST(RIGHT(CAST(floor(num1 / 100) as CHAR(8)), 1) as SIGNED);
set dig2 = CAST(RIGHT(CAST(floor(num1 / 10) as CHAR(8)), 1) as SIGNED);
set dig1 = CAST(RIGHT(floor(num1), 1) as SIGNED);

IF num1 != '' then

if dig8 > 0 then
    case
    	when dig8=1 and dig7 = 1 then set ans=concat(ans, ' Onze');
        when dig8=1 then set ans=concat(ans, ' Dez');
        when dig8=2 then set ans=concat(ans, ' Vinte');
        when dig8=3 then set ans=concat(ans, ' Trinta');
        when dig8=4 then set ans=concat(ans, ' Quarenta');
        when dig8=5 then set ans=concat(ans, ' Cinquenta');
        when dig8=6 then set ans=concat(ans, ' Sessenta');
        when dig8=7 then set ans=concat(ans, ' Setenta');
        when dig8=8 then set ans=concat(ans, ' Oitenta');
        when dig8=9 then set ans=concat(ans, ' Noventa');
        else set ans = ans;
    end case;
	if(dig7 = 0 or concat(dig8,dig7) = 11) then set ans = concat(ans, ' Milhões');
	end if;
end if;

if dig7 > 0 and concat(dig8,dig7) != 11 then
	if (dig8 > 0) then set ans = concat(ans,' e');
	end if;
    case
        when dig7=1 then set ans=concat(ans, ' Um');
        when dig7=2 then set ans=concat(ans, ' Dois');
        when dig7=3 then set ans=concat(ans, ' Três');
        when dig7=4 then set ans=concat(ans, ' Quatro');
        when dig7=5 then set ans=concat(ans, ' Cinco');
        when dig7=6 then set ans=concat(ans, ' Seis');
        when dig7=7 then set ans=concat(ans, ' Sete');
        when dig7=8 then set ans=concat(ans, ' Oito');
        when dig7=9 then set ans=concat(ans, ' Nove');
        else set ans = ans;
    end case;
	if(dig7 = 0 and dig8 = 1) then set ans = concat(ans, ' Milhão'); else set ans = concat(ans, ' Milhões');
	end if;
end if;

if dig6 > 0 then
	if ((dig7 > 0 or dig8 > 0) and concat(dig6,dig5,dig4) % 100 = 0) then set ans = concat(ans,' e');
	end if;
    case
    	when concat(dig6,dig5,dig4) % 100 > 0 and dig6 = 1 then set ans=concat(ans, ' Cento');
        when dig6=1 then set ans=concat(ans, ' Cem');
        when dig6=2 then set ans=concat(ans, ' Duzentos');
        when dig6=3 then set ans=concat(ans, ' Trezentos');
        when dig6=4 then set ans=concat(ans, ' Quatrocentos');
        when dig6=5 then set ans=concat(ans, ' Quinhetos');
        when dig6=6 then set ans=concat(ans, ' Seiscentos');
        when dig6=7 then set ans=concat(ans, ' Setecentos');
        when dig6=8 then set ans=concat(ans, ' Oitocentos');
        when dig6=9 then set ans=concat(ans, ' Novecentos');
        else set ans = ans;
    end case;
end if;

if dig5 = 1 then
	if (dig6 > 0) and dig5 != 1 then set ans = concat(ans,' e');
	end if;
    case
        when (dig5*10 + dig4) = 10 then set ans=concat(ans, ' Dez Mil');
        when (dig5*10 + dig4) = 11 then set ans=concat(ans, ' Onze Mil');
        when (dig5*10 + dig4) = 12 then set ans=concat(ans, ' Doze Mil');
        when (dig5*10 + dig4) = 13 then set ans=concat(ans, ' Treze Mil');
        when (dig5*10 + dig4) = 14 then set ans=concat(ans, ' Quatorze Mil');
        when (dig5*10 + dig4) = 15 then set ans=concat(ans, ' Quinze Mil');
        when (dig5*10 + dig4) = 16 then set ans=concat(ans, ' Dezesseis Mil');
        when (dig5*10 + dig4) = 17 then set ans=concat(ans, ' Dezessete Mil');
        when (dig5*10 + dig4) = 18 then set ans=concat(ans, ' Dezoito Mil');
        when (dig5*10 + dig4) = 19 then set ans=concat(ans, ' Dezenove Mil');
        else set ans=ans;
    end case;
else
    if dig5 > 0 then
    	if (dig6 > 0) and dig5 != 1 then set ans = concat(ans,' e');
    	end if;
        case
            when dig5=2 then set ans=concat(ans, ' Vinte');
            when dig5=3 then set ans=concat(ans, ' Trinta');
            when dig5=4 then set ans=concat(ans, ' Quarenta');
            when dig5=5 then set ans=concat(ans, ' Cinquenta');
            when dig5=6 then set ans=concat(ans, ' Sessenta');
            when dig5=7 then set ans=concat(ans, ' Setenta');
            when dig5=8 then set ans=concat(ans, ' Oitenta');
            when dig5=9 then set ans=concat(ans, ' Noventa');
            else set ans=ans;
        end case;
    end if;
    if dig4 > 0 then
    	if (dig5 > 0 or dig6 > 0) then set ans = concat(ans,' e');
    	end if;
        case
            when dig4=1 and (dig5 + dig6) > 0 then set ans=concat(ans, ' Um Mil');
            when dig4=1 and (dig5 + dig6) = 0 then set ans=concat(ans, ' Mil');
            when dig4=2 then set ans=concat(ans, ' Dois Mil');
            when dig4=3 then set ans=concat(ans, ' Três Mil');
            when dig4=4 then set ans=concat(ans, ' Quatro Mil');
            when dig4=5 then set ans=concat(ans, ' Cinco Mil');
            when dig4=6 then set ans=concat(ans, ' Seis Mil');
            when dig4=7 then set ans=concat(ans, ' Sete Mil');
            when dig4=8 then set ans=concat(ans, ' Oito Mil');
            when dig4=9 then set ans=concat(ans, ' Nove Mil');
            else set ans=ans;
        end case;
    end if;
    if dig4 = 0 AND (dig5 != 0 || dig6 != 0) then
        set ans=concat(ans, ' Mil');
    end if;
end if;

if dig3 > 0 THEN
	if (dig4 > 0 or dig5 > 0 or dig6 > 0 or dig7 > 0 or dig8 > 0) then set ans = concat(ans,' e');
    end if;
    case
    	when concat(dig3,dig2,dig1) % 100 > 0 and dig3=1 then set ans=concat(ans, ' Cento');
        when dig3=1 then set ans=concat(ans, ' Cem');
        when dig3=2 then set ans=concat(ans, ' Duzentos');
        when dig3=3 then set ans=concat(ans, ' Trezentos');
        when dig3=4 then set ans=concat(ans, ' Quatrocentos');
        when dig3=5 then set ans=concat(ans, ' Quinhentos');
        when dig3=6 then set ans=concat(ans, ' Seiscentos');
        when dig3=7 then set ans=concat(ans, ' Setecentos');
        when dig3=8 then set ans=concat(ans, ' Oitocentos');
        when dig3=9 then set ans=concat(ans, ' Novecentos');
        else set ans = ans;
    end case;
end if;

if dig2 = 1 then
	if (dig3 > 0 or dig4 > 0 or dig5 > 0 or dig6 > 0 or dig7 > 0 or dig8 > 0) then set ans = concat(ans,' e');
	end if;
    case
        when (dig2*10 + dig1) = 10 then set ans=concat(ans, ' Dez');
        when (dig2*10 + dig1) = 11 then set ans=concat(ans, ' Onze');
        when (dig2*10 + dig1) = 12 then set ans=concat(ans, ' Doze');
        when (dig2*10 + dig1) = 13 then set ans=concat(ans, ' Treze');
        when (dig2*10 + dig1) = 14 then set ans=concat(ans, ' Quatorze');
        when (dig2*10 + dig1) = 15 then set ans=concat(ans, ' Quinze');
        when (dig2*10 + dig1) = 16 then set ans=concat(ans, ' Dezesseis');
        when (dig2*10 + dig1) = 17 then set ans=concat(ans, ' Dezessete');
        when (dig2*10 + dig1) = 18 then set ans=concat(ans, ' Dezoito');
        when (dig2*10 + dig1) = 19 then set ans=concat(ans, ' Dezenove');
        else set ans=ans;
    end case;
else
    if dig2 > 0 then
    	if ((dig3 > 0 or dig4 > 0 or dig5 > 0 or dig6 > 0 or dig7 > 0 or dig8 > 0) and dig2 != 1) then set ans = concat(ans,' e');
    	end if;
        case
            when dig2=2 then set ans=concat(ans, ' Vinte');
            when dig2=3 then set ans=concat(ans, ' Trinta');
            when dig2=4 then set ans=concat(ans, ' Quarenta');
            when dig2=5 then set ans=concat(ans, ' Cinquenta');
            when dig2=6 then set ans=concat(ans, ' Sessenta');
            when dig2=7 then set ans=concat(ans, ' Setenta');
            when dig2=8 then set ans=concat(ans, ' Oitenta');
            when dig2=9 then set ans=concat(ans, ' Noventa');
            else set ans=ans;
        end case;
    end if;
    if dig1 >= 0 then
    	if (dig2 > 0 or dig3 > 0 or dig4 > 0 or dig5 > 0 or dig6 > 0 or dig7 > 0 or dig8 > 0) and dig1 > 0 then set ans = concat(ans,' e');
    	end if;
        case
            when dig1=1 then set ans=concat(ans, ' Um');
            when dig1=2 then set ans=concat(ans, ' Dois');
            when dig1=3 then set ans=concat(ans, ' Três');
            when dig1=4 then set ans=concat(ans, ' Quatro');
            when dig1=5 then set ans=concat(ans, ' Cinco');
            when dig1=6 then set ans=concat(ans, ' Seis');
            when dig1=7 then set ans=concat(ans, ' Sete');
            when dig1=8 then set ans=concat(ans, ' Oito');
            when dig1=9 then set ans=concat(ans, ' Nove');
            else set ans=ans;
        end case;
    end if;
end if;
set ans=concat(ans, ' Reais');
end if;
IF num2 > 0 then
    set dig2 = CAST(RIGHT(CAST(floor(num2 / 10) as CHAR(8)), 1) as SIGNED);
    set dig1 = CAST(RIGHT(floor(num2), 1) as SIGNED);
    set ans=concat(ans, ' e');
   
   if dig2 = 1 then
	    case
	        when concat(dig2,dig1) = 10 then set ans=concat(ans, ' Dez');
	        when concat(dig2,dig1) = 11 then set ans=concat(ans, ' Onze');
	        when concat(dig2,dig1) = 12 then set ans=concat(ans, ' Doze');
	        when concat(dig2,dig1) = 13 then set ans=concat(ans, ' Treze');
	        when concat(dig2,dig1) = 14 then set ans=concat(ans, ' Quatorze');
	        when concat(dig2,dig1) = 15 then set ans=concat(ans, ' Quinze');
	        when concat(dig2,dig1) = 16 then set ans=concat(ans, ' Dezesseis');
	        when concat(dig2,dig1) = 17 then set ans=concat(ans, ' Dezessete');
	        when concat(dig2,dig1) = 18 then set ans=concat(ans, ' Dezoito');
	        when concat(dig2,dig1) = 19 then set ans=concat(ans, ' Dezenove');
	        else set ans=ans;
	    end case;
	end if;

    if dig2 > 0 then
        case
            when dig2=2 then set ans=concat(ans, ' Vinte');
            when dig2=3 then set ans=concat(ans, ' Trinta');
            when dig2=4 then set ans=concat(ans, ' Quarenta');
            when dig2=5 then set ans=concat(ans, ' Cinquenta');
            when dig2=6 then set ans=concat(ans, ' Sessenta');
            when dig2=7 then set ans=concat(ans, ' Setenta');
            when dig2=8 then set ans=concat(ans, ' Oitenta');
            when dig2=9 then set ans=concat(ans, ' Noventa');
            else set ans=ans;
        end case;
    end if;
    if dig1 > 0 and dig2 < 1  then
        case
            when dig1=1 then set ans=concat(ans, ' Um');
            when dig1=2 then set ans=concat(ans, ' Dois');
            when dig1=3 then set ans=concat(ans, ' Três');
            when dig1=4 then set ans=concat(ans, ' Quatro');
            when dig1=5 then set ans=concat(ans, ' Cinco');
            when dig1=6 then set ans=concat(ans, ' Seis');
            when dig1=7 then set ans=concat(ans, ' Sete');
            when dig1=8 then set ans=concat(ans, ' Oito');
            when dig1=9 then set ans=concat(ans, ' Nove');
            else set ans=ans;
        end case;
    end if;
    if dig1 > 0 and dig2 > 1  then
        case
            when dig1=1 then set ans=concat(ans, ' e Um');
            when dig1=2 then set ans=concat(ans, ' e Dois');
            when dig1=3 then set ans=concat(ans, ' e Três');
            when dig1=4 then set ans=concat(ans, ' e Quatro');
            when dig1=5 then set ans=concat(ans, ' e Cinco');
            when dig1=6 then set ans=concat(ans, ' e Seis');
            when dig1=7 then set ans=concat(ans, ' e Sete');
            when dig1=8 then set ans=concat(ans, ' e Oito');
            when dig1=9 then set ans=concat(ans, ' e Nove');
            else set ans=ans;
        end case;
    end if;
           if(concat(dig2,dig1) = 1) then 
       	set ans=concat(ans, ' centavo ') ;
        else set ans=concat(ans, ' centavos ');
      end if;
   
END IF;
END IF;

return trim(ans);
END
