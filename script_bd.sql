-- DROPS DAS TABELAS

DROP TABLE IF EXISTS CLIENTE CASCADE;
DROP TABLE IF EXISTS MOTO CASCADE;
DROP TABLE IF EXISTS MOVIMENTACAO CASCADE;
DROP TABLE IF EXISTS PATIO CASCADE;
DROP TABLE IF EXISTS SETOR CASCADE;
DROP TABLE IF EXISTS VAGA CASCADE;
DROP TABLE IF EXISTS FUNCIONARIO CASCADE;
DROP TABLE IF EXISTS GERENTE CASCADE;
DROP TABLE IF EXISTS CARGO CASCADE;

-- TABELA CARGO
CREATE TABLE CARGO (
    id_cargo SERIAL PRIMARY KEY,
    nome_cargo VARCHAR(50) NOT NULL,
    descricao_cargo VARCHAR(255)
);

-- TABELA CLIENTE
CREATE TABLE CLIENTE (
    id_cliente SERIAL PRIMARY KEY,
    telefone_cliente VARCHAR(11) NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL,
    sexo_cliente CHAR(1) NOT NULL,
    email_cliente VARCHAR(100) NOT NULL,
    cpf_cliente VARCHAR(11) NOT NULL UNIQUE
);

-- TABELA PATIO
CREATE TABLE PATIO (
    id_patio SERIAL PRIMARY KEY,
    localizacao_patio VARCHAR(100) NOT NULL,
    nome_patio VARCHAR(100) NOT NULL,
    descricao_patio VARCHAR(255)
);

-- TABELA MOTO
CREATE TABLE MOTO (
    id_moto SERIAL PRIMARY KEY,
    placa_moto VARCHAR(7) UNIQUE,
    modelo_moto VARCHAR(70) NOT NULL,
    situacao_moto VARCHAR(50) NOT NULL,
    chassi_moto VARCHAR(17) NOT NULL UNIQUE,
    cliente_id_cliente INTEGER NULL,
    CONSTRAINT cliente_fk FOREIGN KEY (cliente_id_cliente) REFERENCES CLIENTE(id_cliente) ON DELETE SET NULL,
    CONSTRAINT chk_modelo_moto CHECK (
        modelo_moto IN ('Mottu Pop', 'Mottu Sport', 'Mottu-E')),
    CONSTRAINT chk_situacao_moto CHECK (
        situacao_moto IN ('Inativa', 'Ativa', 'Manutenção', 'Em Trânsito')
    )
);

-- TABELA SETOR
CREATE TABLE SETOR (
    id_setor SERIAL PRIMARY KEY,
    tipo_setor VARCHAR(70) NOT NULL,
    patio_id_patio INTEGER NOT NULL,
    status_setor VARCHAR(50) NOT NULL,
    CONSTRAINT patio_fk FOREIGN KEY (patio_id_patio) REFERENCES PATIO(id_patio) ON DELETE CASCADE,
    CONSTRAINT chk_tipo_setor CHECK (
        tipo_setor IN ('Pendência', 'Reparos Simples', 'Danos Estruturais Graves',
        'Motor Defeituoso', 'Agendada Para Manutenção', 'Pronta para Aluguel',
        'Sem Placa', 'Minha Mottu')
    ),
    CONSTRAINT chk_status_setor CHECK (
        status_setor IN ('Cheia', 'Parcial', 'Livre')
    )
);

-- TABELA VAGA
CREATE TABLE VAGA (
    id_vaga SERIAL PRIMARY KEY,
    numero_vaga VARCHAR(10) NOT NULL,
    status_ocupada SMALLINT DEFAULT 0 CHECK (status_ocupada IN (0, 1)) NOT NULL,
    setor_id_setor INTEGER NOT NULL,
    CONSTRAINT setor_fk_vaga FOREIGN KEY (setor_id_setor) REFERENCES SETOR(id_setor) ON DELETE CASCADE
);

-- TABELA MOVIMENTACAO 
CREATE TABLE MOVIMENTACAO (
    id_movimentacao SERIAL PRIMARY KEY,
    dt_entrada DATE NOT NULL,
    dt_saida DATE,
    descricao_movimentacao VARCHAR(255),
    moto_id_moto INTEGER NOT NULL,
    vaga_id_vaga INTEGER NOT NULL,
    CONSTRAINT moto_fk FOREIGN KEY (moto_id_moto) REFERENCES MOTO(id_moto) ON DELETE CASCADE,
    CONSTRAINT vaga_fk FOREIGN KEY (vaga_id_vaga) REFERENCES VAGA(id_vaga) ON DELETE CASCADE
);

