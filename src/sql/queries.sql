
# Выбрать и перечислить названия городов, где живут авторы.
select city from authors;

# Выбрать и перечислить имена и фамилии авторов, а также названия штатов и городов.
select au_fname, au_lname, city, state from authors;

# Выбрать и перечислить все столбцы таблицы authors.
select * from authors;

# Получить город, штат и страну каждого издателя.
select city, state, country from publishers;

#  Ключевое слово AS обозначает произвольный псевдоним любого столбца для отображения результатов.
select au_fname as 'First name', au_lname as 'Last name', city as City, state, zip as 'Postal code' from authors;

# Перечислить штаты, где живут авторы.
select state from authors;

# Перечислить различные штаты, в которых живут авторы, без дубликатов.
select distinct state from authors;

# Перечислить города и штаты, в которых живут авторы.
select city, state from authors;

# Перечислить различные пары (город, штат), чтобы адрес каждого автора, занесенного в нашу базу, содержал такую пару в качестве элемента.
select distinct city, state from authors;

# SELECT columns FROM table ORDER BY sort_column [ASC | DESC];

# Перечислить имена, фамилии, города и штаты проживания авторов,
# по алфавиту (этот порядок совпадает с порядком по умолчанию, что делает опцию ASC практически ненужной).
select au_fname, au_lname, city, state from authors order by au_lname asc;

# Перечислить имена, фамилии, города и штаты проживания авторов в обратном алфавитном порядке.
select au_fname, au_lname, city, state from authors order by au_fname desc;

# Перечислить имена, фамилии, города и штаты проживания авторов, по убыванию городов внутри восходящего порядка штатов.
select au_fname, au_lname, city, state from authors order by state asc, city desc;

# Перечислить имена, фамилии, города и штаты проживания авторов, так, чтобы результат
# был сначала отсортирован в восходящем (алфавитном) порядке по столбцу штата (столбец 4 в предложении SELECT),
# а потом в нисходящем (обратном алфавитном) порядке по столбцу фамилии (столбец 2 в предложении SELECT).
select au_fname, au_lname, city, state from authors order by 4 asc, 2 desc;

# Значения null, находящиеся в столбце, по которому проводится сортировка, будут перечислины или самыми первыми, или самыми последними.
select pub_id, state, country from publishers order by state asc;

# Столбец почтового индекса (zip) не входит в состав столбцов, которые надо выбрать.
select city, state from authors order by zip asc;

# Использовать в предложении order by не имена столбцов, а их псевдонимы.
select au_fname as 'First name', au_lname as 'Last name', state from authors order by state asc, 'Last name' asc, 'First name' asc;

# Выполнить сортировку по выражению.
select title_id, price, sales, price * sales as Revenue from titles order by Revenue desc;

# Фильтрация строк с помощью предложения WHERE

# SELECT columns FROM table WHERE test_column op value;

# Типы условий
# Сравнение =, <>, <, <=, >, >=
# Сопоставление с образцом LIKE
# Фильтрация диапазона BETWEEN
# Фильтрация списка IN
# Проверка на значение null IS NULL

# Получить список авторов, чтобы фамилия каждого из них отличалась от Hull.
select au_id, au_fname, au_lname from authors where au_lname <> 'Hull';

# Получить список названия из книг, для которых контракт не подписан.
select title_name, contract from titles where contract = 0;

# Получить названия книг, выпущенных не ранее 2001 года.
select title_name, pubdate from titles where pubdate >= date '2001-01-01';

# Получить названия книг, валовая прибыль от продажи которых составила более миллиона рублей.
select title_name, price * sales as Revenue from titles where price * sales > 1000000;

# Комбинорование условий с помощью операторов AND, OR и NOT

# Получить названия книг-биографий, которые продаются дешевле 20 руб. за каждую.
select title_name, type, price from titles where type = 'biography' and price < 20;

# Получить имена, фамилии и штаты проживания авторов, чьи фамилии начинаются с H-Z.
select au_fname, au_lname, state from authors where au_lname >= 'H' and au_lname <= 'Zz' and state <> 'CA';

# Получить имена, фамилии авторов, которые живут или в штате Нью-Йорк, или в штате Колорадо. или в городе Сан-Франциско.
select au_fname, au_lname, city, state from authors where (state = 'NY') or (state = 'CO') or (city = 'San Francisco');

# Получить идентификаторы, названия, штаты и страны тех издательств, которые находятся в штате Калифорния,
# или не находятся в штате Калифорния.
select pub_id, pub_name, state, country from publishers where (state = 'CA') or (state <> 'CA');

# Получить имена, фамилии авторов, которые не живут в Калифорнии.
select au_fname, au_lname, state from authors where not (state = 'CA');

# Получить названия книг, цена которых не ниже 20 руб. и объем продаж которых превышает 15 000 копий.
select title_name, sales, price from titles where not (price < 20) and (sales > 15000);
select title_name, sales, price from titles where price > 20 and sales > 15000;

# Получить книги историю, или биографию и цена которых ниже 20 руб.
# (Запрос работает не сработает, т.к. оператор AND выполнится раньше оператора OR)
select title_id, type, price from titles where type = 'history' or type = 'biography' and price < 20;
# (Выполняем оперетор OR раньше оператора AND)
select title_id, type, price from titles where (type = 'history' or type = 'biography') and price < 20;

# Сравнение по шаблону оператором LIKE

# SELECT columns FROM table WHERE test_column [NOT] LIKE 'pattern';

# Получить имена и фамилии авторов, чьи фамилии начинаются на Kel.
select au_fname, au_lname from authors where au_lname like 'Kel%';

# Получить имена и фамилии авторов, в фамилиях которых на местах 3-го и 4-го знаков есть буква 'l'.
select au_fname, au_lname from authors where au_lname like '__ll%';

# Получить имена и фамилии авторов, город, штат, код которые живут в районе залива Сан-Франциско (индекс начинается с цифр 94...).
select au_fname, au_lname, city, state, zip from authors where zip like '94___';

# Получить авторов, живущих за пределами территориальной области, которая соответствует телефонным кодам 212, 415 и 303.
select au_fname, au_lname, phone from authors where phone not like '212-___-____' and phone not like '415-___-%' and phone not like '303-%';

# Получить книги, которые содержат знак процентов в названии.
select title_name from titles where title_name like '%!%%' escape '!';

# Сравнение с диапазоном с помощью оператора BETWEEN

# SELECT columns FROM table WHERE test_column [NOT] BETWEEN low_value AND high_value;

# Получить авторов, у которых почтовый индекс не попадает в интервал от 20 000 до 89 999.
select au_fname, au_lname, zip from authors where zip not between 20000 and 89999;

# Получить названия книг, цена которых от 10 до 19,95 включительно.
select title_id, title_name, price from titles where price between 10 and 19.95;

