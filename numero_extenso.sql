create or replace FUNCTION `numero_extenso`(`n` DECIMAL(10,2)) RETURNS varchar(1000) CHARSET latin1
BEGIN
    declare ans varchar(1000);
    declare dig1, dig2, dig3, dig4, dig5, dig6, dig7, dig8 int;

DECLARE num1,num2 varchar(1000);
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
    	when dig8=1 and dig7 = 1 then set ans=concat(ans, ' onze');
        when dig8=1 then set ans=concat(ans, ' dez');
        when dig8=2 then set ans=concat(ans, ' vinte');
        when dig8=3 then set ans=concat(ans, ' trinta');
        when dig8=4 then set ans=concat(ans, ' quarenta');
        when dig8=5 then set ans=concat(ans, ' cinquenta');
        when dig8=6 then set ans=concat(ans, ' sessenta');
        when dig8=7 then set ans=concat(ans, ' setenta');
        when dig8=8 then set ans=concat(ans, ' oitenta');
        when dig8=9 then set ans=concat(ans, ' noventa');
        else set ans = ans;
    end case;
	if(dig7 = 0 or concat(dig8,dig7) = 11) then set ans = concat(ans, ' milhões');
	end if;
end if;

if dig7 > 0 and concat(dig8,dig7) != 11 then
	if (dig8 > 0) then set ans = concat(ans,' e');
	end if;
    case
        when dig7=1 then set ans=concat(ans, ' um');
        when dig7=2 then set ans=concat(ans, ' dois');
        when dig7=3 then set ans=concat(ans, ' três');
        when dig7=4 then set ans=concat(ans, ' quatro');
        when dig7=5 then set ans=concat(ans, ' cinco');
        when dig7=6 then set ans=concat(ans, ' seis');
        when dig7=7 then set ans=concat(ans, ' sete');
        when dig7=8 then set ans=concat(ans, ' oito');
        when dig7=9 then set ans=concat(ans, ' nove');
        else set ans = ans;
    end case;
	if(dig7 = 0 and dig8 = 1) then set ans = concat(ans, ' milhão'); else set ans = concat(ans, ' milhões');
	end if;
end if;

if dig6 > 0 then
	if ((dig7 > 0 or dig8 > 0) and concat(dig6,dig5,dig4) % 100 = 0) then set ans = concat(ans,' e');
	end if;
    case
    	when concat(dig6,dig5,dig4) % 100 > 0 and dig6 = 1 then set ans=concat(ans, ' Cento');
        when dig6=1 then set ans=concat(ans, ' cem');
        when dig6=2 then set ans=concat(ans, ' duzentos');
        when dig6=3 then set ans=concat(ans, ' trezentos');
        when dig6=4 then set ans=concat(ans, ' quatrocentos');
        when dig6=5 then set ans=concat(ans, ' quinhetos');
        when dig6=6 then set ans=concat(ans, ' seiscentos');
        when dig6=7 then set ans=concat(ans, ' setecentos');
        when dig6=8 then set ans=concat(ans, ' oitocentos');
        when dig6=9 then set ans=concat(ans, ' novecentos');
        else set ans = ans;
    end case;
end if;

if dig5 = 1 then
	if (dig6 > 0) and dig5 != 1 then set ans = concat(ans,' e');
	end if;
    case
        when (dig5*10 + dig4) = 10 then set ans=concat(ans, ' dez mil');
        when (dig5*10 + dig4) = 11 then set ans=concat(ans, ' onze mil');
        when (dig5*10 + dig4) = 12 then set ans=concat(ans, ' doze mil');
        when (dig5*10 + dig4) = 13 then set ans=concat(ans, ' treze mil');
        when (dig5*10 + dig4) = 14 then set ans=concat(ans, ' quatorze mil');
        when (dig5*10 + dig4) = 15 then set ans=concat(ans, ' quinze mil');
        when (dig5*10 + dig4) = 16 then set ans=concat(ans, ' dezesseis mil');
        when (dig5*10 + dig4) = 17 then set ans=concat(ans, ' dezessete mil');
        when (dig5*10 + dig4) = 18 then set ans=concat(ans, ' dezoito mil');
        when (dig5*10 + dig4) = 19 then set ans=concat(ans, ' dezenove mil');
        else set ans=ans;
    end case;
