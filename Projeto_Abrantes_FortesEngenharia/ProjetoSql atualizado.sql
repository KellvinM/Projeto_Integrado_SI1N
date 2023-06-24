--Criação do conteudo do banco de dados;

CREATE SEQUENCE talento_id_seq;

--Criação da tabela Talento e suas colunas;

CREATE TABLE TALENTO (
                Id NUMERIC(9)             NOT NULL    DEFAULT nextval('talento_id_seq'),
                descricao VARCHAR(255)    NOT NULL,
                CONSTRAINT talento_pk     PRIMARY KEY (Id)
);

--Comentarios da tabela Talento e de suas respectivas colunas;

COMMENT ON TABLE TALENTO            IS  'Tabela de talentos de cada funcionário.';
COMMENT ON COLUMN TALENTO.Id        IS  'Identificador da tabela de TALENTO.';
COMMENT ON COLUMN TALENTO.descricao IS  'Descrição do talento.';


ALTER SEQUENCE talento_id_seq OWNED BY TALENTO.Id;

--Criação da tabela Departamento e suas colunas;

CREATE TABLE DEPARTAMENTO (
                Id_departamento NUMERIC(9)  NOT NULL,
                nome VARCHAR(255)           NOT NULL,
                CONSTRAINT departamento_pk  PRIMARY KEY (Id_departamento)
);

--Comentarios da tabela Departamento e de suas respectivas colunas;

COMMENT ON TABLE DEPARTAMENTO                  IS 'Tabela de departamentos.';
COMMENT ON COLUMN DEPARTAMENTO.Id_departamento IS 'Identificador do departamento.';
COMMENT ON COLUMN DEPARTAMENTO.nome            IS 'Nome do departamento.';


CREATE SEQUENCE vaga_id_seq;

--Criação da tabela Vaga e suas colunas;

CREATE TABLE VAGA (
                Id NUMERIC(9)               NOT NULL    DEFAULT nextval('vaga_id_seq'),
                descricao VARCHAR(255)      NOT NULL,
                requisitos VARCHAR(255)     NOT NULL,
                situacao VARCHAR(50)        NOT NULL,
                idDepartamento NUMERIC(9)   NOT NULL,
                CONSTRAINT vaga_pk          PRIMARY KEY (Id)
);

--Comentarios da tabela Vaga e de suas respectivas colunas;

COMMENT ON TABLE VAGA                 IS 'Tabela de vagas de candidatura.';
COMMENT ON COLUMN VAGA.Id             IS 'Identificador da tabela de vagas.';
COMMENT ON COLUMN VAGA.descricao      IS 'Descrição da vaga.';
COMMENT ON COLUMN VAGA.requisitos     IS 'Requisitos para candidatura da vaga.';
COMMENT ON COLUMN VAGA.situacao       IS 'Situação da vaga.';
COMMENT ON COLUMN VAGA.idDepartamento IS 'Identificador do Departamento requisitante da vaga.';


ALTER SEQUENCE vaga_id_seq OWNED BY VAGA.Id;

--Criação da tabela Funcionario e suas colunas;

CREATE TABLE FUNCIONARIO (
                Id NUMERIC(9)               NOT NULL,
                nome VARCHAR(255)           NOT NULL,
                email VARCHAR(255)          NOT NULL,
                cargo VARCHAR(150)          NOT NULL,
                id_departamento NUMERIC(9)  NOT NULL,
                CONSTRAINT funcionario_pk   PRIMARY KEY (Id)
);

--Comentarios da tabela Funcionario e de suas respectivas colunas;

COMMENT ON COLUMN FUNCIONARIO.Id              IS 'Identificador único do funcionário';
COMMENT ON COLUMN FUNCIONARIO.nome            IS 'Nome do funcionário assim com no seu RG.';
COMMENT ON COLUMN FUNCIONARIO.email           IS 'Email do funcionário.';
COMMENT ON COLUMN FUNCIONARIO.cargo           IS 'Cargo do funcionário.';
COMMENT ON COLUMN FUNCIONARIO.id_departamento IS 'Identificador do departamento do funcionário, FK da tabela departamento.';


--Criação da tabela Talento_Funcionario e suas colunas;