# Получить названия книг, которые вышли из печати в 2000 году.
select title_id, title_name, pubdate from titles where pubdate between date '2000-01-01' and date '2000-12-31';

# Получить названия книг, цена которых от 10 до 19,95.
select title_id, title_name, pubdate from titles where (price > 10) and (price < 19.95);

# Фильтрация с помощью оператора IN

# SELECT columns FROM table WHERE test_column [NOT] IN (value1, value2, …);

# Получить авторов, которые живут не в штате Нью-Йорк не в штате Нью-Джерси, не в штате Калифорния.
select au_fname, au_lname, state from authors where state not in ('NY', 'NJ', 'CA');

# Получить названия книг, за которые аванс, выплаченный автору каждой книги, составил или 0, или 1000, или 5000 руб.
select title_id, advance from royalties where advance in (0.00, 1000.00, 5000.00);

# Получить названия (точнее, однозначные идентификаторы и даты публикации) книг, опубликованных 1 января 2000, 2001 и 2002 годов.
select title_id, pubdate from titles where pubdate in (date '2000-01-01', date '2001-01-01', date '2002-01-01');

# Проверка на значение NULL с помощью оператора IS [ NOT ] NULL

# Получить места нахождения всех издателей.
select pub_id, city, state, country from publishers;

# Получить идентификаторы и адреса издателей, которые находятся в штате Калифорния.
select pub_id, city, state, country from publishers where state = 'CA';

# Перечислить всех издателей, которые находятся вне штата Калифорния.
select pub_id, city, state, country from publishers where state <> 'CA' or state is null;

# Выбрать книги-биографии, даты публикации (прошлые и будущие) которых известны.
select title_id, type, pubdate from titles where type = 'biography' and pubdate is not null;

# Создание производных столбцов

# Здесь представлено одно выражение с константами в предложении SELECT.
select 2 + 3;

# Получить один столбец и одно выражение с константами.
select au_id, 2 + 3 from authors;

# Получить идентификаторы книг вместе с ценами, сниженными на 10%.
select title_id, price, 0.10 as Discount, price * (1 - 0.10) as 'New price' from titles;

# Арифметические операции

# -expr - Инвертирует знак числового выражения
# +expr - Оставляет знак числового выражения без изменения
# expr1 + expr2 - Суммирует два числовых выражения
# expr1 - expr2 - Вычитает из одного числового выражения другое числовое выражение
# expr1 * expr2 - Перемножает два числовых выражения
# expr1 / expr2 - Делит одно числовое выражение на другое числовое выражение

# Изменить знак числа с помощью оператора отрицания.
select title_id, -advance as Advance from royalties;

# Получить идентификаторы книг, которые являются биографиями, в порядке убывания дохода от продаж
# (доход от продажи есть число проданных копий, умноженное на цену одной копии).
select title_id, price * sales as Revenue from titles where type = 'biography' order by price * sales desc;

# Получить станицы книг делением столбца pages.
select title_id, pages / 10 as 'pages/10', pages / 10.0 as 'pages/10.0' from titles;

# Применение круглых скобок для переопределения правила ассоциативности.
select 2 + 3 * 4 as '2+3*4', (2 + 3) * 4 as '(2+3)*4', 6 / 2 * 3 as '6/2*3', 6 / (2 * 3) as '6/(2*3';

# Объединение строк с помощью оператора || (CONCAT)

# Получить имена и фамилии авторов, объедененные в один производный столбец, отсортировать в алфавитном порядке.
select concat(au_fname, ' ', au_lname) as 'Author name' from authors order by au_lname asc, au_fname asc;

# Получить в проядке убывания объемы продаж (количество когда-либо проданных копий) книг-биографий.
select concat(cast(sales as char(7)), ' проданные экземпляры книг ', title_id) as 'Biography sales' from titles where type = 'biography' and sales is not null order by sales desc;

# Получить в проядке убывания даты публикации книг.
select concat('Title ', title_id, ' published on ', cast(pubdate as char(10))) as 'Biography publication dates' from titles where type = 'biography' and pubdate is not null order by pubdate desc;

# Получить всех авторов, чье полное имя Klee Hull.
select au_id, au_fname, au_lname from authors where concat(au_fname, ' ', au_lname) = 'Klee Hull';

# Выбор произвольной подстроки с помощью функции SUBSTRING

# Разбить идентификаторы издателей, на буквенную и цифровую составляющие.
select pub_id, substring(pub_id from 1 for 1) as 'Alpha part', substring(pub_id from 2) as 'Num part' from publishers;

# Получить первую букву (инициал) имени, точку, пробел и фамилию всех авторов, живущих в штате Нью-Йорк, или штате Колорадо.
select concat(substring(au_fname from 1 for 1), '. ', au_lname) as 'Author name', state from authors where state in ('NY', 'CO');

# Получить имена и фамилии авторов, у которых телефонный номер начинается на 415.
select au_fname, au_lname, phone from authors where substring(phone from 1 for 3) = 415;

# Получить имена авторов, в нижнем регистре, а их фамилии в верхнем регистре.
select lower(au_fname) as Lower, upper(au_lname) as Upper from authors;

# Получить названия книг, которые содержат сочетание (латинских) букв "MO", не зависимо от регистра.
select title_name from titles where upper(title_name) like '%MO%';

# Удалить головные и хвостовые пробелы у строки ' AAA '.
select concat('<', ' AAA ', '>') as 'Untrimmed', concat('<', trim(leading from ' AAA '), '>') as 'Leading', concat('<', trim(trailing from ' AAA '), '>') as 'Trailing', concat('<', trim(' AAA '), '>') as 'Both';

# Удалить первую заглавную букву 'H' в тех фамилиях авторов, которые начинаются с нее.
select au_lname, trim(leading 'H' from au_fname) as 'Trimmed name' from authors;

# Игнорируя головные и хвотовые пробелы, перечислить трехзначные идентификаторы названий книг, которые начинаются с сочетания T1.
select title_id from titles where trim(title_id) like 'T1_';

# Получить длину имен авторов.
select au_fname, character_length(au_fname) as 'Len' from authors;

# Перечислить в порядке возрастания длины (восходящий порядок) названия книг, которые содержат менее 30 символов.
select title_name, character_length(title_name) as 'Len' from titles where character_length(title_name) < 30 order by character_length(title_name) asc;

# Получить позицию подстроки 'e' в строке, являющейся именем автора, и позицию подстроки 'ma' в строке, ясляющейся фамилией автора.
select au_fname, position('e' in au_fname) as 'Position e', au_lname, position('ma' in au_lname) as 'Position ma' from authors;

# Получить названия книг, которые содержат не более 10 символов, считая слева на право, и латинскую строчную букву 'u'.
select title_name, position('u' in title_name) as 'Position u' from titles where position('u' in title_name) between 1 and 10 order by position('u' in title_name) desc;