-- TABELA FUNCIONARIO
CREATE TABLE FUNCIONARIO (
    id_funcionario SERIAL PRIMARY KEY,
    nome_funcionario VARCHAR(100) NOT NULL,
    telefone_funcionario VARCHAR(11) NOT NULL,
    cargo_id_cargo INTEGER NOT NULL,
    patio_id_patio INTEGER NOT NULL,
    CONSTRAINT cargo_fk_funcionario FOREIGN KEY (cargo_id_cargo) REFERENCES CARGO(id_cargo),
    CONSTRAINT patio_fk_funcionario FOREIGN KEY (patio_id_patio) REFERENCES PATIO(id_patio)
);

-- TABELA GERENTE
CREATE TABLE GERENTE (
    id_gerente SERIAL PRIMARY KEY,
    nome_gerente VARCHAR(100) NOT NULL,
    telefone_gerente VARCHAR(11) NOT NULL,
    cpf_gerente VARCHAR(11) NOT NULL UNIQUE,
    patio_id_patio INTEGER NOT NULL UNIQUE,
    CONSTRAINT patio_fk_gerente FOREIGN KEY (patio_id_patio) REFERENCES PATIO(id_patio)
);

-- INSERTS DE CARGO
INSERT INTO CARGO (nome_cargo, descricao_cargo) VALUES ('Auxiliar', 'Responsável por auxiliar nas tarefas gerais da empresa');
INSERT INTO CARGO (nome_cargo, descricao_cargo) VALUES ('Mecânico', 'Responsável por realizar reparos e manutenções em motos');
INSERT INTO CARGO (nome_cargo, descricao_cargo) VALUES ('Limpador', 'Responsável pela limpeza de áreas e veículos');
INSERT INTO CARGO (nome_cargo, descricao_cargo) VALUES ('Mecânico', 'Responsável por realizar reparos e manutenções em motos');
INSERT INTO CARGO (nome_cargo, descricao_cargo) VALUES ('Atendente', 'Atendimento ao cliente e suporte nas atividades da empresa');
INSERT INTO CARGO (nome_cargo, descricao_cargo) VALUES ('Supervisor', 'Responsável por supervisionar as atividades operacionais');
INSERT INTO CARGO (nome_cargo, descricao_cargo) VALUES ('Zelador', 'Responsável pela conservação e manutenção das instalações');
INSERT INTO CARGO (nome_cargo, descricao_cargo) VALUES ('Mecânico', 'Responsável por realizar reparos e manutenções em motos');

-- INSERTS DE CLIENTE
INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('11912345678', 'Carlos Silva', 'M', 'carlos@email.com', '12345678900');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('11987654321', 'Maria Souza', 'F', 'maria@email.com', '23456789011');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1188887777', 'João Mendes', 'M', 'joao@email.com', '34567890122');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1177776666', 'Ana Paula', 'F', 'ana@email.com', '45678901233');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1166665555', 'Bruno Rocha', 'M', 'bruno@email.com', '56789012344');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1155554444', 'Juliana Lima', 'F', 'juliana@email.com', '67890123455');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1144443333', 'Pedro Costa', 'M', 'pedro@email.com', '78901234566');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1133332222', 'Fernanda Alves', 'F', 'fernanda@email.com', '89012345677');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1121111111', 'Lucas Martins', 'M', 'lucas@email.com', '90123456788');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1122222222', 'Aline Pereira', 'F', 'aline@email.com', '91234567899');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1123333333', 'Diego Ramos', 'M', 'diego@email.com', '92345678900');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1124444444', 'Bianca Lopes', 'F', 'bianca@email.com', '93456789011');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1125555555', 'Thiago Nunes', 'M', 'thiago@email.com', '94567890122');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1126666666', 'Marina Dias', 'F', 'marina@email.com', '95678901233');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1127777777', 'Eduardo Cunha', 'M', 'eduardo@email.com', '96789012344');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1128888888', 'Paula Reis', 'F', 'paula@email.com', '97890123455');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1129999999', 'André Barros', 'M', 'andre@email.com', '98901234566');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1130000000', 'Camila Torres', 'F', 'camila@email.com', '99012345677');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1131111111', 'Fábio Ferreira', 'M', 'fabio@email.com', '90123456778');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1132222222', 'Letícia Monteiro', 'F', 'leticia@email.com', '91234567889');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1133333333', 'Rafael Duarte', 'M', 'rafael@email.com', '92345678990');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1134444444', 'Natalia Gomes', 'F', 'natalia@email.com', '93456789000');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1135555555', 'Vinícius Cardoso', 'M', 'vinicius@email.com', '94567890111');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1136666666', 'Tatiane Rocha', 'F', 'tatiane@email.com', '95678901222');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1137777777', 'Roberto Meireles', 'M', 'roberto@email.com', '96789012333');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1138888888', 'Adriana Passos', 'F', 'adriana@email.com', '97890123444');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1139999999', 'Marcelo Silva', 'M', 'marcelo@email.com', '98901234555');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1140000000', 'Daniela Moraes', 'F', 'daniela@email.com', '99012345666');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1141111111', 'Fernando Pires', 'M', 'fernando@email.com', '90123456779');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1142222222', 'Patrícia Braga', 'F', 'patricia@email.com', '91234567880');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1143333333', 'Henrique Leal', 'M', 'henrique@email.com', '92345678991');