else
    if dig5 > 0 then
    	if (dig6 > 0) and dig5 != 1 then set ans = concat(ans,' e');
    	end if;
        case
            when dig5=2 then set ans=concat(ans, ' vinte');
            when dig5=3 then set ans=concat(ans, ' trinta');
            when dig5=4 then set ans=concat(ans, ' quarenta');
            when dig5=5 then set ans=concat(ans, ' cinquenta');
            when dig5=6 then set ans=concat(ans, ' sessenta');
            when dig5=7 then set ans=concat(ans, ' setenta');
            when dig5=8 then set ans=concat(ans, ' oitenta');
            when dig5=9 then set ans=concat(ans, ' noventa');
            else set ans=ans;
        end case;
    end if;
    if dig4 > 0 then
    	if (dig5 > 0 or dig6 > 0) then set ans = concat(ans,' e');
    	end if;
        case
            when dig4=1 and (dig5 + dig6) > 0 then set ans=concat(ans, ' um mil');
            when dig4=1 and (dig5 + dig6) = 0 then set ans=concat(ans, ' mil');
            when dig4=2 then set ans=concat(ans, ' dois mil');
            when dig4=3 then set ans=concat(ans, ' três mil');
            when dig4=4 then set ans=concat(ans, ' quatro mil');
            when dig4=5 then set ans=concat(ans, ' cinco mil');
            when dig4=6 then set ans=concat(ans, ' seis mil');
            when dig4=7 then set ans=concat(ans, ' sete mil');
            when dig4=8 then set ans=concat(ans, ' oito mil');
            when dig4=9 then set ans=concat(ans, ' nove mil');
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
        when dig3=1 then set ans=concat(ans, ' cem');
        when dig3=2 then set ans=concat(ans, ' duzentos');
        when dig3=3 then set ans=concat(ans, ' trezentos');
        when dig3=4 then set ans=concat(ans, ' quatrocentos');
        when dig3=5 then set ans=concat(ans, ' quinhentos');
        when dig3=6 then set ans=concat(ans, ' seiscentos');
        when dig3=7 then set ans=concat(ans, ' setecentos');
        when dig3=8 then set ans=concat(ans, ' oitocentos');
        when dig3=9 then set ans=concat(ans, ' novecentos');
        else set ans = ans;
    end case;
end if;

if dig2 = 1 then
	if (dig3 > 0 or dig4 > 0 or dig5 > 0 or dig6 > 0 or dig7 > 0 or dig8 > 0) then set ans = concat(ans,' e');
	end if;
    case
        when (dig2*10 + dig1) = 10 then set ans=concat(ans, ' dez');
        when (dig2*10 + dig1) = 11 then set ans=concat(ans, ' onze');
        when (dig2*10 + dig1) = 12 then set ans=concat(ans, ' doze');
        when (dig2*10 + dig1) = 13 then set ans=concat(ans, ' treze');
        when (dig2*10 + dig1) = 14 then set ans=concat(ans, ' quatorze');
        when (dig2*10 + dig1) = 15 then set ans=concat(ans, ' quinze');
        when (dig2*10 + dig1) = 16 then set ans=concat(ans, ' dezesseis');
        when (dig2*10 + dig1) = 17 then set ans=concat(ans, ' dezessete');
        when (dig2*10 + dig1) = 18 then set ans=concat(ans, ' dezoito');
        when (dig2*10 + dig1) = 19 then set ans=concat(ans, ' dezenove');
        else set ans=ans;
    end case;
else
    if dig2 > 0 then
    	if ((dig3 > 0 or dig4 > 0 or dig5 > 0 or dig6 > 0 or dig7 > 0 or dig8 > 0) and dig2 != 1) then set ans = concat(ans,' e');
    	end if;
        case
            when dig2=2 then set ans=concat(ans, ' vinte');
            when dig2=3 then set ans=concat(ans, ' trinta');
            when dig2=4 then set ans=concat(ans, ' quarenta');
            when dig2=5 then set ans=concat(ans, ' cinquenta');
            when dig2=6 then set ans=concat(ans, ' sessenta');
            when dig2=7 then set ans=concat(ans, ' setenta');
            when dig2=8 then set ans=concat(ans, ' oitenta');
            when dig2=9 then set ans=concat(ans, ' noventa');
            else set ans=ans;
        end case;
    end if;
    if dig1 >= 0 then
    	if (dig2 > 0 or dig3 > 0 or dig4 > 0 or dig5 > 0 or dig6 > 0 or dig7 > 0 or dig8 > 0) and dig1 > 0 then set ans = concat(ans,' e');
    	end if;
        case
            when dig1=1 then set ans=concat(ans, ' um');
            when dig1=2 then set ans=concat(ans, ' dois');
            when dig1=3 then set ans=concat(ans, ' três');
            when dig1=4 then set ans=concat(ans, ' quatro');
            when dig1=5 then set ans=concat(ans, ' cinco');
            when dig1=6 then set ans=concat(ans, ' seis');
            when dig1=7 then set ans=concat(ans, ' sete');
            when dig1=8 then set ans=concat(ans, ' oito');
            when dig1=9 then set ans=concat(ans, ' nove');
            else set ans=ans;
        end case;
    end if;