# Операции с данными даты и времени

# Получить идентификаторы и даты публикации книг, которые были напечатаны или в первой половине 2002 года, или в первой половине 2001 года.
select title_id, pubdate from titles where extract(year from pubdate) between 2001 and 2002 and extract(month from pubdate) between 1 and 6 order by pubdate desc;

# CURRENT_DATE – чтобы вывести дату;
# CURRENT_TIME – чтобы вывести время;
# CURRENT_TIMESTAMP – чтобы вывести от метку времени.

# Получить текущие дату, время, отметку времени.
select current_date as 'Date', current_time as 'Time', current_timestamp as 'Timestamp';

# Получить книги, дата публикации которых или неизвестна совсем, или попадает в интервал 90 дней, считая от текущей даты.
select title_id, pubdate from titles where pubdate between current_timestamp - interval 90 day and current_timestamp + interval 90 day or pubdate is null order by pubdate desc;

# Получить имя текущиего пользователя.
select current_user as 'User';

# Преобразование типов данных, функция CAST()

# Преобразовать цены книг, из типа decimal в типы данных integer и char(8).
# В MySQL не используется тип INT или INTEGER для преобразования — нужно указывать SIGNED или UNSIGNED.
select price as 'price(decimal)', cast(price as signed) as 'price(integer)', concat('<', cast(price as char(8)), '>') as 'price(char(8)' from titles;

select cast("11:35:00" as year), cast(time "11:35:00" as year);
select cast(1944.35 as year), cast(1944.50 as year);
select cast(66.35 as year), cast(66.50 as year);
select cast("1979aaa" as year);

# Перечислить в порядке убывания (нисходящий порядок) общие объемы продаж вместе с некоторыми частями названий заданной длины тех книг,
# темой которых является или история или биография.
select concat(cast(sales as char(8)), ' copies sold of ', cast(title_name as char(20)), ' History and biography sales') from titles where sales is not null and type in ('history', 'biography') order by sales desc;

# Вычисление условных выражений с помощью выражения CASE

# CASE comparison_value
# WHEN value1 THEN result1
# WHEN value2 THEN result2
# …
# WHEN valueN THEN resultN
# [ELSE default_result]
# END

# Перечислить в алфавитном порядке (восходящий порядок) идентификаторы и темы книг, вместе с текущими и новыми ценами
# при том условии, что новая цена исторических книг должна быть больше текущей цены этих книг на 10%,
# новая цена книг по психологии должна быть больше текущей цены на 20%, а новая цена любой книги по другой теме
# должна быть равна текущей цене.
select title_id, type, price, case type when 'history' then price * 1.10 when 'psychology' then price * 1.20 else price end as 'New price' from titles order by type asc, title_id desc;

# Получить в порядке возрастания объемов продаж идентификаторы книг, с разбивкой по категориям объемов продаж.
select title_id,
       case
        when sales is null then 'Unknown'
        when sales <= 1000 then 'Not more than 1,000'
        when sales <= 10000 then 'Between 1,001 and 10,000'
        when sales <= 100000 then 'Between 10,001 and 100,000'
        when sales <= 1000000 then 'Between 100,001 and 1,000,000'
        else 'Over 1,000,000'
        end
        as 'Sales category'
from titles order by sales asc;

# Получить идентификаторы и места нахождения издателей, при наличии у какого-нибудь издателя в столбце state (штат) значения null стояло N/A.
select pub_id, city, coalesce(state, 'N/A') as state, country from publishers;

# Поменять нули на значения null.
select title_id, contract, nullif(contract, 0) as 'Null contract' from titles;

# Суммирование и группировка данных

# Агрегатные функции

# MIN(expr) - Минимальное значение в expr
# MAX(expr) - Максимальное значение в expr
# SUM(expr) - Сумма всех значений в expr
# AVG(expr) - Среднее всех значений в expr
# COUNT(expr) - Число всех значений, не являющихся значениями null, в expr
# COUNT(*) - Число строк в произвольной таблице или произвольном наборе строк

# Запросы с применением функции MIN()
select min(price) as 'Min price' from titles;
select min(pubdate) as 'Earliest pubdate' from titles;
select min(pages) as 'Min history pages' from titles where type = 'history';

# Запросы с применением функции MAX()
select max(au_lname) as 'Max last name' from authors;
select min(price) as 'Min price', max(price) as 'Max price', max(price) - min(price) as 'Range' from titles;
select max(price * sales) as 'Max history revenue' from titles where type = 'history';

# Запросы с применением функции SUM()
select sum(advance) as 'Total advances' from royalties;
select sum(sales) as 'Total sales (2000 books)' from titles where pubdate between date '2000-01-01' and date '2000-12-31';
select sum(price) as 'Total price',sum(sales) as 'Total sales', sum(price * sales) as 'Total revenue' from titles;

# Запросы с применением функции AVG()
select avg(price * 2) as 'AVG(price*2)' from titles;
select avg(sales) as 'AVG(sales)', sum(sales) as 'SUM(sales)' from titles where type = 'business';
select title_id, sales from titles where sales > (select avg(sales) from titles) order by sales desc;

# Запросы с применением функции COUNT()
select count(title_id) as 'count(title_id)', count(price) as 'count(price)', count(*) as 'count(*)' from titles;
select count(title_id) as 'count(title_id)', count(price) as 'count(price)', count(*) as 'count(*)' from titles where price is not null;
select count(title_id) as 'count(title_id)', count(price) as 'count(price)', count(*) as 'count(*)' from titles where price is null;

# Агрегатные запросы с применением предложения DISTINCT.
select count(*) as 'count(*)', count(price) as 'count(price)', sum(price) as 'sum(price)', avg(price) as 'avg(price)' from titles;
select count(distinct price) as 'count(distinct price)', sum(distinct price) as 'sum(distinct price)', avg(distinct price) as 'avg(distinct price)' from titles;
select count(au_id) as 'count(au_id)' from title_authors;
select distinct count(au_id) as 'distinct count(au_id)' from title_authors;
select count(distinct au_id) as 'count(distinct au_id)' from title_authors;

# Примеры запросов со смешанным применением агрегатов, обработанных и не обработанных предложением DISTINCT в одном и том же предложении SELECT.
select count(price) as 'count(price)', sum(price) as 'sum(price)' from titles;
select count(price) as 'count(price)', sum(distinct price) as 'sum(distinct price)' from titles;
select count(distinct price) as 'count(distinct price)', sum(price) as 'sum(price)' from titles;
select count(distinct price) as 'count(distinct price)', sum(distinct price) as 'sum(distinct price)' from titles;

# Группировка строк предложением GROUP BY

# Порядок группировки строк
# SELECT columns
# FROM table
# [WHERE search_condition]
# GROUP BY grouping_columns
# [HAVING search_condition]
# [ORDER BY sort_columns];