CREATE TABLE TALENTO_FUNCIONARIO (
                idFuncionario NUMERIC(9)    NOT NULL,
                idTalento NUMERIC(9)        NOT NULL,
                dataCadastro DATE           NOT NULL,
                CONSTRAINT pk               PRIMARY KEY (idFuncionario, idTalento)
);

--Comentarios da tabela Talento_Funcionario e de suas respectivas colunas;

COMMENT ON TABLE TALENTO_FUNCIONARIO                  IS 'Tabela intermediária para cada talento de cada funcionário.';
COMMENT ON COLUMN TALENTO_FUNCIONARIO.idFuncionario   IS 'Identificador do funcionário, FK da tabela FUNCIONARIO.';
COMMENT ON COLUMN TALENTO_FUNCIONARIO.idTalento       IS 'Identificador do talento, FK da tabela TALENTO.';
COMMENT ON COLUMN TALENTO_FUNCIONARIO.dataCadastro    IS 'Data de cadastro do talento.';

--Criação da tabela Vaga_Candidato e suas colunas;

CREATE TABLE VAGA_CANDIDATO (
                IdFuncionario NUMERIC(9)     NOT NULL,
                idVaga NUMERIC(9)            NOT NULL,
                dataCandidatura DATE         NOT NULL,
                CONSTRAINT vaga_candidato_pk PRIMARY KEY (IdFuncionario, idVaga)
);

--Comentarios da tabela Vaga_Candidato e de suas respectivas colunas;

COMMENT ON TABLE VAGA_CANDIDATO                    IS 'Tabela para cada funcionario candidatado em uma vaga.';
COMMENT ON COLUMN VAGA_CANDIDATO.IdFuncionario     IS 'Identificador do funcionário, FK da tabela FUNCIONARIO.';
COMMENT ON COLUMN VAGA_CANDIDATO.idVaga            IS 'Identificador da vaga, FK da tabela VAGA.';
COMMENT ON COLUMN VAGA_CANDIDATO.dataCandidatura   IS 'Data da candidatura do funcionário dentro da vaga.';


--Criação da tabela Telefone e suas colunas;

CREATE TABLE TELEFONE (
                Id NUMERIC(9)                NOT NULL,
                DDD VARCHAR(3)               NOT NULL,
                numero VARCHAR(9)            NOT NULL,
                idFuncionario NUMERIC(9)     NOT NULL,
                CONSTRAINT telefone_pk       PRIMARY KEY (Id)
);

--Comentarios da tabela Telefone e de suas respectivas colunas;

COMMENT ON TABLE TELEFONE                  IS 'Tabela de telefone do usuário.';
COMMENT ON COLUMN TELEFONE.Id              IS 'Identificador do telefone.';
COMMENT ON COLUMN TELEFONE.DDD             IS 'Campo de DDD do telefone.';
COMMENT ON COLUMN TELEFONE.numero          IS 'Numero do telefone.';
COMMENT ON COLUMN TELEFONE.idFuncionario   IS 'Identificador do funcionario dentro de telefone, FK da tabela de funcionário.';


ALTER TABLE TALENTO_FUNCIONARIO ADD CONSTRAINT talento_talento_funcionario_fk
FOREIGN KEY (idTalento)
REFERENCES TALENTO (Id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE FUNCIONARIO ADD CONSTRAINT departamento_funcionario_fk
FOREIGN KEY (id_departamento)
REFERENCES DEPARTAMENTO (Id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE VAGA ADD CONSTRAINT departamento_vaga_fk
FOREIGN KEY (idDepartamento)
REFERENCES DEPARTAMENTO (Id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE VAGA_CANDIDATO ADD CONSTRAINT vaga_vaga_candidato_fk
FOREIGN KEY (idVaga)
REFERENCES VAGA (Id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE TELEFONE ADD CONSTRAINT funcionario_telefone_fk
FOREIGN KEY (idFuncionario)
REFERENCES FUNCIONARIO (Id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE VAGA_CANDIDATO ADD CONSTRAINT funcionario_vaga_candidato_fk
FOREIGN KEY (IdFuncionario)
REFERENCES FUNCIONARIO (Id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE TALENTO_FUNCIONARIO ADD CONSTRAINT funcionario_talento_funcionario_fk
FOREIGN KEY (idFuncionario)
REFERENCES FUNCIONARIO (Id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
