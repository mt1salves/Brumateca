DROP DATABASE IF EXISTS Brumateca;

CREATE DATABASE Brumateca 
DEFAULT CHARACTER SET utf8 
DEFAULT COLLATE utf8_general_ci; 

USE Brumateca;

# TABELAS

-- ---------------------------------
-- Brumateca.Endereco
-- ---------------------------------

DROP TABLE IF EXISTS Endereco;

CREATE TABLE Endereco(
	idEndereco INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cep VARCHAR(45) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    estado VARCHAR(45) NOT NULL,
    bairro VARCHAR(45) NOT NULL,
    logradouro VARCHAR(45) NOT NULL,
    numero VARCHAR(6) NOT NULL,
    complemento VARCHAR(45) NOT NULL
) DEFAULT CHARSET = utf8;

# DESCRIBE Endereco;

-- ---------------------------------
-- Brumateca.Curso
-- ---------------------------------

DROP TABLE IF EXISTS Curso;

CREATE TABLE Curso(
	idCurso INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    curso VARCHAR(45) NOT NULL UNIQUE
) DEFAULT CHARSET = utf8;

# DESCRIBE Curso;

-- ---------------------------------
-- Brumateca.Turma
-- ---------------------------------

DROP TABLE IF EXISTS Turma;

CREATE TABLE Turma(
	idTurma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    turma VARCHAR(45) NOT NULL UNIQUE
) DEFAULT CHARSET = utf8;

# DESCRIBE Turma;

-- ---------------------------------
-- Brumateca.Departamento
-- ---------------------------------

DROP TABLE IF EXISTS Departamento;

CREATE TABLE Departamento(
	idDepartamento INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL UNIQUE
) DEFAULT CHARSET = utf8;

# DESCRIBE Departamento;

-- ---------------------------------
-- Brumateca.Disciplina
-- ---------------------------------

DROP TABLE IF EXISTS Disciplina;

CREATE TABLE Disciplina(
	idDisciplina INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    disciplina VARCHAR(45) NOT NULL UNIQUE
) DEFAULT CHARSET = utf8;

# DESCRIBE Disciplina;

-- ---------------------------------
-- Brumateca.Instituicao
-- ---------------------------------

DROP TABLE IF EXISTS Instituicao;

CREATE TABLE Instituicao(
	idInstituicao INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    instituicao VARCHAR(45) NOT NULL UNIQUE
) DEFAULT CHARSET = utf8;

# DESCRIBE Instituicao;

-- ---------------------------------
-- Brumateca.Exemplar
-- ---------------------------------

DROP TABLE IF EXISTS Exemplar;

CREATE TABLE Exemplar(
	idExemplar INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    exemplar INT NOT NULL
) DEFAULT CHARSET = utf8;

# DESCRIBE Exemplar;

-- ---------------------------------
-- Brumateca.Tipo
-- ---------------------------------

DROP TABLE IF EXISTS Tipo;

CREATE TABLE Tipo(
	idTipo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45)
) DEFAULT CHARSET = utf8;

# DESCRIBE Tipo;

-- ---------------------------------
-- Brumateca.Usuario
-- ---------------------------------

DROP TABLE IF EXISTS Usuario;

CREATE TABLE Usuario(
	idUsuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    dataNascimento DATE NOT NULL,
    escolaridade VARCHAR(45) NOT NULL,
    numeroUsuario VARCHAR(45) NOT NULL,
    Endereco_idEndereco INT NOT NULL,
    FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco(idEndereco)
) DEFAULT CHARSET = utf8;

# DESCRIBE Usuario;

-- ---------------------------------
-- Brumateca.Estudante
-- ---------------------------------

DROP TABLE IF EXISTS Estudante;

CREATE TABLE Estudante(
	idEstudante INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    numeroMatricula VARCHAR(15) NOT NULL UNIQUE,
    anoIngresso YEAR NOT NULL,
    Usuario_idUsuario INT NOT NULL,
    Curso_idCurso INT NOT NULL,
    FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario(idUsuario),
    FOREIGN KEY (Curso_idCurso) REFERENCES Curso(idCurso)
) DEFAULT CHARSET = utf8;

