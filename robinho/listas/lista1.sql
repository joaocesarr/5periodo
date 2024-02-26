--1 ATIVIDADE: -
CREATE FUNCTION TrimDate (@dataToTrim datetime)
RETURNS varchar(20)
AS
BEGIN
RETURN CONCAT(DATENAME(month, @dataToTrim), '/', CONVERT(varchar(4), YEAR(@dataToTrim)))
END
  
SELECT
dbo.TrimDate(DataPedido) AS DataDoPedido,
COUNT(*) AS TotalDeVendas
FROM Venda
GROUP BY dbo.TrimDate(DataPedido)
ORDER BY MIN(DataPedido)

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
WITH ClienteTotal AS (
SELECT
c.Nome,
COUNT(v.ValorLiquido) AS NumCompras,
SUM(v.ValorLiquido) AS TotalComprado
FROM
Cliente c
JOIN Venda v ON c.ClienteID = v.ClienteID
GROUP BY
c.Nome
),
EmpresaTotal AS (
SELECT
SUM(TotalComprado) AS TotalEmpresa,
SUM(NumCompras) AS TotalComprasEmpresa
FROM
ClienteTotal
)
SELECT
ct.Nome AS NomeDoCliente,
ct.TotalComprado,
ct.TotalComprado / ct.NumCompras AS TicketMedioCliente,
(SELECT TotalEmpresa / TotalComprasEmpresa FROM EmpresaTotal) AS TicketMedioEmpresa,
(ct.TotalComprado / ct.NumCompras) / (SELECT TotalEmpresa / TotalComprasEmpresa FROM EmpresaTotal) * 100 AS Comparativo
FROM
ClienteTotal ct
ORDER BY
NomeDoCliente;

-- 4 – ATIVIDADE:
WITH TotalVendas AS (
SELECT
SUM(vp.QtdeVendida) AS TotalQuantidade
FROM
VendaProduto vp
),
MarcaVendas AS (
SELECT
p.MarcaID,
SUM(vp.QtdeVendida) AS QuantidadeVendida
FROM
Produto p
JOIN VendaProduto vp ON p.ProdutoID = vp.ProdutoID
GROUP BY
p.MarcaID
),
TotalMarca AS (
SELECT
m.Descricao AS Marca,
mv.QuantidadeVendida
FROM
MarcaVendas mv
JOIN Marca m ON mv.MarcaID = m.MarcaID
)
SELECT
tm.Marca,
tm.QuantidadeVendida,
CAST((tm.QuantidadeVendida * 100.0 / tv.TotalQuantidade) AS DECIMAL(10, 2)) AS PorcentagemVendida
FROM
TotalMarca tm
CROSS JOIN
TotalVendas tv
ORDER BY
tm.QuantidadeVendida DESC;