# Получить идентификаторы авторов, и на против каждого идентификатора указать то количество книг, которое он написал в том числе и в соавторстве.
select au_id, count(*) as num_books from title_authors group by au_id;

# Этот запрос демонстрирует разницу между агрегатными функциями
# COUNT(expr) и COUNT(*) в одном и том же предложении SELECT, включающем предложение GROUP BY.
select state, count(state) as 'count(state)', count(*) as 'count(*)' from publishers group by state;

# Для получения математически достоверных результатов следует применять не функцию COUNT(*),а функцию COUNT(expr).
# В противном случае ошибка неизбежна, когда expr содержит значения null.
select
    type,
    sum(sales) as 'sum(sales)',
    count(sales) as 'count(sales)',
    count(*) as 'count(*)',
    sum(sales) / count(sales) as 'sum/count(sales)',
    sum(sales) / count(*) as 'sum(sales)/count(*)',
    avg(sales) as 'avg(sales)'
from titles group by type;

# Получить итоговые статистические показатели для каждого типа книг.
select type, sum(sales) as 'sum(sales)', avg(sales) as 'avg(sales)', count(sales) as 'count(sales)' from titles group by type;

# Получить итоговые статистические показатели для каждого типа книг, не учитывать книги дешевле 13 руб.
# и упорядочить результат по уменьшению объема продаж.
select type, sum(sales) as 'sum(sales)', avg(sales) as 'avg(sales)', count(sales) as 'count(sales)' from titles where price >= 13 group by type order by 'sum(sales)' desc;

# Получить книги каждого типа с разбивкой по издателям в убывающем порядке внутри возрастающего порядка идентификаторов издателей.
select pub_id, type, count(*) as 'count(*)' from titles group by pub_id, type order by pub_id asc, 'count(*)' desc;

# Оба запроса дают один и тот же результат.
select type from titles group by type;
select distinct type from titles;

# Получить книги в каждой категории объемов продаж в порядке их уменьшения.
select
    case
        when sales is null
            then 'unknown'
        when sales <= 1000
            then 'not more than 1,000'
        when sales <= 10000
            then 'between 1,001 and 10,000'
        when sales <= 100000
            then 'between 10,001 and 100,000'
        when sales <= 1000000
            then 'between 100,001 and 1,000,000'
        else 'over 1,000,000'
        end
             as "sales category",
    count(*) as "num titles"
from titles
group by
    case
        when sales is null
            then 'unknown'
        when sales <= 1000
            then 'not more than 1,000'
        when sales <= 10000
            then 'between 1,001 and 10,000'
        when sales <= 100000
            then 'between 10,001 and 100,000'
        when sales <= 1000000
            then 'between 100,001 and 1,000,000'
        else 'over 1,000,000'
        end
order by min(sales) asc;

# Получить средние продажи с разбивкой по цене в порядке ее уменьшения.
select price, avg(sales) as 'avg(sales)' from titles where price is not null group by price order by price asc;

# Фильтрация групп предложением HAVING

# Сначала GROUP BY объединяет строки в группы по общему признаку, а потом HAVING отбирает только те из них, которые подходят под условие.

# Синтаксис запроса выглядит примерно так:

# SELECT столбцы
# FROM таблица
# WHERE условие_для_строк
# GROUP BY столбцы_группировки
# HAVING условие_для_групп
# ORDER BY итоговые_столбцы;

# В условии HAVING чаще всего используют агрегатные функции — COUNT(), SUM(), AVG(), MIN() и MAX().

# Важно запомнить следующее:
# WHERE работает до группировки;
# HAVING работает после группировки.

# Перечислить авторов, написавших в том числе и в соавторстве, не менее трех книг.
select au_id, count(*) as num_books from title_authors group by au_id having count(*) >= 3;

# Получить книги, средний выловой доход по которым превышает 1 миллион, и средний валовой доход с разбивкой по их типам.
select type, count(price) as 'count(price)', avg(price * sales) as 'avg revenue' from titles group by type having avg(price * sales) > 1000000;

# Перечислить с разбивкой по издателям (первый уровень) и типам книг (второй уровень) опубликованные книги, учитываемые в нашей типовой базе данных.
select pub_id, type, count(*) as 'count(*)' from titles group by pub_id, type having count(*) > 1 order by pub_id asc, 'count(*)' desc;

# Перечислить для издателей P03 и P04 общий объем продаж выпущенных книг с разбивкой по типам. Учесть итоговый объем продаж
# которых превышает 10 000 копий при средней цене одной копии менее 20 руб.
select type, sum(sales) as 'sum(sales)', avg(price) as 'avg(price)' from titles where pub_id in ('P03', 'P04') group by type having sum(sales) > 10000 and avg(price) < 20;

# Выбор данных из нескольких таблиц

# Внутреннее объединение INNER JOIN
# Левое внешнее объединение LEFT OUTER JOIN
# Правое внешнее объединение RIGHT OUTER JOIN
# Полное внешнее объединение FULL OUTER JOIN
# Естественное объединение NATURAL JOIN
# Полное или перекрестноеобъединение CROSS JOIN
# Тривиальное объединение, самообъединение SELF JOIN

# INNER JOIN возвращает только строки, у которых есть совпадение по заданному условию.
# LEFT JOIN (LEFT OUTER JOIN) возвращает все строки из левой таблицы и соответствующие строки из правой таблицы. Если нет совпадения, результат содержит NULL для столбцов правой таблицы.
# RIGHT JOIN (RIGHT OUTER JOIN) возвращает все строки из правой таблицы и соответствующие строки из левой таблицы. Если нет совпадения, результат содержит NULL для столбцов левой таблицы.
# FULL JOIN (FULL OUTER JOIN) возвращает все строки из обеих таблиц. Там, где есть совпадения, данные объединяются, а где связи нет — незаполненные поля заменяются NULL.

# CROSS JOIN. Связь, при которой каждая запись из первой таблицы комбинируется с каждой записью из второй. Это называется декартовым произведением.
# SELF JOIN. Таблица соединяется сама с собой. Это нужно, когда строки в ней связаны друг с другом.

# Операции по обработке наборов строк  INTERSECT EXCEPT

# UNION Все строки результатов обоих запросов. Дубликаты удалены.
# INTERSECT Все строки, являющиеся общими как для результата первого запроса, так и для результата второго запроса. Дубликаты удалены.
# EXCEPT Все строки результата первого запроса без тех строк результата первого запроса, которые одновременно являются строками результата второго запроса. Дубликаты удалены.

# Создание произвольного объединения с использованием синтаксиса JOIN

# SELECT columns
# FROM table1 join_type table2
# ON join_conditions
# [WHERE search_condition]
# [GROUP BY grouping_conditions]
# [HAVING search_condition]
# [ORDER BY sort_columns];

