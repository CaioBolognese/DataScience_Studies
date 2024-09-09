-- INNER JOINS  # por definição o comando JOIN é sempre um INNER JOIN
SELECT *
FROM employee_demographics
JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id; # é preciso especificar usando o comando ON qual coluna servirá de comparação para o JOIN
    
SELECT * 
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id; # É importante utilizar o Aliasing para renomear as tabelas e tornar o codigo mais limpo e compreensível.->
    
SELECT dem.employee_id, age, occupation # é possivel fazer recortes das colunas desejadas especificando de onde a informação deve ser tirada, gerando uma query mais limpa
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
-- OUTER JOINS
SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal # Existem dois tipos de outer joins o LEFT e RIGHT a ideia é similiar em um ele compara a tabela da direita e retorna tudo que tiver correspondecia na tabela da esquerda e vice-versa.
	ON dem.employee_id = sal.employee_id;
    
SELECT *
FROM employee_demographics dem # nesse JOIN existe uma diferença, a coluna da direita possui um valor que não existe na coluna esquerda mas mesmo assim esse valor é contabilizado como NULL.
RIGHT JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

-- SELF JOIN 
SELECT sal.employee_id emp_amg_sec,
sal.first_name nome_amg_sec,
sal.last_name sobrenome_amg_sec,
sal2.employee_id empregado,
sal2.first_name nome,
sal2.last_name sobrenome
FROM employee_salary AS sal
JOIN employee_salary AS sal2 # é possível dar JOIN em duas tabelas iguais basta diferencia-las usando AS
	ON sal.employee_id + 1 = sal2.employee_id;
    
-- Joining multiple tables
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
SELECT * 
FROM parks_departments;

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd # é importante prestar atenção a qual coluna você esta linkando o JOIN, pois é preciso ter as colunas correspondentes para o JOIN ser bem sucedido.
	ON sal.dept_id = pd.department_id;
    
-- UNIONS
SELECT first_name, last_name # o comando UNION combina colunas de diferentes tabelas em apenas uma.
FROM employee_demographics
UNION # Por definição todas o comando UNION é setado com UNION DISTINC
SELECT first_name, last_name
FROM employee_salary;

SELECT first_name, last_name 
FROM employee_demographics
UNION ALL # Mas pode ser combinado para juntar todos os elementos mesmo que repetidos.
SELECT first_name, last_name
FROM employee_salary;

SELECT first_name, last_name, 'Old Man' AS Label # Aqui contêm um exemplo pratico de como usar o comando UNION junto com os demais para selecionar individuos com caracteristicas especificas.
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION 
SELECT first_name, last_name, 'Old Lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Higly Paid Employee' AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name;

-- Strings Function
# Função LENGTH mede o tamanho da string
SELECT first_name, last_name, LENGTH(first_name) + LENGTH(last_name) AS tamanho_nome
FROM employee_demographics;

# Função UPPER e LOWER deixa uniforme os caracteres de uma string tanto para maiusculo quanto para minusculo.
SELECT first_name, last_name, UPPER(first_name) AS nome_maiusculo, LOWER(last_name) AS sobrenome_minusculo
FROM employee_demographics;

# Função TRIM retira espaço em branco presente nas strings possui o LTRIM e RTRIM para uso somente na esquerda ou somente na direita.
SELECT first_name, last_name, TRIM(last_name)
FROM employee_demographics;

# Função SUBSTRING ela particiona a string da forma que for indicada nos parametros dentro da função.
SELECT first_name, last_name, SUBSTRING(birth_date, 6, 2) AS mes_aniversario 
FROM employee_demographics;

# Função REPLACE recoloca no lugar de algum caractere outro caractere especificado no local.
SELECT first_name, last_name, REPLACE(first_name, 'e', 'z')
FROM employee_demographics;

# Função LOCATE localiza algo e retorna ou a posição do caractere ou se o objeto buscado está ou não na coluna (0 ou 1)
SELECT first_name, last_name, LOCATE('An', first_name)
FROM employee_demographics;

# Função CONCAT concateciona duas strings em somente uma.
SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;

-- Case Statements
# Funcionam basicamente como uma clausula IF, possui a seguinte estrutura:
SELECT first_name, last_name, age,
CASE
	WHEN age < 30 THEN 'Young'
    WHEN age BETWEEN 30 AND 50  THEN 'Old'
    WHEN age > 50 THEN 'Almost Dead'
END AS age_Label
FROM employee_demographics;

-- Example 
-- Pay Increases
-- Se salario < 50000 = 5% de aumento
-- Se salario > 50000 = 7% de aumento 
-- Se trabalhar no setor de finanças ganha um bônus de 10%

SELECT first_name, last_name, occupation,
CASE
	WHEN salary < 50000 THEN salary * 1.05
	WHEN salary > 50000 THEN salary * 1.07
    WHEN salary = 50000 THEN salary
END AS new_salary,
CASE
	WHEN dept_id = 6 THEN salary * 0.10
    WHEN dept_id != 6 THEN 0
END AS bonus_pay
FROM employee_salary
;
-- Subqueries 

SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics
WHERE employee_id IN 
				( SELECT employee_id # Não se pode colocar mais de uma coluna em subqueries
					FROM employee_salary
					WHERE dept_id = 1)
;

SELECT first_name, salary, # Funções agregadas precisam ser tratadas diferentes se feitas dentro umas subquerie
(SELECT AVG(salary)
FROM employee_salary) AS avg_sal
FROM employee_salary;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

SELECT gender, AVG(`MAX(age)`), AVG(`MIN(age)`)# Quando uma subquerie esta com funções agregadas o nome da função passa a ser o nome da coluna. 
FROM
		(SELECT gender, AVG(age), 
						MAX(age), 
						MIN(age), 
						COUNT(age) # É recomendado renomear todas as funções dentro da subquerie para quando chamar ela lá em cima não precisar de acentos.
FROM employee_demographics
GROUP BY gender) AS agg_stats
GROUP BY gender;

-- Window Functions
# Funciona como uma alternativa ao GROUP BY que lida melhor com problemas de individualidade dos elementos na querie.
SELECT gender, AVG(salary) as avg_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender;

SELECT gender, AVG(salary) OVER(PARTITION BY gender) # o PARTITION BY funciona como um GROUP BY dentro do OVER()
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

SELECT dem.first_name, dem. last_name, gender, AVG(salary) OVER(PARTITION BY gender) # Com o Window Function é possível adquirir mais informações como nome sem prejudicar a estrutura da tabela.
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

SELECT dem.first_name, dem. last_name,gender, SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id)  AS rolling_total # Aqui é um exemplo utilizando o Rolling Total, que particiona e soma cada variavel até 
FROM employee_demographics dem																								   # chegar no total da soma dos valores de todos os elementos.
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

#A seguir contêm algumas funções que só podem ser utilizadas com Window Functions como ROW_NUMBER, RANK() e DENSE_RANK()
SELECT dem.first_name, dem. last_name, gender, salary, 
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary) row_num, 
RANK() OVER(PARTITION BY gender ORDER BY salary) rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary) dense_rank_num
FROM employee_demographics dem																								   
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;