INSERT INTO CLIENTE (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) 
VALUES ('1144444444', 'Juliane Castro', 'F', 'juliane@email.com', '93456789002');

-- INSERTS DE PATIO
INSERT INTO PATIO (localizacao_patio, nome_patio, descricao_patio) 
VALUES ('Zona Norte', 'Pátio Norte', 'Área ampla e coberta');

INSERT INTO PATIO (localizacao_patio, nome_patio, descricao_patio) 
VALUES ('Zona Sul', 'Pátio Sul', 'Coberto parcialmente');

INSERT INTO PATIO (localizacao_patio, nome_patio, descricao_patio) 
VALUES ('Zona Leste', 'Pátio Leste', 'Perto da oficina');

INSERT INTO PATIO (localizacao_patio, nome_patio, descricao_patio) 
VALUES ('Zona Oeste', 'Pátio Oeste', 'Com iluminação noturna');

INSERT INTO PATIO (localizacao_patio, nome_patio, descricao_patio) 
VALUES ('Centro', 'Pátio Central', 'Mais movimentado');

INSERT INTO PATIO (localizacao_patio, nome_patio, descricao_patio) 
VALUES ('Guarulhos', 'Pátio Aeroporto', 'Próximo ao aeroporto');

INSERT INTO PATIO (localizacao_patio, nome_patio, descricao_patio) 
VALUES ('Osasco', 'Pátio Osasco', 'Área externa');

INSERT INTO PATIO (localizacao_patio, nome_patio, descricao_patio) 
VALUES ('Santo André', 'Pátio ABC', 'Área nova');