# DESCRIBE Estudante;

-- ---------------------------------
-- Brumateca.Professor
-- ---------------------------------

DROP TABLE IF EXISTS Professor;

CREATE TABLE Professor(
	idProfessor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    titulacao VARCHAR(45) NOT NULL,
    Disciplina_idDisciplina INT NOT NULL,
    Departamento_idDepartamento INT NOT NULL,
    Turma_idTurma INT NOT NULL,
    Usuario_idUsuario INT NOT NULL,
    FOREIGN KEY (Disciplina_idDisciplina) REFERENCES Disciplina(idDisciplina),
    FOREIGN KEY (Departamento_idDepartamento) REFERENCES Departamento(idDepartamento),
    FOREIGN KEY (Turma_idTurma) REFERENCES Turma(idTurma),
    FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario(idUsuario)
) DEFAULT CHARSET = utf8;

# DESCRIBE Professor;

-- ---------------------------------
-- Brumateca.UsuarioEspecial
-- ---------------------------------

DROP TABLE IF EXISTS UsuarioEspecial;

CREATE TABLE UsuarioEspecial(
	idUsuarioEspecial INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Usuario_idUsuario INT NOT NULL,
    FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario(idUsuario)
) DEFAULT CHARSET = utf8;

# DESCRIBE UsuarioEspecial;

-- ---------------------------------
-- Brumateca.Obra
-- ---------------------------------

DROP TABLE IF EXISTS Obra;

CREATE TABLE Obra(
	idObra INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    Exemplar_idExemplar INT NOT NULL,
    Tipo_idTipo INT NOT NULL,
    FOREIGN KEY (Exemplar_idExemplar) REFERENCES Exemplar(idExemplar),
    FOREIGN KEY (Tipo_idTipo) REFERENCES Tipo(idTipo)
) DEFAULT CHARSET = utf8;

# DESCRIBE Obra;

# RELACIONAMENTOS

-- ---------------------------------
-- Brumateca.Emprestimo
-- ---------------------------------

DROP TABLE IF EXISTS Emprestimo;

CREATE TABLE Emprestimo(
	idEmprestimo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    dataEmprestimo DATE NOT NULL,
    dataDevolucao DATE NOT NULL,
    numeroEmprestimo INT NOT NULL,
    vencimento TINYINT NOT NULL,
    Usuario_idUsuario INT NOT NULL,
    Obra_idObra INT NOT NULL,
	FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario(idUsuario),
    FOREIGN KEY (Obra_idObra) REFERENCES Obra(idObra)
);

# DESCRIBE Emprestimo;

-- ---------------------------------
-- Brumateca.Consulta
-- ---------------------------------

DROP TABLE IF EXISTS Consulta;

CREATE TABLE Consulta(
	idConsulta INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    numeroConsulta INT NOT NULL,
    Usuario_idUsuario INT NOT NULL,
    Obra_idObra INT NOT NULL,
    FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario(idUsuario),
    FOREIGN KEY (Obra_idObra) REFERENCES Obra(idObra)
);

# DESCRIBE Consulta;

-- ---------------------------------
-- Brumateca.Compra
-- ---------------------------------

DROP TABLE IF EXISTS Compra;

CREATE TABLE Compra(
	idCompra INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Instituicao_idInstituicao INT NOT NULL,
    Obra_idObra INT NOT NULL,
    FOREIGN KEY (Instituicao_idInstituicao) REFERENCES Instituicao(idInstituicao),
    FOREIGN KEY (Obra_idObra) REFERENCES Obra(idObra)
);

# DESCRIBE Compra;

# INSERÇÃO DE VALORES

-- ---------------------------------
-- INSERT INTO Endereco
-- ---------------------------------