# Создание произвольного объединения с использованием синтаксиса WHERE

# SELECT columns
# FROM table1, table2
# WHERE join_conditions
# [GROUP BY grouping_conditions]
# [HAVING search_condition]
# [ORDER BY sort_columns];

# Запрос, который применяет синтаксис JOIN
select au_fname, au_lname, a.city from authors a inner join publishers p on a.city = p.city;

# Запрос, который применяет синтаксис WHERE
select au_fname, au_lname, a.city from authors a, publishers p where a.city = p.city;

# Последовательность исполнения запроса

# Применить условия объединения, заданные предложением JOIN.
# Применить условия объединения и поиска, заданные предложением WHERE.
# Сгруппировать строки в соответствии с предложением GROUP BY.
# Применить к группам условия поиска, заданные предложением HAVING.
# Отсортировать результат в соответствии с предложением ORDER BY.

# Предложение USING

# JOIN допускает, чтобы вместо предложения ON применялось предложение USING, но только в том случае, когда все связывающие столбцы имеют попарно одинаковые имена.

# FROM table1 joint_type table2 USING (columns)
select au_fname, au_lname, a.city from authors a inner join publishers p using(city);

# Создание произвольного перекрестного объединения CROSS JOIN

# SELECT columns FROM table1 CROSS JOIN table2
select * from authors cross join publishers;

# Создать одно перекрестное объединение и распечатать все возможные комбинации строк двух таблиц.
select au_id, pub_id, a.state as 'au_state', p.state as 'pub_state' from authors a cross join publishers p;

# Создание произвольного естественного объединения NATURAL JOIN

# SELECT columns FROM table1 NATURAL JOIN table2

# Получить перечень книг, и издателей этих книг так, чтобы рядом с идентификатором книги были показаны в одной строке наименование издателя.
select t.title_id, t.pub_id, p.pub_name from publishers p natural join titles t;

# Получить идентификаторы для книг, авторы которых получили аванс меньше 20 000, в сочетании с идентификаторами издателя, напечатавшего каждую книгу.
select t.title_id, t.pub_id, p.pub_name, r.advance from publishers p natural join titles t natural join royalties r where r.advance < 20000;

select t.title_id, t.pub_id, p.pub_name, r.advance from publishers p inner join titles t on p.pub_id = t.pub_id inner join royalties r on t.title_id = r.title_id where r.advance < 20000;

# Создание внутреннего объединения INNER JOIN

# Считывает результат, который включает только объединенные строки, соответствующие условиям объединения.
# SELECT columns FROM table1 INNER JOIN table2 ON join_conditions

# Получить список книг, которые написали все авторы (в том числе и в соавторстве).
select a.au_id, a.au_fname, a.au_lname, ta.title_id from authors a inner join title_authors ta on a.au_id = ta.au_id order by a.au_id asc, ta.title_id asc;

select a.au_id, a.au_fname, a.au_lname, ta.title_id from authors a, title_authors ta where a.au_id = ta.au_id order by a.au_id asc, ta.title_id asc;

# Получить информацию о каждой книге, а также информацию обо всех книгах других издательств.
select t.title_id, t.title_name, t.pub_id, p.pub_name from titles t inner join publishers p on p.pub_id = t.pub_id order by t.title_name asc;

select t.title_id, t.title_name, t.pub_id, p.pub_name from titles t inner join publishers p on p.pub_id = t.pub_id order by t.title_name asc;

# Получить список авторов, которые живут во всех городах, где расположены издательства.
select a.au_id, a.au_fname, a.au_lname, a.city, a.state from authors a inner join publishers p on a.city = p.city and a.state = p.state order by a.au_id asc;

select a.au_id, a.au_fname, a.au_lname, a.city, a.state from authors a, publishers p where a.city = p.city and a.state = p.state order by a.au_id asc;

select a.au_id, a.au_fname, a.au_lname, a.city, a.state from authors a natural join publishers p order by a.au_id asc;

# Получить список книг, опубликованных в штате Калифорния или вне крупных стран Северной Америки.
select t.title_id, t.title_name, p.state, p.country from titles t inner join publishers p on t.pub_id = p.pub_id where p.state = 'CA' or p.country not in ('USA', 'Canada', 'Mexico') order by t.title_id asc;

select t.title_id, t.title_name, p.state, p.country from titles t, publishers p where t.pub_id = p.pub_id and (p.state = 'CA' or p.country not in('USA', 'Canada', 'Mexico')) order by t.title_id asc;

# Получить список книг, написанных всеми авторами (в том числе в соавторстве).
select a.au_id, count(ta.title_id) as 'Num books' from authors a inner join title_authors ta on a.au_id = ta.au_id group by a.au_id order by a.au_id asc;

select a.au_id, count(ta.title_id) as 'Num books' from authors a, title_authors ta where a.au_id = ta.au_id group by a.au_id order by a.au_id asc;

# Получить авансы выплаченные за книги-биографии.
select t.title_id, t.title_name, r.advance from royalties r inner join titles t on r.title_id = t.title_id where t.type = 'biography' and r.advance is not null order by r.advance desc;

select t.title_id, t.title_name, r.advance from royalties r, titles t where r.title_id = t.title_id and t.type = 'biography' and r.advance is not null order by r.advance desc;

# Получить счет и аванс, выплаченный за каждый тип книг.
select t.type, count(r.advance) as 'count(r.advance)', sum(r.advance) as 'sum(r.advance)' from royalties r inner join titles t on r.title_id = t.title_id where r.advance is not null group by t.type order by t.type asc;

select t.type, count(r.advance) as 'count(r.advance)', sum(r.advance) as 'sum(r.advance' from royalties r, titles t where r.title_id = t.title_id and r.advance is not null group by t.type order by t.type desc;

# Получить количество выплаченных авансов и их общей суммы за каждый тип книг с разбивкой по издетельствам.
select t.type, t.pub_id, count(r.advance) as 'count(r.advance)', sum(r.advance) as 'sum(r.advance)' from royalties r inner join titles t on r.title_id = t.title_id where r.advance is not null group by t.type, t.pub_id order by t.type asc, t.pub_id asc;

select t.type, t.pub_id, count(r.advance) as 'count(r.advance)', sum(r.advance) as 'sum(r.advance)' from royalties r, titles t where r.title_id = t.title_id and r.advance is not null group by t.type, t.pub_id order by t.type asc, t.pub_id asc;

# Получить список соавторов для всех книг, у которых они есть.
select ta.title_id, count(ta.au_id) as 'Num authors' from authors a inner join title_authors ta on a.au_id = ta.au_id group by ta.title_id having count(ta.au_id) > 1 order by ta.title_id asc;

select ta.title_id, count(ta.au_id) as 'Num authors' from authors a, title_authors ta where a.au_id = ta.au_id group by ta.title_id having count(ta.au_id) > 1 order by ta.title_id asc;

