-- CTE's 

WITH CTE_Example AS ( # É usado a expressão WITH para criar uma CTE e ela exige que a query esteja em parênteses 

SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, count(salary) count_sal
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_sal) # Somente após a criação da CTE é que ela pode ser chamada pois ela não guarda nenhuma informação na memória.
FROM CTE_Example
;
# Multiplas Querys como CTE's 

WITH CTE_Example AS  (
SELECT employee_id, gender, birth_date
FROM employee_demographics
WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS (
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000 
)
SELECT *
FROM CTE_Example
JOIN CTE_Example2
	ON CTE_Example.employee_id = CTE_Example2.employee_id;

WITH CTE_Example (Gender, AVG_sal, MAX_sal, MIN_sal, COUNT_sal) AS ( # é possível nomear as colunas no próprio comando WITH e ela ira sobrepor a Aliasing do comando SELECT.

SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, count(salary) count_sal
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT *
FROM CTE_Example;