INSERT INTO Endereco(idEndereco, cep, cidade, estado, bairro, logradouro, numero, complemento)
VALUES (DEFAULT, '46430000', 'Guanambi', 'Bahia', 'Centro', 'Rua Maria Quitéria', '108', 'Edifício'),
	   (DEFAULT, '46430000', 'Guanambi', 'Bahia', 'Centro', 'Rua Treze de Maio', '170', 'Edifício'),
	   (DEFAULT, '46430000', 'Guanambi', 'Bahia', 'Centro', 'Rua Doutor José Humberto Nunes', '55', 'Sobrado'),
	   (DEFAULT, '46430000', 'Guanambi', 'Bahia', 'Bela Vista', 'Avenida Otávio Mangabeira', '1026', 'Sobrado'),
	   (DEFAULT, '46100000', 'Brumado', 'Bahia', 'Parque Alvorada', 'Rua Antônio Alves Dantas', '116', 'Apartamento'),
       (DEFAULT, '46100000', 'Brumado', 'Bahia', 'Ginásio Industrial', 'Avenida Mestre Eufrásio', '369', 'Apartamento');
       
-- ---------------------------------
-- INSERT INTO Curso
-- ---------------------------------

INSERT INTO Curso(idCurso, curso)
VALUES (DEFAULT, 'Física'),
       (DEFAULT, 'Química'),
	   (DEFAULT, 'Agronomia'),
	   (DEFAULT, 'Ciências Sociais'),
	   (DEFAULT, 'Ciências Biológicas'),
       (DEFAULT, 'Ciência da Computação');
       
-- ---------------------------------
-- INSERT INTO Turma
-- ---------------------------------
       
INSERT INTO Turma(idTurma, turma)
VALUES (DEFAULT, '1º Semestre A Vespertino'), 
	   (DEFAULT, '2º Semestre A Matutino'), 
	   (DEFAULT, '3º Semestre B Vespertino'), 
	   (DEFAULT, '4º Semestre B Vespertino'),
       (DEFAULT, '5º Semestre C Vespertino'),
       (DEFAULT, '6º Semestre C Vespertino');

-- ---------------------------------
-- INSERT INTO Departamento
-- ---------------------------------

INSERT INTO Departamento(idDepartamento, nome)
VALUES (DEFAULT, 'Física Moderna'),
       (DEFAULT, 'Transgenia'),
       (DEFAULT, 'Programação'),
       (DEFAULT, 'Química Nuclear'),
       (DEFAULT, 'Ciência Política'),
       (DEFAULT, 'Teorias Evolutivas');

-- ---------------------------------
-- INSERT INTO Disciplina
-- ---------------------------------

INSERT INTO Disciplina(idDisciplina, disciplina)
VALUES (DEFAULT, 'Genética'),
	   (DEFAULT, 'Bioquímica'),
       (DEFAULT, 'Ondulatória'),
       (DEFAULT, 'Antropologia'),
	   (DEFAULT, 'Agrometeorologia'),
       (DEFAULT, 'Arquitetura de Computadores');

-- ---------------------------------
-- INSERT INTO Instituicao
-- ---------------------------------

INSERT INTO Instituicao(idInstituicao, instituicao)
VALUES (DEFAULT, 'UEL'),
       (DEFAULT, 'UFBA'),
       (DEFAULT, 'IFBA'),
       (DEFAULT, 'UESC'),
       (DEFAULT, 'UFMA'),
       (DEFAULT, 'UNIFG');

-- ---------------------------------
-- INSERT INTO Exemplar
-- ---------------------------------

INSERT INTO Exemplar(idExemplar, exemplar)
VALUES (DEFAULT, 1),
	   (DEFAULT, 2),
       (DEFAULT, 3),
       (DEFAULT, 4),
       (DEFAULT, 5),
       (DEFAULT, 6);
	
-- ---------------------------------
-- INSERT INTO Tipo
-- ---------------------------------
    
INSERT INTO Tipo(idTipo, nome)
VALUES (DEFAULT, 'Livro'),
	   (DEFAULT, 'Periódico');

-- ---------------------------------
-- INSERT INTO Usuario
-- ---------------------------------