# Получить все книги, прибыль от которых (=цена х продажи) превышает сумму аванса, уплаченного автору, не меньше чем в 10 раз.
select t.title_id, t.title_name, r.advance, t.price * t.sales as Revenue from titles t inner join royalties r on t.price * t.sales > r.advance * 10 and t.title_id = r.title_id order by t.price * t.sales desc;

select t.title_id, t.title_name, r.advance, t.price * t.sales as Revenue from titles t, royalties r where t.price * t.sales > r.advance * 10 and t.title_id = r.title_id order by t.price * t.sales desc;

# Получить список авторов и названий книг, которые написали все авторы.
select a.au_fname, a.au_lname, t.title_name from authors a inner join title_authors ta on a.au_id = ta.au_id inner join titles t on t.title_id = ta.title_id order by a.au_lname asc, a.au_fname asc, t.title_name asc;

select a.au_fname, a.au_lname, t.title_name from authors a, title_authors ta, titles t where a.au_id = ta.au_id and t.title_id = ta.title_id order by a.au_lname asc, a.au_fname asc, t.title_name asc;

# Получить имена авторов, названия всех книг, а также названия издательств.
select a.au_fname, a.au_lname, t.title_name, p.pub_name from authors a inner join title_authors ta on a.au_id = ta.au_id inner join titles t on t.title_id = ta.title_id inner join publishers p on p.pub_id = t.pub_id order by a.au_lname asc, a.au_fname asc, t.title_name asc;

select a.au_fname, a.au_lname, t.title_name, p.pub_name from authors a, title_authors ta, titles t, publishers p where a.au_id = ta.au_id and t.title_id = ta.title_id and p.pub_id = t.pub_id order by a.au_lname asc, a.au_fname asc, t.title_name asc;

# Получить все гонорары за все книги.
select
    sum(t.sales * t.price * r.royalty_rate) as 'Total royalties',
    sum(r.advance) as 'Total advances',
    sum((t.sales * t.price * r.royalty_rate) - r.advance) as 'Total due to authors'
from titles t
inner join royalties r
on r.title_id = t.title_id
where t.sales is not null;

select
    sum(t.sales * t.price * r.royalty_rate) as 'Total royalties',
    sum(r.advance) as 'Total advances',
    sum((t.sales * t.price * r.royalty_rate) - r.advance) as 'Total due to authors'
from titles t, royalties r
where t.title_id = r.title_id
  and t.sales is not null;

# Расчитать все гонорар, полученный каждым автором за все книги, которые он написал.
select
    ta.au_id,
    t.title_id,
    t.pub_id,
    t.sales * t.price * r.royalty_rate * ta.royalty_share as 'Royalty share',
    r.advance * ta.royalty_share as 'Advance share',
    (t.sales * t.price * r.royalty_rate * ta.royalty_share) - (r.advance * ta.royalty_share) as 'Due to author'
from title_authors ta
inner join titles t
    on t.title_id = ta.title_id
inner join royalties r
    on r.title_id = t.title_id
where t.sales is not null
order by ta.au_id asc, t.title_id asc;

select
    ta.au_id,
    t.title_id,
    t.pub_id,
    t.sales * t.price * r.royalty_rate * ta.royalty_share as 'Royalty share',
    r.advance * ta.royalty_share as 'Advance share',
    (t.sales * t.price * r.royalty_rate * ta.royalty_share) - (r.advance * ta.royalty_share) as 'Due to author'
from title_authors ta, titles t, royalties r
where t.title_id = ta.title_id and r.title_id = t.title_id and t.sales is not null
order by ta.au_id asc, t.title_id asc;

# Получить только те гонорары за книги, которые больше нуля.
select
    a.au_id,
    a.au_fname,
    a.au_lname,
    t.title_name,
    (t.sales * t.price * r.royalty_rate * ta.royalty_share) - (r.advance * ta.royalty_share) as 'Due to author'
from authors a
inner join title_authors ta
    on a.au_id = ta.au_id
inner join titles t
    on t.title_id = ta.title_id
inner join royalties r
    on r.title_id = t.title_id
where t.sales is not null
    and (t.sales * t.price * r.royalty_rate * ta.royalty_share) - (r.advance * ta.royalty_share) > 0
order by a.au_id asc, t.title_id asc;

select
    a.au_id,
    a.au_fname,
    a.au_lname,
    t.title_name,
    (t.sales * t.price * r.royalty_rate * ta.royalty_share) - (r.advance * ta.royalty_share) as 'Due to author'
from authors a, title_authors ta, titles t, royalties r
where a.au_id = ta.au_id
    and t.title_id = ta.title_id
    and r.title_id = t.title_id
    and t.sales is not null
    and (t.sales * t.price * r.royalty_rate * ta.royalty_share) - (r.advance * ta.royalty_share) > 0
order by a.au_id asc, t.title_id asc;

# Получить гонорары, выплаченные каждым издателем.
select
    t.pub_id,
    count(t.sales) as 'Num books',
    sum(t.sales * t.price * r.royalty_rate) as 'Total royalties',
    sum(r.advance) as 'Total advances',
    sum((t.sales * t.price * r.royalty_rate) - r.advance) as 'Total due to authors'
from titles t
inner join royalties r
    on t.title_id = r.title_id
where t.sales is not null
group by t.pub_id
order by t.pub_id asc;

select
    t.pub_id,
    count(t.sales) as 'Num books',
    sum(t.sales * t.price * r.royalty_rate) as 'Total royalties',
    sum(r.advance) as 'Total advances',
    sum((t.sales * t.price * r.royalty_rate) - r.advance) as 'Total due to authors'
from titles t, royalties r
where t.title_id = r.title_id
    and t.sales is not null
group by t.pub_id
order by t.pub_id asc;

# Расчитать все гонорары, полученные каждым автором за все книги.
select
    ta.au_id,
    count(sales) as 'Num books',
    sum(t.sales * t.price * r.royalty_rate * ta.royalty_share) as 'Total royalties share',
    sum(r.advance * ta.royalty_share) as 'Total advances share',
    sum((t.sales * t.price * r.royalty_rate * ta.royalty_share) - (r.advance * ta.royalty_share)) as 'Total due to author'
from title_authors ta
inner join titles t
    on t.title_id = ta.title_id
inner join royalties r
    on r.title_id = t.title_id
where t.sales is not null
group by ta.au_id
order by ta.au_id asc;

select
    ta.au_id,
    count(sales) as 'Num books',
    sum(t.sales * t.price * r.royalty_rate * ta.royalty_share) as 'Total royalties share',
    sum(r.advance * ta.royalty_share) as 'Total advances share',
    sum((t.sales * t.price * r.royalty_rate * ta.royalty_share) - (r.advance * ta.royalty_share)) as 'Total due to author'