-- INSERTS DE MOTO
INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('ABC1234', 'Mottu Pop', 'Em Trânsito', 'CHS12345678901234', 1);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('DEF5678', 'Mottu Sport', 'Em Trânsito', 'CHS22345678901234', 2);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('GHI9101', 'Mottu-E', 'Inativa', 'CHS32345678901234', 3);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('JKL2345', 'Mottu-E', 'Inativa', 'CHS42345678901234', 4);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('MNO6789', 'Mottu Pop', 'Em Trânsito', 'CHS52345678901234', 5);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('PQR1011', 'Mottu Sport', 'Em Trânsito', 'CHS62345678901234', 6);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('STU1213', 'Mottu Sport', 'Manutenção', 'CHS72345678901234', 7);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('VWX1415', 'Mottu Pop', 'Manutenção', 'CHS82345678901234', 8);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAA1111', 'Mottu Pop', 'Em Trânsito', 'CHS90000000000001', 9);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAB1112', 'Mottu-E', 'Em Trânsito', 'CHS90000000000002', 10);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAC1113', 'Mottu Sport', 'Manutenção', 'CHS90000000000003', 11);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAD2221', 'Mottu Pop', 'Manutenção', 'CHS90000000000004', 12);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAE2222', 'Mottu-E', 'Em Trânsito', 'CHS90000000000005', 13);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAF2223', 'Mottu Sport', 'Em Trânsito', 'CHS90000000000006', 14);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAG3331', 'Mottu-E', 'Manutenção', 'CHS90000000000007', 15);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAH3332', 'Mottu Pop', 'Manutenção', 'CHS90000000000008', 16);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAI3333', 'Mottu Sport', 'Em Trânsito', 'CHS90000000000009', 17);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAJ4441', 'Mottu-E', 'Em Trânsito', 'CHS90000000000010', 18);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAK4442', 'Mottu Pop', 'Inativa', 'CHS90000000000011', 19);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAL4443', 'Mottu Sport', 'Inativa', 'CHS90000000000012', 20);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAM5551', 'Mottu Sport', 'Em Trânsito', 'CHS90000000000013', 21);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAN5552', 'Mottu-E', 'Em Trânsito', 'CHS90000000000014', 22);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAO5553', 'Mottu Pop', 'Ativa', 'CHS90000000000015', 23);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAP6661', 'Mottu Sport', 'Ativa', 'CHS90000000000016', 24);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAQ6662', 'Mottu-E', 'Em Trânsito', 'CHS90000000000017', 25);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAR6663', 'Mottu Pop', 'Em Trânsito', 'CHS90000000000018', 26);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAS7771', 'Mottu Pop', 'Inativa', 'CHS90000000000019', 27);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAT7772', 'Mottu-E', 'Inativa', 'CHS90000000000020', 28);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAU7773', 'Mottu Sport', 'Em Trânsito', 'CHS90000000000021', 29);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAV8881', 'Mottu Sport', 'Em Trânsito', 'CHS90000000000022', 30);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAW8882', 'Mottu Pop', 'Ativa', 'CHS90000000000023', 31);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAX8883', 'Mottu-E', 'Ativa', 'CHS90000000000024', 32);

INSERT INTO MOTO (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) 
VALUES ('AAX8884', 'Mottu-E', 'Ativa', 'CHS90000000000025', 32);

-- INSERTS DE SETOR
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pendência', 1, 'Parcial');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Reparos Simples', 1, 'Parcial');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Danos Estruturais Graves', 1, 'Parcial');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Motor Defeituoso', 1, 'Parcial');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Agendada Para Manutenção', 1, 'Parcial');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pronta para Aluguel', 1, 'Parcial');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Sem Placa', 1, 'Parcial');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Minha Mottu', 1, 'Parcial');

INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pendência', 2, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Reparos Simples', 2, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Danos Estruturais Graves', 2, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Motor Defeituoso', 2, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Agendada Para Manutenção', 2, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pronta para Aluguel', 2, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Sem Placa', 2, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Minha Mottu', 2, 'Livre');

INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pendência', 3, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Reparos Simples', 3, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Danos Estruturais Graves', 3, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Motor Defeituoso', 3, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Agendada Para Manutenção', 3, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pronta para Aluguel', 3, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Sem Placa', 3, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Minha Mottu', 3, 'Livre');

INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pendência', 4, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Reparos Simples', 4, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Danos Estruturais Graves', 4, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Motor Defeituoso', 4, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Agendada Para Manutenção', 4, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pronta para Aluguel', 4, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Sem Placa', 4, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Minha Mottu', 4, 'Livre');

INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pendência', 5, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Reparos Simples', 5, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Danos Estruturais Graves', 5, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Motor Defeituoso', 5, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Agendada Para Manutenção', 5, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pronta para Aluguel', 5, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Sem Placa', 5, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Minha Mottu', 5, 'Livre');

INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pendência', 6, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Reparos Simples', 6, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Danos Estruturais Graves', 6, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Motor Defeituoso', 6, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Agendada Para Manutenção', 6, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pronta para Aluguel', 6, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Sem Placa', 6, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Minha Mottu', 6, 'Livre');

INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pendência', 7, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Reparos Simples', 7, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Danos Estruturais Graves', 7, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Motor Defeituoso', 7, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Agendada Para Manutenção', 7, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pronta para Aluguel', 7, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Sem Placa', 7, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Minha Mottu', 7, 'Livre');

INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pendência', 8, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Reparos Simples', 8, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Danos Estruturais Graves', 8, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Motor Defeituoso', 8, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Agendada Para Manutenção', 8, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Pronta para Aluguel', 8, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Sem Placa', 8, 'Livre');
INSERT INTO SETOR (tipo_setor, patio_id_patio, status_setor) VALUES ('Minha Mottu', 8, 'Livre');

