CREATE TABLE engineering_economic_university.faculty (id int primary key, 
	faculty_name varchar(100), 
	cost numeric(9,2));	

CREATE TABLE engineering_economic_university.сourse (id int primary key,
	сourse_number int, 
	faculty_id int REFERENCES engineering_economic_university.faculty(id));

CREATE TABLE engineering_economic_university.student (id int primary key,
	last_name varchar(35),
	first_name varchar(35),
	middle_name varchar(35),
	paid_training boolean,
	сourse_id int REFERENCES engineering_economic_university.сourse(id));

-- Этап №2 Заполнение данными:

INSERT INTO engineering_economic_university.faculty values (1, 'Инженерный', 30000),
	(2, 'Экономический', 49000);

INSERT INTO engineering_economic_university.сourse values (1, 1, 1), (2, 1, 2), (3, 4, 2);

INSERT INTO engineering_economic_university.student values (1, 'Петров', 'Петр', 'Петрович', false, 1), 
	(2, 'Иванов', 'Иван', 'Иваныч', true, 1), 
	(3, 'Михно', 'Сергей', 'Иваныч', false, 3), 
	(4, 'Стоцкая', 'Ирина', 'Юрьевна', true, 3);
	

INSERT INTO engineering_economic_university.student (id, last_name, first_name, paid_training, сourse_id) values 
	(5, 'Младич', 'Настасья', true, 2);

--Этап №3 Выборка данных. Необходимо написать sql запросы :

--1. Вывести всех студентов, кто платит больше 30_000.
select st.id, 
	st.last_name, 
	st.first_name, 
	st.middle_name, 
	st.paid_training, 
	co.сourse_number, 
	fa.faculty_name,
	fa.cost
from engineering_economic_university.student st 
	join engineering_economic_university.сourse co on st.сourse_id = co.id
	join engineering_economic_university.faculty fa on co.faculty_id = fa.id
where st.paid_training = true and fa.cost > 30000

--2. Перевести всех студентов Петровых на 1 курс экономического факультета.
update engineering_economic_university.student set сourse_id = 2
	where last_name like 'Петров%'


--3. Вывести всех студентов без отчества или фамилии.
select *
from engineering_economic_university.student
where last_name is null or middle_name is null

--4. Вывести всех студентов содержащих в фамилии или в имени или в отчестве "ван".
	-- вариант 1:
select *
from engineering_economic_university.student
where first_name like '%ван%' or last_name  like '%ван%' or middle_name  like '%ван%'

	-- вариант 2:
	-- то же самое, только в таблице указан курс и факультет
select st.id, 
	st.last_name, 
	st.first_name, 
	st.middle_name, 
	st.paid_training, 
	co.сourse_number, 
	fa.faculty_name
from engineering_economic_university.student st 
	join engineering_economic_university.сourse co on st.сourse_id = co.id
	join engineering_economic_university.faculty fa on co.faculty_id = fa.id
where first_name like '%ван%' or last_name  like '%ван%' or middle_name  like '%ван%'

--5. Удалить все записи из всех таблиц.
delete from engineering_economic_university.student
delete from engineering_economic_university.сourse
delete from engineering_economic_university.faculty