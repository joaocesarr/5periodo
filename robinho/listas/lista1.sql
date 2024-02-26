--1 ATIVIDADE: -
  SELECT
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    SUM(quantity) AS total_products_sold
FROM
    sales
GROUP BY
    EXTRACT(YEAR FROM date),
    EXTRACT(MONTH FROM date)
ORDER BY
    year,
    month;
-- 2 ATIVIDADE:  -
SELECT
LEFT(c.Nome, CHARINDEX(' ', c.Nome + ' ') - 1) AS PrimeiroNome,
DATEPART(day, c.DataCadastro) AS DiaNascimento,
DATEPART(month, c.DataCadastro) AS MesNascimento
FROM
Cliente c
ORDER BY
DATEPART(month, c.DataCadastro),
DATEPART(day, c.DataCadastro);
-- 3 ATIVIDADE:
SELECT
    nome_cliente,
    total_comprado,
    ticket_medio_cliente,
    ticket_medio_empresa,
    (ticket_medio_cliente / ticket_medio_empresa - 1) * 100 AS comparativo_percentual
FROM
    (
        SELECT
            c.nome AS nome_cliente,
            SUM(v.total_compra) AS total_comprado,
            AVG(v.total_compra) AS ticket_medio_cliente,
            (SELECT AVG(total_compra) FROM vendas) AS ticket_medio_empresa
        FROM
            clientes c
        INNER JOIN vendas v ON c.id = v.id_cliente
        GROUP BY
            c.id
    ) AS subquery;
-- 4 – ATIVIDADE:
SELECT
    marca,
    SUM(quantidade_vendida) AS quantidade_produtos_vendidos,
    ROUND((SUM(quantidade_vendida) / total_produtos_vendidos) * 100, 2) AS porcentagem_vendida
FROM
    (
        SELECT
            p.marca,
            v.quantidade_vendida,
            (SELECT SUM(quantidade_vendida) FROM vendas) AS total_produtos_vendidos
        FROM
            produtos p
        INNER JOIN vendas v ON p.id = v.id_produto
    ) AS subquery
GROUP BY
    marca
ORDER BY
    quantidade_produtos_vendidos DESC;

