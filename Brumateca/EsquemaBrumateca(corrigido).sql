DROP SCHEMA IF EXISTS Brumateca;

CREATE SCHEMA Brumateca
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci; 

USE Brumateca;

CREATE TABLE Endereco (
    idEndereco	INT 			NOT NULL 	PRIMARY KEY 	AUTO_INCREMENT,
    cep 		VARCHAR(45) 	NOT NULL,
    cidade 		VARCHAR(45) 	NOT NULL,
    estado 		VARCHAR(45) 	NOT NULL,
    bairro 		VARCHAR(45) 	NOT NULL,
    logradouro 	VARCHAR(45) 	NOT NULL,
    numero 		VARCHAR(6) 		NOT NULL,
    complemento VARCHAR(45) 	NOT NULL
) DEFAULT CHARSET = utf8;
DESCRIBE Endereco;


DROP TABLE IF EXISTS Usuario;
CREATE TABLE Usuario(
	idUsuario 			INT 			NOT NULL 	PRIMARY KEY 	AUTO_INCREMENT,
    nome 				VARCHAR(45) 	NOT NULL,
    cpf 				VARCHAR(11) 	NOT NULL 	UNIQUE,
    dataNascimento 		DATE 			NOT NULL,
    escolaridade 		VARCHAR(45) 	NOT NULL,
    numeroUsuario 		VARCHAR(45) 	NOT NULL,
    usuarioEspecial		TINYINT			NOT NULL,
    Endereco_idEndereco INT 			NOT NULL,
    FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco(idEndereco)
) DEFAULT CHARSET = utf8;
DESCRIBE Usuario;


DROP TABLE IF EXISTS Estudante;
CREATE TABLE Estudante(
	idEstudante 		INT 		NOT NULL 	PRIMARY KEY 	AUTO_INCREMENT,
    numeroMatricula 	VARCHAR(15) NOT NULL 	UNIQUE,
    anoIngresso 		YEAR 		NOT NULL,
    maximoLivros		INT			NOT NULL,
    maximoDias			INT			NOT NULL,
    Usuario_idUsuario 	INT 		NOT NULL,
    FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario(idUsuario)
) DEFAULT CHARSET = utf8;
DESCRIBE Estudante;


DROP TABLE IF EXISTS Curso;
CREATE TABLE Curso(
	idCurso 	INT 		NOT NULL 	PRIMARY KEY 	AUTO_INCREMENT,
    nome 		VARCHAR(45) NOT NULL 	UNIQUE
) DEFAULT CHARSET = utf8;
DESCRIBE Curso;


DROP TABLE IF EXISTS Estudante_tem_Curso;
CREATE TABLE Estudante_tem_Curso(
	Estudante_idEstudante INT NOT NULL,
    Curso_idCurso		  INT NOT NULL,
    FOREIGN KEY (Estudante_idEstudante) REFERENCES Estudante(idEstudante),
    FOREIGN KEY (Curso_idCurso) REFERENCES Curso(idCurso)
); 
DESCRIBE Estudante_tem_Curso;


DROP TABLE IF EXISTS Departamento;
CREATE TABLE Departamento(
	idDepartamento INT 			NOT NULL 	PRIMARY KEY 	AUTO_INCREMENT,
    nome 		   VARCHAR(45)	NOT NULL 	UNIQUE
) DEFAULT CHARSET = utf8;
DESCRIBE Departamento;


DROP TABLE IF EXISTS Professor;
CREATE TABLE Professor(
	idProfessor 					INT 		NOT NULL 	PRIMARY KEY 	AUTO_INCREMENT,
    titulacao 						VARCHAR(45) NOT NULL,
    maximoLivros					INT			NOT NULL,
    maximoDias						INT			NOT NULL,
    Usuario_idUsuario 				INT 		NOT NULL,
    Departamento_idDepartamento 	INT 		NOT NULL,
	FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario(idUsuario),
    FOREIGN KEY (Departamento_idDepartamento) REFERENCES Departamento(idDepartamento)
) DEFAULT CHARSET = utf8;
DESCRIBE Professor;


DROP TABLE IF EXISTS Turma;
CREATE TABLE Turma(
	idTurma 	INT 		NOT NULL 	PRIMARY 	KEY AUTO_INCREMENT,
    nome		VARCHAR(45) NOT NULL 	UNIQUE
) DEFAULT CHARSET = utf8;
DESCRIBE Turma;


DROP TABLE IF EXISTS Disciplina;
CREATE TABLE Disciplina(
	idDisciplina 	INT 		NOT NULL 	PRIMARY KEY 	AUTO_INCREMENT,
    nome 			VARCHAR(45) NOT NULL 	UNIQUE
) DEFAULT CHARSET = utf8;
DESCRIBE Disciplina;


DROP TABLE IF EXISTS Professor_tem_turma;
CREATE TABLE Professor_tem_turma(
	Professor_idProfessor 	INT 	NOT NULL,
    Turma_idTurma 			INT 	NOT NULL,
	FOREIGN KEY (Professor_idProfessor) REFERENCES Professor(idProfessor ),
	FOREIGN KEY (Turma_idTurma) REFERENCES Turma(idTurma)
);
DESCRIBE Professor_tem_turma;


DROP TABLE IF EXISTS Turma_tem_disciplina;
CREATE TABLE Turma_tem_disciplina(
	Turma_idTurma 			INT 	NOT NULL,
    Disciplina_idDisciplina INT 	NOT NULL,
    FOREIGN KEY (Turma_idTurma) REFERENCES Turma(idTurma),
    FOREIGN KEY (Disciplina_idDisciplina) REFERENCES  Disciplina(idDisciplina)
);
DESCRIBE Turma_tem_disciplina;


DROP TABLE IF EXISTS Obra;
CREATE TABLE Obra(
	idObra 			INT 		NOT NULL 	PRIMARY KEY 	AUTO_INCREMENT,
    nome 			VARCHAR(45) NOT NULL,
    verificadorObra TINYINT 	NOT NULL
) DEFAULT CHARSET = utf8;
DESCRIBE Obra;


DROP TABLE IF EXISTS Exemplar;
CREATE TABLE Exemplar(
	idExemplar 	   INT 	NOT NULL 	PRIMARY KEY 	AUTO_INCREMENT,
	numeroExemplar INT 	NOT NULL,
    Obra_idObra	   INT  NOT NULL,
    FOREIGN KEY (Obra_idObra) REFERENCES Obra(idObra)
) DEFAULT CHARSET = utf8;
DESCRIBE Exemplar;


DROP TABLE IF EXISTS Consulta;
CREATE TABLE Consulta(
	idConsulta 			  INT 		NOT NULL 	PRIMARY KEY 	AUTO_INCREMENT,
    numeroConsulta 		  INT 		NOT NULL,
    verificadorEmprestimo TINYINT 	NOT NULL,
    dataEmprestimo 		  DATE 		NOT NULL,
    dataDevolucao 		  DATE 		NOT NULL,
    numeroEmprestimo      INT 		NOT NULL,
    vencimento            TINYINT 	NOT NULL,
    Exemplar_idExemplar   INT 		NOT NULL,
    Usuario_idUsuario     INT 		NOT NULL,
    FOREIGN KEY (Exemplar_idExemplar) REFERENCES ExemplaR(idExemplar),
    FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario(idUsuario)
);
DESCRIBE Consulta;