from title_authors ta, titles t, royalties r
where ta.title_id = t.title_id
    and r.title_id = t.title_id
    and t.sales is not null
group by ta.au_id
order by ta.au_id asc;


# Получить гонорары, которые будут выплачены каждым издательством, расположенным в США, каждому автору за все его книги.
select
    t.pub_id,
    ta.au_id,
    count(*) as 'Num books',
    sum(t.sales * t.price * r.royalty_rate * ta.royalty_share) as 'Total royalties share',
    sum(r.advance * ta.royalty_share) as 'Total advances share',
    sum((t.sales * t.price * r.royalty_rate * ta.royalty_share) - (r.advance * ta.royalty_share)) as 'Total due to author'
from title_authors ta
inner join titles t
    on t.title_id = ta.title_id
inner join royalties r
    on r.title_id = t.title_id
inner join publishers p
    on p.pub_id = t.pub_id
where t.sales is not null
    and p.country in ('USA')
group by t.pub_id, ta.au_id
having sum((t.sales * t.price * r.royalty_rate * ta.royalty_share) - (r.advance * ta.royalty_share)) > 0
order by t.pub_id asc, ta.au_id asc;

select
    t.pub_id,
    ta.au_id,
    count(*) as 'Num books',
    sum(t.sales * t.price * r.royalty_rate * ta.royalty_share) as 'Total royalties share',
    sum(r.advance * ta.royalty_share) as 'Total advances share',
    sum((t.sales * t.price * r.royalty_rate * ta.royalty_share) - (r.advance * ta.royalty_share)) as 'Total due to author'
from title_authors ta, titles t, royalties r, publishers p
where t.title_id = ta.title_id
    and r.title_id = t.title_id
    and p.pub_id = t.pub_id
    and t.sales is not null
    and p.country in ('USA')
group by t.pub_id, ta.au_id
having sum((t.sales * t.price * r.royalty_rate * ta.royalty_share) - (r.advance * ta.royalty_share)) > 0
order by t.pub_id asc, ta.au_id asc;

# Создание внешних объединений команда OUTER JOIN

# SELECT columns
# FROM left_table
# LEFT [OUTER] JOIN right_table
# ON join_conditions

# Создание полного внешнего объединения

# SELECT columns
# FROM left_table
# FULL [OUTER] JOIN right_table
# ON join_conditions

# Получить список городов, в которых живут авторы и расположены издательства.
select a.au_fname, a.au_lname, a.city from authors a;

select p.pub_name, p.city from publishers p;

select a.au_fname, a.au_lname, p.pub_name from authors a inner join publishers p on a.city = p.city;

select a.au_fname, a.au_lname, p.pub_name from authors a, publishers p where a.city = p.city;

# Это левое внешнее объединение включает в результат все строки, независимо от того, есть ли соответствие в столбце city таблицы publishers.
select a.au_fname, a.au_lname, p.pub_name from authors a left outer join publishers p on a.city = p.city order by p.pub_name asc, a.au_lname asc, a.au_fname asc;

# Это левое внешнее объединение включает в результат все строки таблицы publishers, независимо от того, есть ли соответствие в столбце city таблицы authors.
select a.au_fname, a.au_lname, p.pub_name from authors a right outer join publishers p on a.city = p.city order by p.pub_name asc, a.au_lname asc, a.au_fname asc;

# Это полное внешнее объединение включает в результат все строки таблиц publishers и authors, независимо от того, есть ли соответствия в столбцах city.
select a.au_fname, a.au_lname, p.pub_name from authors a full outer join publishers p on a.city = p.city order by p.pub_name asc, a.au_lname asc, a.au_fname asc;

# Получить количество книг, написанных авторами в ключая тех, кто не написал ни одной книги.
select a.au_id, count(ta.title_id) as 'Num books' from authors a left join title_authors ta on a.au_id = ta.au_id group by a.au_id order by a.au_id asc;

# Получить только тех авторов, которые не написали ни одной книги.
select a.au_id, a.au_fname, a.au_lname from authors a left join title_authors ta on a.au_id = ta.au_id where ta.au_id is null;

# Получить авторов и их книги, тиражи которых превысили 100 000 экземпляров.
select a.au_id, a.au_fname, a.au_lname,
       tta.title_id, tta.title_name, tta.sales
from authors a
left join (select ta.au_id, t.title_id, t.title_name, t.sales from title_authors ta
        inner join titles t
            on t.title_id = ta.title_id
            where sales > 100000) tta
on a.au_id = tta.au_id
order by a.au_id asc, tta.title_id asc;

# Создание самообъединения

# SELECT columns
# FROM table [AS] alias1
# INNER JOIN table [AS] alias2
# ON join_conditions

# Получить всех авторов, которые живут в одном штате с автором A04 (Kell Hull).
select a1.au_id, a1.au_fname, a1.au_lname, a1.state from authors a1 inner join authors a2 on a1.state = a2.state where a2.au_id = 'A04';

select a1.au_id, a1.au_fname, a1.au_lname, a1.state from authors a1, authors a2 where a1.state = a2.state and a2.au_id = 'A04';

# Отобразить для каждой биографии заголовки и данные о продаже других биографий, которые пользуются большим спросом.
select t1.title_id, t1.sales, t2.title_id as 'Better seller', t2.sales as 'Higher sales'
from titles t1
    inner join titles t2
        on t1.sales < t2.sales
where t1.type = 'biography' and t2.type = 'biography'
order by t1.title_id asc, t2.sales asc;

select t1.title_id, t1.sales, t2.title_id as 'Better seller', t2.sales as 'Higher sales'
from titles t1, titles t2
where t1.type = 'biography' and t2.type = 'biography' and t1.sales < t2.sales
order by t1.title_id asc, t2.sales asc;

# Получить все пары авторов из штата Нью-Йорк.
select a1.au_fname, a1.au_lname, a2.au_fname, a2.au_lname from authors a1 inner join authors a2 on a1.state = a2.state where a1.state = 'NY' order by a1.au_id asc, a2.au_id asc;

select a1.au_fname, a1.au_lname, a2.au_fname, a2.au_lname from authors a1, authors a2 where a1.state = a2.state and a1.state = 'NY' order by a1.au_id asc, a2.au_id asc;

# Получить пары разных авторов из штата Нью-Йорк.
select a1.au_fname, a1.au_lname, a2.au_fname, a2.au_lname from authors a1 inner join authors a2 on a1.state = a2.state and a1.au_id <> a2.au_id where a1.state = 'NY' order by a1.au_id asc, a2.au_id asc;

select a1.au_fname, a1.au_lname, a2.au_fname, a2.au_lname from authors a1, authors a2 where a1.state = a2.state and a1.au_id <> a2.au_id and a1.state = 'NY' order by a1.au_id asc, a2.au_id asc;

