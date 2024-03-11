CREATE SCHEMA H1;

CREATE TABLE H1.Usuario (
  UsuarioID INT PRIMARY KEY NOT NULL,
  Nome VARCHAR(150) NOT NULL,
  Foto VARCHAR(150)
);

CREATE TABLE H1.Grupo (
  GrupoID INT PRIMARY KEY NOT NULL,
  Nome VARCHAR(150) NOT NULL,
  Descricao VARCHAR(250),
  Quantidade INT,
  Valor FLOAT,
  Sorteado CHAR(1),
  CriadorID INT,
  DataFim DATETIME,
  CONSTRAINT FK_Criador FOREIGN KEY (CriadorID) REFERENCES H1.Usuario(UsuarioID)
);

CREATE TABLE H1.MembroGrupo (
  GrupoID INT NOT NULL,
  UsuarioID INT NOT NULL,
  AmigoSecreto VARCHAR(150),
  Desejo VARCHAR(150),
  Apelido VARCHAR(150),
  CONSTRAINT PK_MembroGrupo PRIMARY KEY (GrupoID, UsuarioID),
  CONSTRAINT FK_MembroGrupo_Grupo FOREIGN KEY (GrupoID) REFERENCES H1.Grupo(GrupoID),
  CONSTRAINT FK_MembroGrupo_Usuario FOREIGN KEY (UsuarioID) REFERENCES H1.Usuario(UsuarioID)
);

INSERT INTO H1.Usuario (UsuarioID, Nome, Foto)
VALUES
  (1, 'Joao', 'joao.jpg'),
  (2, 'Maria', 'maria.jpg'),
  (3, 'Pedro', NULL);


INSERT INTO H1.Grupo (GrupoID, Nome, Descricao, Quantidade, Valor, Sorteado, CriadorID, DataFim)
VALUES
  (1, 'Grupo do Amigo Chocolate', 'Grupo para troca de presentes do AmigoChocolate', 5, 50.00, 'N', 1, '2024-04-10 23:59:59');


INSERT INTO H1.MembroGrupo (GrupoID, UsuarioID, AmigoSecreto, Desejo, Apelido)
VALUES
  (1, 1, 'Maria', 'Ovo de chocolate', 'Joaozinho'),
  (1, 2, 'Pedro', 'Bomba de chocolate', 'Mariazinha'),
  (1, 3, 'Joao', 'Coelho de chocolate', 'Pedrinho');
