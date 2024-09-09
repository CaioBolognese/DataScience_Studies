-- Temporary Tables

# Temporary Tables são tabelas criadas para utilização na mesma sessão mesmo que em janelas diferentes, pois ficam guardadas na memória enaquanto durar a sessão 
# Contudo não ficam salvar como tabelas após o fechamento da Workbench.

CREATE TEMPORARY TABLE Exemplo_TEMP
(
Nome varchar(50),
Sobrenome varchar(50),
Filme_Favorito varchar(100)
);

SELECT *
FROM Exemplo_TEMP;

INSERT INTO Exemplo_TEMP
VALUES('Caio', 'Bolognese', 'Minha mãe é uma peça');

SELECT *
FROM Exemplo_TEMP;

CREATE TEMPORARY TABLE Salario_acima_50k
(
SELECT *
FROM employee_salary
WHERE salary >= 50000
);

SELECT *
FROM Salario_acima_50k;