# Получить пары разных авторов из штата Нью-Йорк без повторов.
select a1.au_fname, a1.au_lname, a2.au_fname, a2.au_lname from authors a1 inner join authors a2 on a1.state = a2.state and a1.au_id < a2.au_id where a1.state = 'NY' order by a1.au_id asc, a2.au_id asc;

select a1.au_fname, a2.au_lname, a2.au_fname, a2.au_lname from authors a1, authors a2 where a1.state = a2.state and a1.au_id < a2.au_id and a1.state = 'NY' order by a1.au_id asc, a2.au_id asc;

# Комбинирование строк с помощью оператора UNION

# select_statement1
# UNION [ALL]
# select statement2;

# выражение UNION удаляет из результата повторяющиеся строки;
# выражение UNION ALL сохраняет повторяющиеся строки;

# Отобразить список шататов, в которых живут авторы и находятся издательства.
select state from authors
union
select state from publishers;

# Отобразить список штатов, в которых живут авторы и находятся издательства (в том числе повторы).
select state from authors
union all
select state from publishers;

# Отобразить список всех авторов и издательств.
select concat(au_fname, ' ', au_lname) as Name from authors
union
select pub_name from publishers order by 1 asc;

# Получить список всех авторов и издетельств из штата Нью-Йорк, отсортировав их по типу и названию.
select 'author' as Type, concat(au_fname, ' ', au_lname) as Name, state from authors where state = 'NY'
union
select 'publisher', pub_name, state from publishers where state = 'NY' order by 1 asc, 2 asc;

# Отобразить список всех авторов и издательств из штата Нью-Йорк, а также названия книг, опубликованных в этом штате.
select
    'author' as 'Type',
    concat(au_fname, ' ', au_lname) as 'Name'
from authors where state = 'NY'
union
select
    'publisher',
    pub_name
from publishers where state = 'NY'
order by 1 asc, 2 asc;

# Получить количество авторов, издательств из штата Нью-Йорк и книг, опубликованных в этом штате, получив их по типу.
select
    'author' as 'Type',
    count(au_id) as 'Count'
from authors where state = 'NY'
union
select
    'publisher',
    count(pub_id)
from publishers where state = 'NY'
union
select
    'title',
    count(title_id)
from titles t
inner join publishers p
    on t.pub_id = p.pub_id
where p.state = 'NY'
order by 1 asc;

# Повысить цены на книги по истории на 10%, а книги по психологии на 20%, не меняя цены других книг.
select title_id, type, price, price * 1.10 as 'New price' from titles where type = 'history'
union
select title_id, type, price, price * 1.20 from titles where type = 'psychology'
union
select title_id, type, price, price from titles where type not in ('history', 'psychology')
order by type asc, title_id asc;

# Поиск общих строк с помощью команды INTERSECT

# select_statement1
# INTERSECT
# select_statement2;

# Отобразить список городов, в которых живут авторы и находятся издательства.
select city from authors intersect select city from publishers;

select distinct authors.city from authors inner join publishers on authors.city = publishers.city;

select distinct city from authors where exists (select * from publishers where authors.city = publishers.city);

# Поиск разницы строк с помощью команды EXCEPT

# select_statement1
# EXCEPT
# select_statement2;

# Отобразить список городов, в которых живут авторы, но нет издательств
select city from authors except select city from publishers;

select distinct a.city from authors a left join publishers p on a.city = p.city where p.city is null;

select distinct city from authors where not exists (select * from publishers where authors.city = publishers.city);

select distinct city from authors where city not in (select city from publishers);

# Подзапросы

# Подзапрос  – это команда SELECT, встроенная в другую команду SQL.

# В подзапросе можно распологать следующие команды:
# предложении SELECT, FROM, WHERE или HAVING другой команды SELECT;
# команде INSERT, UPDATE или DELETE;
# другом подзапросе.

# Получить список издателей биографий.
select pub_id from titles where type = 'biography';

select pub_name from publishers where pub_id in ('P04', 'P03');

select distinct pub_name from publishers p inner join titles t on p.pub_id = t.pub_id where t.type = 'biography';

select pub_name from publishers where pub_id in (select pub_id from titles where type = 'biography');

# Получить список всех авторов, которые живут в городе, где находится издатель.
select au_id, city from authors where city in (select city from publishers);

select a.au_id, a.city from authors a inner join publishers p on a.city = p.city;

# Подзапросв и объединения

# Подзапрос с оператором IN
# SELECT *
# FROM table1
# WHERE id IN
# (SELECT id FROM table2);

# Внутреннее объединение
# SELECT table1.*
# FROM table1
# INNER JOIN table2
# ON table1.id = table2.id;

# Подзапрос NOT IN
# SELECT *
# FROM table1
# WHERE id NOT IN
# (SELECT id FROM table2)

# Подзапрос NOT EXISTS
# SELECT
# table1.*
# FROM table1
# WHERE NOT EXISTS
# (SELECT id FROM table2);

# Внешнее объединение
# SELECT table1.*
# FROM table1
# LEFT OUTER JOIN table2
# ON table1.id = table2.id
# WHERE table2.id IS NULL;

# Этот подзапрос использует оператор NOT IN, чтобы получить список всех авторов, которые не написали ни одной книги.
select au_id, au_fname, au_lname from authors where au_id not in (select au_id from title_authors);

# с оператором EXISTS
select au_id, au_fname, au_lname from authors a where not exists (select * from title_authors ta where a.au_id = ta.au_id);

# с внешним объединением
select a.au_id, a.au_fname, a.au_lname from authors a left outer join title_authors ta on a.au_id = ta.au_id where ta.au_id is null;

# Получить список всех авторов, которые живут с автором A04 (Klee Hull) в одном штате.
select au_id, au_fname, au_lname, state from authors where state in (select state from authors where au_id = 'A04');

# с внутренним объединением
select a1.au_id, a1.au_fname, a1.au_lname, a1.state from authors a1 inner join authors a2 on a1.state = a2.state where a2.au_id = 'A04';

# Получить список всех книг, цена на которые соответствует самой высокой стоимости.
select title_id, price from titles where price = (select max(price) from titles);

# Получить список всех авторов, которые живут в городе, где находится издательство.
select a.au_id, a.city, p.pub_id from authors a inner join publishers p on a.city = p.city;

# Простые и сложные подзапросы

# Получить список всех авторов, где находится издательство.
select au_id, city from authors where city in (select city from publishers);

# Получить список всех городов, в которых находится издательства.
select city from publishers;

select au_id, city from authors where city in ('New York', 'San Francisco', 'Hamburg', 'Berkley');

# SELECT outer columns
# FROM outer_table
# WHERE outer_column_value IN
# (SELECT inner_column
# FROM inner_table
# WHERE inner_column = outer_column)