INSERT INTO Usuario(idUsuario, nome, cpf, dataNascimento, escolaridade, numeroUsuario, Endereco_idEndereco)
VALUES (DEFAULT, 'José Augusto', '0123456789', '1960-11-06', 'Ensino Superior Completo', '20220001', 1),
	   (DEFAULT, 'Tarsila Santos', '1234567890', '1970-12-05', 'Ensino Superior Completo', '20220002', 2),
       (DEFAULT, 'Riquelme Queirós', '2345678901', '1980-09-04', 'Ensino Superior Completo', '20220003', 3),
       (DEFAULT, 'Gustavo Alberto', '3456789012', '1990-04-13', 'Ensino Superior Incompleto', '20220004', 4),
       (DEFAULT, 'Josué Albuquerque', '4567890123', '2000-05-12', 'Ensino Superior Incompleto', '20220005', 5),
       (DEFAULT, 'Renato Silvano', '5678901234', '2010-06-11', 'Ensino Superior Incompleto', '20220006', 6);

-- ---------------------------------
-- INSERT INTO Estudante
-- ---------------------------------

INSERT INTO Estudante(idEstudante, numeroMatricula, anoIngresso, Usuario_idUsuario, Curso_idCurso)
VALUES (DEFAULT, '201015210001', '2010', 1, 1),
	   (DEFAULT, '201115210002', '2011', 2, 2);

-- ---------------------------------
-- INSERT INTO Professor
-- ---------------------------------

INSERT INTO Professor(idProfessor, titulacao, Disciplina_idDisciplina, Departamento_idDepartamento, Turma_idTurma, Usuario_idUsuario)
VALUES (DEFAULT, 'Graduado', 3, 3, 3, 3),
       (DEFAULT, 'Pós-Graduado', 4, 4, 4, 4);

-- ---------------------------------
-- INSERT INTO UsuarioEspecial
-- ---------------------------------

INSERT INTO UsuarioEspecial(idUsuarioEspecial, Usuario_idUsuario)
VALUES (DEFAULT, 5),
       (DEFAULT, 6);
       
-- ---------------------------------
-- INSERT INTO Obra
-- ---------------------------------
       
INSERT INTO Obra(idObra, nome, Exemplar_idExemplar, Tipo_idTipo)
VALUES (DEFAULT, 'Germinal', 1, 1),
	   (DEFAULT, 'Primo Basílio', 2, 1),
       (DEFAULT, 'Amor de Perdição', 3, 1),
       (DEFAULT, 'Quincas Borba', 4, 1),
       (DEFAULT, 'Crepúsculo', 5, 1),
       (DEFAULT, 'O Cortiço', 6, 1);

-- ---------------------------------
-- INSERT INTO Emprestimo
-- ---------------------------------

INSERT INTO Emprestimo(idEmprestimo, dataEmprestimo, dataDevolucao, numeroEmprestimo, vencimento, Usuario_idUsuario, Obra_idObra)
VALUES (DEFAULT, '2022-04-08', '2022-02-08', 4, TRUE, 1, 1),
	   (DEFAULT, '2022-12-08', '2022-03-08', 4, TRUE, 2, 2),
       (DEFAULT, '2022-10-08', '2023-10-03', 10, FALSE, 3, 3),
       (DEFAULT, '2022-10-08', '2023-10-03', 10, FALSE, 4, 4),
       (DEFAULT, '2022-03-08', '2022-10-08', 4, TRUE, 5, 5),
       (DEFAULT, '2022-03-08', '2022-10-08', 4, TRUE, 6, 6);

-- ---------------------------------
-- INSERT INTO Consulta
-- ---------------------------------

INSERT INTO Consulta(idConsulta, numeroConsulta, Usuario_idUsuario, Obra_idObra)
VALUES (DEFAULT, 5, 1, 1),
	   (DEFAULT, 10, 2, 2),
       (DEFAULT, 15, 3, 3),
       (DEFAULT, 20, 4, 4),
       (DEFAULT, 25, 5, 5),
       (DEFAULT, 30, 6, 6);

-- ---------------------------------
-- INSERT INTO Compra
-- ---------------------------------

INSERT INTO Compra(idCompra, Instituicao_idInstituicao, Obra_idObra)
VALUES (DEFAULT, 1, 1),
       (DEFAULT, 2, 2),
       (DEFAULT, 3, 3),
       (DEFAULT, 4, 4),
       (DEFAULT, 5, 5),
       (DEFAULT, 6, 6);
       