end if;
if((dig8 > 0 or dig7 > 0 or dig6 > 0 or dig5 > 0 or dig4 > 0 or dig3 > 0 or dig2 > 0) or dig1 > 1) then 
set ans=concat(ans, ' reais');
else if((dig8 > 0 or dig7 > 0 or dig6 > 0 or dig5 > 0 or dig4 > 0 or dig3 > 0 or dig2 > 0) = false and dig1 = 1) then 
set ans=concat(ans, ' real');
end if;
end if;
end if;
IF num2 > 0 then
    if(dig8 > 0 or dig7 > 0 or dig6 > 0 or dig5 > 0 or dig4 > 0 or dig3 > 0 or dig2 > 0 or dig1 > 0) then
    set ans=concat(ans, ' e');
    end if;
    set dig2 = CAST(RIGHT(CAST(floor(num2 / 10) as CHAR(8)), 1) as SIGNED);
    set dig1 = CAST(RIGHT(floor(num2), 1) as SIGNED);
   if dig2 = 1 then
	    case
	        when concat(dig2,dig1) = 10 then set ans=concat(ans, ' dez');
	        when concat(dig2,dig1) = 11 then set ans=concat(ans, ' onze');
	        when concat(dig2,dig1) = 12 then set ans=concat(ans, ' doze');
	        when concat(dig2,dig1) = 13 then set ans=concat(ans, ' treze');
	        when concat(dig2,dig1) = 14 then set ans=concat(ans, ' quatorze');
	        when concat(dig2,dig1) = 15 then set ans=concat(ans, ' quinze');
	        when concat(dig2,dig1) = 16 then set ans=concat(ans, ' dezesseis');
	        when concat(dig2,dig1) = 17 then set ans=concat(ans, ' dezessete');
	        when concat(dig2,dig1) = 18 then set ans=concat(ans, ' dezoito');
	        when concat(dig2,dig1) = 19 then set ans=concat(ans, ' dezenove');
	        else set ans=ans;
	    end case;
	end if;

    if dig2 > 0 then
        case
            when dig2=2 then set ans=concat(ans, ' vinte');
            when dig2=3 then set ans=concat(ans, ' trinta');
            when dig2=4 then set ans=concat(ans, ' quarenta');
            when dig2=5 then set ans=concat(ans, ' cinquenta');
            when dig2=6 then set ans=concat(ans, ' sessenta');
            when dig2=7 then set ans=concat(ans, ' setenta');
            when dig2=8 then set ans=concat(ans, ' oitenta');
            when dig2=9 then set ans=concat(ans, ' noventa');
            else set ans=ans;
        end case;
    end if;
    if dig1 > 0 and dig2 < 1  then
        case
            when dig1=1 then set ans=concat(ans, ' um');
            when dig1=2 then set ans=concat(ans, ' dois');
            when dig1=3 then set ans=concat(ans, ' três');
            when dig1=4 then set ans=concat(ans, ' quatro');
            when dig1=5 then set ans=concat(ans, ' cinco');
            when dig1=6 then set ans=concat(ans, ' seis');
            when dig1=7 then set ans=concat(ans, ' sete');
            when dig1=8 then set ans=concat(ans, ' oito');
            when dig1=9 then set ans=concat(ans, ' nove');
            else set ans=ans;
        end case;
    end if;
    if dig1 > 0 and dig2 > 1  then
        case
            when dig1=1 then set ans=concat(ans, ' e um');
            when dig1=2 then set ans=concat(ans, ' e dois');
            when dig1=3 then set ans=concat(ans, ' e três');
            when dig1=4 then set ans=concat(ans, ' e quatro');
            when dig1=5 then set ans=concat(ans, ' e cinco');
            when dig1=6 then set ans=concat(ans, ' e seis');
            when dig1=7 then set ans=concat(ans, ' e sete');
            when dig1=8 then set ans=concat(ans, ' e oito');
            when dig1=9 then set ans=concat(ans, ' e nove');
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