-- INSERTS DE VAGA
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A1-V1', 0, 1);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A1-V2', 0, 1);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A1-V3', 1, 1);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A1-V4', 1, 1);

INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A2-V1', 0, 2);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A2-V2', 0, 2);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A2-V3', 1, 2);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A2-V4', 1, 2);

INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A3-V1', 0, 3);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A3-V2', 0, 3);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A3-V3', 1, 3);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A3-V4', 1, 3);

INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A4-V1', 0, 4);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A4-V2', 0, 4);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A4-V3', 1, 4);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A4-V4', 1, 4);

INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A5-V1', 0, 5);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A5-V2', 0, 5);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A5-V3', 1, 5);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A5-V4', 1, 5);

INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A6-V1', 0, 6);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A6-V2', 0, 6);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A6-V3', 1, 6);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A6-V4', 1, 6);

INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A7-V1', 0, 7);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A7-V2', 0, 7);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A7-V3', 1, 7);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A7-V4', 1, 7);

INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A8-V1', 0, 8);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A8-V2', 0, 8);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A8-V3', 1, 8);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A8-V4', 1, 8);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('A8-V5', 1, 8);

-- Pátio 2 (letra B), setores 9 a 16
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B1-V1', 0, 9); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B1-V2', 0, 9); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B1-V3', 0, 9);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B2-V1', 0, 10); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B2-V2', 0, 10); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B2-V3', 0, 10);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B3-V1', 0, 11); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B3-V2', 0, 11); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B3-V3', 0, 11);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B4-V1', 0, 12); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B4-V2', 0, 12); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B4-V3', 0, 12);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B5-V1', 0, 13); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B5-V2', 0, 13); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B5-V3', 0, 13);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B6-V1', 0, 14); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B6-V2', 0, 14); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B6-V3', 0, 14);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B7-V1', 0, 15); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B7-V2', 0, 15); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B7-V3', 0, 15);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B8-V1', 0, 16); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B8-V2', 0, 16); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('B8-V3', 0, 16);

-- Pátio 3 (letra C), setores 17 a 24
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C1-V1', 0, 17); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C1-V2', 0, 17); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C1-V3', 0, 17);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C2-V1', 0, 18); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C2-V2', 0, 18); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C2-V3', 0, 18);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C3-V1', 0, 19); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C3-V2', 0, 19); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C3-V3', 0, 19);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C4-V1', 0, 20); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C4-V2', 0, 20); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C4-V3', 0, 20);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C5-V1', 0, 21); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C5-V2', 0, 21); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C5-V3', 0, 21);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C6-V1', 0, 22); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C6-V2', 0, 22); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C6-V3', 0, 22);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C7-V1', 0, 23); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C7-V2', 0, 23); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C7-V3', 0, 23);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C8-V1', 0, 24); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C8-V2', 0, 24); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('C8-V3', 0, 24);

-- Pátio 4 (letra D), setores 25 a 32
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D1-V1', 0, 25); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D1-V2', 0, 25); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D1-V3', 0, 25);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D2-V1', 0, 26); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D2-V2', 0, 26); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D2-V3', 0, 26);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D3-V1', 0, 27); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D3-V2', 0, 27); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D3-V3', 0, 27);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D4-V1', 0, 28); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D4-V2', 0, 28); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D4-V3', 0, 28);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D5-V1', 0, 29); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D5-V2', 0, 29); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D5-V3', 0, 29);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D6-V1', 0, 30); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D6-V2', 0, 30);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D6-V3', 0, 30);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D7-V1', 0, 31); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D7-V2', 0, 31); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D7-V3', 0, 31);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D8-V1', 0, 32); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D8-V2', 0, 32); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('D8-V3', 0, 32);

-- Pátio 5 (letra E), setores 33 a 40
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E1-V1', 0, 33); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E1-V2', 0, 33); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E1-V3', 0, 33);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E2-V1', 0, 34); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E2-V2', 0, 34); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E2-V3', 0, 34);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E3-V1', 0, 35); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E3-V2', 0, 35); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E3-V3', 0, 35);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E4-V1', 0, 36); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E4-V2', 0, 36); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E4-V3', 0, 36);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E5-V1', 0, 37); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E5-V2', 0, 37); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E5-V3', 0, 37);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E6-V1', 0, 38); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E6-V2', 0, 38); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E6-V3', 0, 38);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E7-V1', 0, 39); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E7-V2', 0, 39); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E7-V3', 0, 39);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E8-V1', 0, 40); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E8-V2', 0, 40); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('E8-V3', 0, 40);

