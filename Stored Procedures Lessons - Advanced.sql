-- Stored Procedures
# Stored Procedures são comandos guardados na memória que executam determinada query quando chamados.

CREATE PROCEDURE large_salaries() # Essa seria a maneira mais rápida de criar um procedure mas não a mais correta porque é muito simples para se utilizar um procedure.
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL large_salaries()
# Essa seria a maneira correta respeitando as boas práticas de coding

DELIMITER $$
CREATE PROCEDURE large_salaries2() 
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary > 10000;
END $$
DELIMITER ;

CALL large_salaries2();

# É possível também utilizar parâmetros na criação de um Procedure

DELIMITER $$
CREATE PROCEDURE large_salaries3(employee_id_param INT) # outra forma de nomear o parametro é com p_ na frente do nome do parâmetro.
BEGIN
	SELECT salary
	FROM employee_salary
	WHERE employee_id = employee_id_param;
END $$
DELIMITER ;

CALL large_salaries3(1);