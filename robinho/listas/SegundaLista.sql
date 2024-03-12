-- Exercicio 5

use BD044152 
GO
CREATE VIEW vw_ClientesCompleto AS
SELECT
  c.Nome,
  c.ClienteID AS Codigo,
  COALESCE(cf.CPF, cj.CNPJ) AS CPFCNPJ
FROM
  dbo.Cliente c
FULL JOIN dbo.ClienteFisico cf ON c.ClienteID = cf.ClienteID
FULL JOIN dbo.ClienteJuridico cj ON c.ClienteID = cj.ClienteID;

GO
SELECT * FROM vw_ClientesCompleto
GO
CREATE VIEW vw_ClientesFiltrados AS
SELECT
  c.Nome,
  c.ClienteID AS Codigo,
  cf.CPF AS CPFCNPJ
FROM
  dbo.Cliente c
INNER JOIN dbo.ClienteFisico cf ON c.ClienteID = cf.ClienteID
WHERE cf.CPF IS NOT NULL
UNION ALL
SELECT
  c.Nome,
  c.ClienteID AS Codigo,
  cj.CNPJ
FROM
  dbo.Cliente c
INNER JOIN dbo.ClienteJuridico cj ON c.ClienteID = cj.ClienteID
WHERE cj.CNPJ IS NOT NULL;
GO
SELECT * FROM vw_ClientesFiltrados

-- Exercicio 6 

GO
CREATE VIEW vw_ValorAcumuladoPorGrupoAno AS
SELECT
  g.Descricao AS Grupo,
  YEAR(v.DataPedido) AS Ano,
  SUM(v.ValorLiquido) AS ValorAcumulado
FROM
  dbo.Venda v
INNER JOIN dbo.VendaProduto vp ON v.VendaID = vp.VendaID
INNER JOIN dbo.Produto p ON vp.ProdutoID = p.ProdutoID
INNER JOIN dbo.Grupo g ON p.GrupoID = g.GrupoID
GROUP BY
  g.Descricao,
  YEAR(v.DataPedido);
GO
SELECT * FROM vw_ValorAcumuladoPorGrupoAno

 --Exercicio 7
 GO
 WITH TotalDescontos AS (
  SELECT SUM(ValorDesconto) AS SomaDescontos
  FROM dbo.VendaProduto
)
SELECT
  p.ProdutoID AS CodProd,
  p.Descricao,
  SUM(vp.ValorDesconto) AS TotalDesconto,
  (SUM(vp.ValorDesconto) / (SELECT SomaDescontos FROM TotalDescontos)) * 100 AS Porcentagem
FROM dbo.Produto p
INNER JOIN dbo.VendaProduto vp ON p.ProdutoID = vp.ProdutoID
GROUP BY
  p.ProdutoID,
  p.Descricao;
GO

--Exercicio 8
CREATE PROCEDURE PesquisarClientes (@TipoCliente CHAR(1) = NULL)
AS
BEGIN
  WITH Clientes AS (
    SELECT
      C.ClienteID,
      C.Nome,
      C.DataCadastro,
      CASE
        WHEN f.ClienteID IS NOT NULL THEN 'F'
        ELSE 'J'
      END AS Tipo,
      f.Sexo,
      f.CPF,
      f.Identidade,
      f.DataNascimento,
      f.EstadoCivilID,
      j.CNPJ,
      j.Fantasia
    FROM dbo.Cliente C
    LEFT JOIN dbo.ClienteFisico f ON C.ClienteID = f.ClienteID
    LEFT JOIN dbo.ClienteJuridico j ON C.ClienteID = j.ClienteID
  )
  SELECT *
  FROM Clientes
  WHERE (@TipoCliente IS NULL) OR (Tipo = @TipoCliente);
END;

EXEC PesquisarClientes 'J'

--Exercicio 9
SELECT
  G.Descricao AS NomeGrupo,
  COUNT(P.ProdutoID) AS QuantidadeCadastrados,
  SUM(VP.QtdeVendida) AS QuantidadeVendida,
  CASE 
    WHEN SUM(VP.QtdeVendida) IS NULL THEN 'sem registro'
    ELSE CAST(SUM(VP.QtdeVendida) AS VARCHAR)
  END,
  MAX(V.DataPedido) AS UltimaDataVenda,
  CASE 
    WHEN MAX(V.DataPedido) IS NULL THEN 'sem registro'
    ELSE CONVERT(VARCHAR(10), MAX(V.DataPedido), 120) 
  END
FROM dbo.Grupo G
LEFT JOIN dbo.Produto P ON G.GrupoID = P.GrupoID
LEFT JOIN dbo.VendaProduto VP ON P.ProdutoID = VP.ProdutoID
LEFT JOIN dbo.Venda V ON VP.VendaID = V.VendaID
GROUP BY
  G.Descricao;

  --Exercicio 10
  GO
  CREATE PROCEDURE PesquisarClientesPorNome (@Letra CHAR(1) = 'R')
AS
BEGIN
	IF @Letra = 'R'
BEGIN 
  SELECT ClienteID, Nome
  FROM dbo.Cliente
  WHERE Nome LIKE 'R%'
END
ELSE 
BEGIN 
	SELECT ClienteID, Nome
	FROM Cliente
	WHERE Nome LIKE @Letra + '%'
END
END

EXEC PesquisarClientesPorNome @Letra = '4'