-- Pátio 6 (letra F), setores 41 a 48
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F1-V1', 0, 41); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F1-V2', 0, 41); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F1-V3', 0, 41);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F2-V1', 0, 42); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F2-V2', 0, 42); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F2-V3', 0, 42);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F3-V1', 0, 43); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F3-V2', 0, 43); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F3-V3', 0, 43);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F4-V1', 0, 44); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F4-V2', 0, 44); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F4-V3', 0, 44);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F5-V1', 0, 45); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F5-V2', 0, 45); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F5-V3', 0, 45);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F6-V1', 0, 46); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F6-V2', 0, 46); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F6-V3', 0, 46);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F7-V1', 0, 47); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F7-V2', 0, 47); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F7-V3', 0, 47);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F8-V1', 0, 48); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F8-V2', 0, 48); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('F8-V3', 0, 48);

-- Pátio 7 (letra G), setores 49 a 56
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G1-V1', 0, 49); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G1-V2', 0, 49); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G1-V3', 0, 49);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G2-V1', 0, 50); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G2-V2', 0, 50); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G2-V3', 0, 50);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G3-V1', 0, 51); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G3-V2', 0, 51); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G3-V3', 0, 51);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G4-V1', 0, 52); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G4-V2', 0, 52); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G4-V3', 0, 52);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G5-V1', 0, 53); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G5-V2', 0, 53); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G5-V3', 0, 53);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G6-V1', 0, 54); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G6-V2', 0, 54); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G6-V3', 0, 54);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G7-V1', 0, 55); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G7-V2', 0, 55); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G7-V3', 0, 55);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G8-V1', 0, 56); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G8-V2', 0, 56); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('G8-V3', 0, 56);

-- Pátio 8 (letra H), setores 57 a 64
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H1-V1', 0, 57); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H1-V2', 0, 57); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H1-V3', 0, 57);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H2-V1', 0, 58); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H2-V2', 0, 58); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H2-V3', 0, 58);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H3-V1', 0, 59); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H3-V2', 0, 59); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H3-V3', 0, 59);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H4-V1', 0, 60); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H4-V2', 0, 60); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H4-V3', 0, 60);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H5-V1', 0, 61); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H5-V2', 0, 61); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H5-V3', 0, 61);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H6-V1', 0, 62); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H6-V2', 0, 62); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H6-V3', 0, 62);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H7-V1', 0, 63);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H7-V2', 0, 63); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H7-V3', 0, 63);
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H8-V1', 0, 64); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H8-V2', 0, 64); 
INSERT INTO VAGA (numero_vaga, status_ocupada, setor_id_setor) VALUES ('H8-V3', 0, 64);

-- INSERTS DE MOVIMENTACAO
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-02', DATE '2025-01-03', 'Aguardando liberação', 1, 1);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-04', DATE '2025-01-05', 'Em análise documental', 2, 2);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-06', NULL, 'Aguardando vistoria', 3, 3);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-07', NULL, 'Pendência com cliente', 4, 4);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-08', DATE '2025-01-09', 'Revisão preventiva', 5, 5);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-10', DATE '2025-01-11', 'Troca de óleo', 6, 6);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-12', NULL, 'Troca de pneu', 7, 7);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-13', NULL, 'Correção de freio', 8, 8);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-14', DATE '2025-01-15', 'Colisão frontal', 9, 9);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-16', DATE '2025-01-17', 'Chassi danificado', 10, 10);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-18', NULL, 'Eixo empenado', 11, 11);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-19', NULL, 'Queda grave', 12, 12);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-20', DATE '2025-01-21', 'Problema de ignição', 13, 13);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-22', DATE '2025-01-23', 'Motor superaquecendo', 14, 14);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-24', NULL, 'Falha no motor', 15, 15);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-25', NULL, 'Vazamento de óleo', 16, 16);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-26', DATE '2025-01-27', 'Manutenção agendada', 17, 17);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-28', DATE '2025-01-29', 'Agendada para revisão', 18, 18);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-30', NULL, 'Revisão programada', 19, 19);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-01-31', NULL, 'Verificação agendada', 20, 20);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-02-01', DATE '2025-02-02', 'Liberada para uso', 21, 21);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-02-03', DATE '2025-02-04', 'Disponível', 22, 22);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-02-05', NULL, 'Disponível para locação', 23, 23);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-02-06', NULL, 'Pronta para retirada', 24, 24);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-02-07', DATE '2025-02-08', 'Sem placa na moto', 25, 25);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-02-09', DATE '2025-02-10', 'Placa removida', 26, 26);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-02-11', NULL, 'Moto sem identificação', 27, 27);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-02-12', NULL, 'Aguardando emplacamento', 28, 28);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-02-13', DATE '2025-02-14', 'Em uso por Mottu', 29, 29);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-02-15', DATE '2025-02-16', 'Reservada pela Mottu', 30, 30);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-02-17', NULL, 'Operação Mottu', 31, 31);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-02-18', NULL, 'Uso interno Mottu', 32, 32);
INSERT INTO MOVIMENTACAO (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES (DATE '2025-02-18', NULL, 'Uso interno Mottu', 33, 33);

-- INSERTS DE FUNCIONARIO
INSERT INTO FUNCIONARIO (nome_funcionario, telefone_funcionario, cargo_id_cargo, patio_id_patio) VALUES ('Ricardo Ramos', '11911112222', 1, 1);
INSERT INTO FUNCIONARIO (nome_funcionario, telefone_funcionario, cargo_id_cargo, patio_id_patio) VALUES ('Tatiane Luz', '11922223333', 2, 2);
INSERT INTO FUNCIONARIO (nome_funcionario, telefone_funcionario, cargo_id_cargo, patio_id_patio) VALUES ('Lucas Moraes', '11933334444', 3, 3);
INSERT INTO FUNCIONARIO (nome_funcionario, telefone_funcionario, cargo_id_cargo, patio_id_patio) VALUES ('Vanessa Souza', '11944445555', 4, 4);
INSERT INTO FUNCIONARIO (nome_funcionario, telefone_funcionario, cargo_id_cargo, patio_id_patio) VALUES ('Eduardo Lima', '11955556666', 5, 5);
INSERT INTO FUNCIONARIO (nome_funcionario, telefone_funcionario, cargo_id_cargo, patio_id_patio) VALUES ('Paula Teixeira', '11966667777', 6, 6);
INSERT INTO FUNCIONARIO (nome_funcionario, telefone_funcionario, cargo_id_cargo, patio_id_patio) VALUES ('Julio Santana', '11977778888', 7, 7);
INSERT INTO FUNCIONARIO (nome_funcionario, telefone_funcionario, cargo_id_cargo, patio_id_patio) VALUES ('Débora Mendes', '11988889999', 8, 8);

-- INSERTS DE GERENTE
INSERT INTO GERENTE (nome_gerente, telefone_gerente, cpf_gerente, patio_id_patio) VALUES ('Rodrigo Neves', '11900001111', '99999999900', 1);
INSERT INTO GERENTE (nome_gerente, telefone_gerente, cpf_gerente, patio_id_patio) VALUES ('Carla Pires', '11900002222', '88888888801', 2);
INSERT INTO GERENTE (nome_gerente, telefone_gerente, cpf_gerente, patio_id_patio) VALUES ('Fernando Lopes', '11900003333', '77777777702', 3);
INSERT INTO GERENTE (nome_gerente, telefone_gerente, cpf_gerente, patio_id_patio) VALUES ('Marina Dias', '11900004444', '66666666603', 4);
INSERT INTO GERENTE (nome_gerente, telefone_gerente, cpf_gerente, patio_id_patio) VALUES ('Bruno Araújo', '11900005555', '55555555504', 5);
INSERT INTO GERENTE (nome_gerente, telefone_gerente, cpf_gerente, patio_id_patio) VALUES ('Isabela Freitas', '11900006666', '44444444405', 6);
INSERT INTO GERENTE (nome_gerente, telefone_gerente, cpf_gerente, patio_id_patio) VALUES ('Tiago Faria', '11900007777', '33333333306', 7);
INSERT INTO GERENTE (nome_gerente, telefone_gerente, cpf_gerente, patio_id_patio) VALUES ('Luciana Prado', '11900008888', '22222222207', 8);

commit;