-- ---------------------------------
-- SELECT Endereco & Usuario
-- ---------------------------------
       
SELECT
	u.nome AS 'Nome do Usuário',
    u.cpf AS 'CPF',
    e.cep AS 'CEP',
    e.cidade AS 'Cidade',
    e.estado AS 'Estado',
    e.bairro AS 'Bairro',
	e.logradouro AS 'Logradouro',
    e.numero AS 'Número',
    e.complemento AS 'Complemento'
FROM Endereco e
INNER JOIN Usuario u
ON e.idEndereco = u.Endereco_idEndereco
ORDER BY u.nome ASC;

-- ----------------------------------
-- SELECT Curso, Estudante & Usuario
-- ----------------------------------

SELECT
	c.curso AS 'Nome do Curso',
    u.nome AS 'Nome do Estudante',
    e.numeroMatricula AS 'Matrícula do Estudante'
FROM Curso c
INNER JOIN Estudante e
ON e.Curso_idCurso = c.idCurso
INNER JOIN Usuario u
ON e.Usuario_idUsuario = u.idUsuario
ORDER BY c.curso ASC;

-- ------------------------------------------------
-- SELECT Turma, Professor, Departamento & Usuario
-- ------------------------------------------------

SELECT
	t.turma AS 'Turma',
    de.nome AS 'Departamento',
    di.disciplina AS 'Disciplina',
	u.nome AS 'Professor',
    p.titulacao AS 'Titulação'
FROM Turma t
INNER JOIN Professor p
ON p.Turma_idTurma = t.idTurma
INNER JOIN Departamento de
ON p.Departamento_idDepartamento = de.idDepartamento
INNER JOIN Disciplina di
ON p.Disciplina_idDisciplina = di.idDisciplina
INNER JOIN Usuario u
ON p.Usuario_idUsuario = u.idUsuario
ORDER BY t.turma ASC;

-- -------------------------------
-- SELECT Exemplar, Obra & Tipo
-- -------------------------------

SELECT
	o.nome AS 'Obra',
	e.exemplar AS 'Exemplar',
    t.nome AS 'Tipo'
FROM Exemplar e
INNER JOIN Obra o
ON o.Exemplar_idExemplar = e.idExemplar
INNER JOIN Tipo t
ON o.Tipo_idTipo = t.idTipo
ORDER BY o.nome ASC;

-- -----------------------------------
-- SELECT Obra, Compra & Instituicao
-- -----------------------------------

SELECT
	o.nome AS 'Obra',
    i.instituicao AS 'Instituição'
FROM Obra o
INNER JOIN Compra c
ON c.Obra_idObra = o.idObra
INNER JOIN Instituicao i
ON c.Instituicao_idInstituicao = i.idInstituicao
ORDER BY o.nome ASC;


-- ---------------------------------
-- SELECT Obra, Consulta & Usuario
-- ---------------------------------

SELECT
	c.numeroConsulta AS 'Número de Consultas',
    o.nome AS 'Obra',
    u.nome AS 'Usuário'
FROM Obra o
INNER JOIN Consulta c
ON c.Obra_idObra = o.idObra
INNER JOIN Usuario u
ON c.Usuario_idUsuario = idUsuario
ORDER BY c.numeroConsulta ASC;


-- -----------------------------------
-- SELECT Obra, Emprestimo & Usuario
-- -----------------------------------

SELECT
	e.dataEmprestimo AS 'Data de Empréstimo',
    e.dataDevolucao AS 'Data de Devolução',
    e.numeroEmprestimo AS 'Número de Empréstimos',
    e.vencimento AS 'Vencimento',
    o.nome AS 'Obra',
    u.nome AS 'Usuário'
FROM Obra o
INNER JOIN Emprestimo e
ON e.Obra_idObra = o.idObra
INNER JOIN Usuario u
ON e.Usuario_idUsuario = idUsuario
ORDER BY e.dataEmprestimo ASC;
