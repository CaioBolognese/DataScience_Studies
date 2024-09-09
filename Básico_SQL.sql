SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT first_name,
last_name,
birth_date, 
age,
age + 10
FROM parks_and_recreation.employee_demographics;
#PEMDAS


SELECT DISTINCT gender, first_name  # seleciona somente os valores unicos de determinada coluna, OBS: tal função sempre considera a coluna de maior tamanho para fazer a seleção independente da ordem
FROM parks_and_recreation.employee_demographics;


SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary > 50000;  # o comando where atende aos operadores condicionais como =, !=, >, <, >=, <=

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1989-01-01'; # o comando aceita pesquisas em data atendendo o padrão 'yyyy-mm-dd'

-- AND, OR, NOT --

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1989-01-01' 
OR gender = 'male'
; 
SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1989-01-01' 
AND gender = 'male';

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE (birth_date > '1989-01-01' AND gender = 'male') OR age > 18  # a ideia é que os operadores logicos seguem um ordem se colocados em parenteses
;
-- LIKE statement
-- % and _

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'A%';

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'A__';

SELECT gender # o alvo no select precisa estar de acordo com o desejado no group by
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

SELECT occupation
FROM parks_and_recreation.employee_salary
GROUP BY occupation;

SELECT occupation, salary # caso o group by contenha colunas com valores diferentes em uma mais iguais na outra ele sempre optara por distinguir repetindo os valores da primeira.
FROM parks_and_recreation.employee_salary
GROUP BY occupation, salary;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

-- ORDER BY  
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender, age DESC; # a ordem das colunas na hora do order by influencia no objeto final da query 

-- HAVING vs WHERE 
SELECT gender, AVG(age)
FROM employee_demographics
WHERE AVG(age) > 40
GROUP BY gender; # esse codigo da erro pois o comando WHERE solicita um recorte que não ainda não aconteceu, só acontecerá ápos o GROUP BY.->

SELECT occupation, AVG(salary) # exemplo de codigo utilizando o comando WHERE e HAVING na mesma query.
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation 
HAVING AVG(salary) > 70000;

-- LIMIT 
SELECT * 
FROM employee_demographics
ORDER BY age
LIMIT 3;

-- Aliasing
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender;