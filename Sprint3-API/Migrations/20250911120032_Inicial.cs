using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Sprint3_API.Migrations
{
    /// <inheritdoc />
    public partial class Inicial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "CARGO",
                columns: table => new
                {
                    ID_CARGO = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    NOME_CARGO = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    DESCRICAO_CARGO = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CARGO", x => x.ID_CARGO);
                });

            migrationBuilder.Sql(@"
                INSERT INTO ""CARGO"" (""NOME_CARGO"", ""DESCRICAO_CARGO"") VALUES
                ('Auxiliar', 'Responsável por auxiliar nas tarefas gerais da empresa.'),
                ('Mecânico', 'Responsável por realizar reparos e manutenções em motos.'),
                ('Limpador', 'Responsável pela limpeza de áreas e veículos.'),
                ('Mecânico', 'Responsável por realizar reparos e manutenções em motos.'),
                ('Atendente', 'Atendimento ao cliente e suporte nas atividades da empresa.'),
                ('Supervisor', 'Responsável por supervisionar as atividades operacionais.'),
                ('Zelador', 'Responsável pela conservação e manutenção das instalações.'),
                ('Mecânico', 'Responsável por realizar reparos e manutenções em motos.');
            ");


            migrationBuilder.CreateTable(
                name: "CLIENTE",
                columns: table => new
                {
                    ID_CLIENTE = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    TELEFONE_CLIENTE = table.Column<string>(type: "character varying(11)", maxLength: 11, nullable: false),
                    NOME_CLIENTE = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    SEXO_CLIENTE = table.Column<char>(type: "character(1)", maxLength: 1, nullable: false),
                    EMAIL_CLIENTE = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    CPF_CLIENTE = table.Column<string>(type: "character varying(11)", maxLength: 11, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CLIENTE", x => x.ID_CLIENTE);
                });
            
            migrationBuilder.Sql(@"
                INSERT INTO ""CLIENTE"" (""TELEFONE_CLIENTE"", ""NOME_CLIENTE"", ""SEXO_CLIENTE"", ""EMAIL_CLIENTE"", ""CPF_CLIENTE"") VALUES
                ('11912345678', 'Carlos Silva', 'M', 'carlos@email.com', '12345678900'),
                ('11987654321', 'Maria Souza', 'F', 'maria@email.com', '23456789011'),
                ('1188887777', 'João Mendes', 'M', 'joao@email.com', '34567890122'),
                ('1177776666', 'Ana Paula', 'F', 'ana@email.com', '45678901233'),
                ('1166665555', 'Bruno Rocha', 'M', 'bruno@email.com', '56789012344'),
                ('1155554444', 'Juliana Lima', 'F', 'juliana@email.com', '67890123455'),
                ('1144443333', 'Pedro Costa', 'M', 'pedro@email.com', '78901234566'),
                ('1133332222', 'Fernanda Alves', 'F', 'fernanda@email.com', '89012345677'),
                ('1121111111', 'Lucas Martins', 'M', 'lucas@email.com', '90123456788'),
                ('1122222222', 'Aline Pereira', 'F', 'aline@email.com', '91234567899'),
                ('1123333333', 'Diego Ramos', 'M', 'diego@email.com', '92345678900'),
                ('1124444444', 'Bianca Lopes', 'F', 'bianca@email.com', '93456789011'),
                ('1125555555', 'Thiago Nunes', 'M', 'thiago@email.com', '94567890122'),
                ('1126666666', 'Marina Dias', 'F', 'marina@email.com', '95678901233'),
                ('1127777777', 'Eduardo Cunha', 'M', 'eduardo@email.com', '96789012344'),
                ('1128888888', 'Paula Reis', 'F', 'paula@email.com', '97890123455'),
                ('1129999999', 'André Barros', 'M', 'andre@email.com', '98901234566'),
                ('1130000000', 'Camila Torres', 'F', 'camila@email.com', '99012345677'),
                ('1131111111', 'Fábio Ferreira', 'M', 'fabio@email.com', '90123456778'),
                ('1132222222', 'Letícia Monteiro', 'F', 'leticia@email.com', '91234567889'),
                ('1133333333', 'Rafael Duarte', 'M', 'rafael@email.com', '92345678990'),
                ('1134444444', 'Natalia Gomes', 'F', 'natalia@email.com', '93456789000'),
                ('1135555555', 'Vinícius Cardoso', 'M', 'vinicius@email.com', '94567890111'),
                ('1136666666', 'Tatiane Rocha', 'F', 'tatiane@email.com', '95678901222'),
                ('1137777777', 'Roberto Meireles', 'M', 'roberto@email.com', '96789012333'),
                ('1138888888', 'Adriana Passos', 'F', 'adriana@email.com', '97890123444'),
                ('1139999999', 'Marcelo Silva', 'M', 'marcelo@email.com', '98901234555'),
                ('1140000000', 'Daniela Moraes', 'F', 'daniela@email.com', '99012345666'),
                ('1141111111', 'Fernando Pires', 'M', 'fernando@email.com', '90123456779'),
                ('1142222222', 'Patrícia Braga', 'F', 'patricia@email.com', '91234567880'),
                ('1143333333', 'Henrique Leal', 'M', 'henrique@email.com', '92345678991'),
                ('1144444444', 'Juliane Castro', 'F', 'juliane@email.com', '93456789002');
            ");
            
            migrationBuilder.CreateTable(
                name: "PATIO",
                columns: table => new
                {
                    ID_PATIO = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    LOCALIZACAO_PATIO = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    NOME_PATIO = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    DESCRICAO_PATIO = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PATIO", x => x.ID_PATIO);
                });
            
            migrationBuilder.Sql(@"
                INSERT INTO ""PATIO"" (""LOCALIZACAO_PATIO"", ""NOME_PATIO"", ""DESCRICAO_PATIO"") VALUES
                ('Zona Norte', 'Pátio Norte', 'Área ampla e coberta'),
                ('Zona Sul', 'Pátio Sul', 'Coberto parcialmente'),
                ('Zona Leste', 'Pátio Leste', 'Perto da oficina'),
                ('Zona Oeste', 'Pátio Oeste', 'Com iluminação noturna'),
                ('Centro', 'Pátio Central', 'Mais movimentado'),
                ('Guarulhos', 'Pátio Aeroporto', 'Próximo ao aeroporto'),
                ('Osasco', 'Pátio Osasco', 'Área externa'),
                ('Santo André', 'Pátio ABC', 'Área nova');
            ");

            migrationBuilder.CreateTable(
                name: "MOTO",
                columns: table => new
                {
                    ID_MOTO = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PLACA_MOTO = table.Column<string>(type: "character varying(7)", maxLength: 7, nullable: true),
                    MODELO_MOTO = table.Column<string>(type: "character varying(70)", maxLength: 70, nullable: false),
                    SITUACAO_MOTO = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    CHASSI_MOTO = table.Column<string>(type: "character varying(17)", maxLength: 17, nullable: false),
                    CLIENTE_ID_CLIENTE = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MOTO", x => x.ID_MOTO);
                    table.ForeignKey(
                        name: "CLIENTE_FK",
                        column: x => x.CLIENTE_ID_CLIENTE,
                        principalTable: "CLIENTE",
                        principalColumn: "ID_CLIENTE",
                        onDelete: ReferentialAction.SetNull);
                });

            migrationBuilder.Sql(
                "ALTER TABLE \"MOTO\" ADD CONSTRAINT CHK_MODELO_MOTO CHECK (\"MODELO_MOTO\" IN ('Mottu Pop', 'Mottu Sport', 'Mottu-E'))"
            );

            migrationBuilder.Sql(
                "ALTER TABLE \"MOTO\" ADD CONSTRAINT CHK_SITUACAO_MOTO CHECK (\"SITUACAO_MOTO\" IN ('Inativa', 'Ativa', 'Manutenção', 'Em Trânsito'))"
            );
            
            migrationBuilder.Sql(@"
                INSERT INTO ""MOTO"" (""PLACA_MOTO"", ""MODELO_MOTO"", ""SITUACAO_MOTO"", ""CHASSI_MOTO"", ""CLIENTE_ID_CLIENTE"") VALUES
                ('ABC1234', 'Mottu Pop', 'Em Trânsito', 'CHS12345678901234', 1),
                ('DEF5678', 'Mottu Sport', 'Em Trânsito', 'CHS22345678901234', 2),
                ('GHI9101', 'Mottu-E', 'Inativa', 'CHS32345678901234', 3),
                ('JKL2345', 'Mottu-E', 'Inativa', 'CHS42345678901234', 4),
                ('MNO6789', 'Mottu Pop', 'Em Trânsito', 'CHS52345678901234', 5),
                ('PQR1011', 'Mottu Sport', 'Em Trânsito', 'CHS62345678901234', 6),
                ('STU1213', 'Mottu Sport', 'Manutenção', 'CHS72345678901234', 7),
                ('VWX1415', 'Mottu Pop', 'Manutenção', 'CHS82345678901234', 8),
                ('AAA1111', 'Mottu Pop', 'Em Trânsito', 'CHS90000000000001', 9),
                ('AAB1112', 'Mottu-E', 'Em Trânsito', 'CHS90000000000002', 10),
                ('AAC1113', 'Mottu Sport', 'Manutenção', 'CHS90000000000003', 11),
                ('AAD2221', 'Mottu Pop', 'Manutenção', 'CHS90000000000004', 12),
                ('AAE2222', 'Mottu-E', 'Em Trânsito', 'CHS90000000000005', 13),
                ('AAF2223', 'Mottu Sport', 'Em Trânsito', 'CHS90000000000006', 14),
                ('AAG3331', 'Mottu-E', 'Manutenção', 'CHS90000000000007', 15),
                ('AAH3332', 'Mottu Pop', 'Manutenção', 'CHS90000000000008', 16),
                ('AAI3333', 'Mottu Sport', 'Em Trânsito', 'CHS90000000000009', 17),
                ('AAJ4441', 'Mottu-E', 'Em Trânsito', 'CHS90000000000010', 18),
                ('AAK4442', 'Mottu Pop', 'Inativa', 'CHS90000000000011', 19),
                ('AAL4443', 'Mottu Sport', 'Inativa', 'CHS90000000000012', 20),
                ('AAM5551', 'Mottu Sport', 'Em Trânsito', 'CHS90000000000013', 21),
                ('AAN5552', 'Mottu-E', 'Em Trânsito', 'CHS90000000000014', 22),
                ('AAO5553', 'Mottu Pop', 'Ativa', 'CHS90000000000015', 23),
                ('AAP6661', 'Mottu Sport', 'Ativa', 'CHS90000000000016', 24),
                ('AAQ6662', 'Mottu-E', 'Em Trânsito', 'CHS90000000000017', 25),
                ('AAR6663', 'Mottu Pop', 'Em Trânsito', 'CHS90000000000018', 26),
                ('AAS7771', 'Mottu Pop', 'Inativa', 'CHS90000000000019', 27),
                ('AAT7772', 'Mottu-E', 'Inativa', 'CHS90000000000020', 28),
                ('AAU7773', 'Mottu Sport', 'Em Trânsito', 'CHS90000000000021', 29),
                ('AAV8881', 'Mottu Sport', 'Em Trânsito', 'CHS90000000000022', 30),
                ('AAW8882', 'Mottu Pop', 'Ativa', 'CHS90000000000023', 31),
                ('AAX8883', 'Mottu-E', 'Ativa', 'CHS90000000000024', 32),
                ('AAX8884', 'Mottu-E', 'Ativa', 'CHS90000000000025', 32);
            ");
            
            migrationBuilder.CreateTable(
                name: "FUNCIONARIO",
                columns: table => new
                {
                    ID_FUNCIONARIO = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    NOME_FUNCIONARIO = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    TELEFONE_FUNCIONARIO = table.Column<string>(type: "character varying(11)", maxLength: 11, nullable: false),
                    CARGO_ID_CARGO = table.Column<int>(type: "integer", nullable: false),
                    PATIO_ID_PATIO = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FUNCIONARIO", x => x.ID_FUNCIONARIO);
                    table.ForeignKey(
                        name: "CARGO_FK_FUNCIONARIO",
                        column: x => x.CARGO_ID_CARGO,
                        principalTable: "CARGO",
                        principalColumn: "ID_CARGO",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "PATIO_FK_FUNCIONARIO",
                        column: x => x.PATIO_ID_PATIO,
                        principalTable: "PATIO",
                        principalColumn: "ID_PATIO",
                        onDelete: ReferentialAction.Cascade);
                });
            
            migrationBuilder.Sql(@"
                INSERT INTO ""FUNCIONARIO"" (""NOME_FUNCIONARIO"", ""TELEFONE_FUNCIONARIO"", ""CARGO_ID_CARGO"", ""PATIO_ID_PATIO"") VALUES
                ('Ricardo Ramos', '11911112222', 1, 1),
                ('Tatiane Luz', '11922223333', 2, 2),
                ('Lucas Moraes', '11933334444', 3, 3),
                ('Vanessa Souza', '11944445555', 4, 4),
                ('Eduardo Lima', '11955556666', 5, 5),
                ('Paula Teixeira', '11966667777', 6, 6),
                ('Julio Santana', '11977778888', 7, 7),
                ('Débora Mendes', '11988889999', 8, 8);
            ");

            migrationBuilder.CreateTable(
                name: "GERENTE",
                columns: table => new
                {
                    ID_GERENTE = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    NOME_GERENTE = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    TELEFONE_GERENTE = table.Column<string>(type: "character varying(11)", maxLength: 11, nullable: false),
                    CPF_GERENTE = table.Column<string>(type: "character varying(11)", maxLength: 11, nullable: false),
                    PATIO_ID_PATIO = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_GERENTE", x => x.ID_GERENTE);
                    table.ForeignKey(
                        name: "PATIO_FK_GERENTE",
                        column: x => x.PATIO_ID_PATIO,
                        principalTable: "PATIO",
                        principalColumn: "ID_PATIO",
                        onDelete: ReferentialAction.Cascade);
                });
            
            migrationBuilder.Sql(@"
                INSERT INTO ""GERENTE"" (""NOME_GERENTE"", ""TELEFONE_GERENTE"", ""CPF_GERENTE"", ""PATIO_ID_PATIO"") VALUES
                ('Rodrigo Neves', '11900001111', '99999999900', 1),
                ('Carla Pires', '11900002222', '88888888801', 2),
                ('Fernando Lopes', '11900003333', '77777777702', 3),
                ('Marina Dias', '11900004444', '66666666603', 4),
                ('Bruno Araújo', '11900005555', '55555555504', 5),
                ('Isabela Freitas', '11900006666', '44444444405', 6),
                ('Tiago Faria', '11900007777', '33333333306', 7),
                ('Luciana Prado', '11900008888', '22222222207', 8);
            ");


            migrationBuilder.CreateTable(
                name: "SETOR",
                columns: table => new
                {
                    ID_SETOR = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    TIPO_SETOR = table.Column<string>(type: "character varying(70)", maxLength: 70, nullable: false),
                    STATUS_SETOR = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    PATIO_ID_PATIO = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SETOR", x => x.ID_SETOR);
                    table.ForeignKey(
                        name: "PATIO_FK",
                        column: x => x.PATIO_ID_PATIO,
                        principalTable: "PATIO",
                        principalColumn: "ID_PATIO",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.Sql(
                "ALTER TABLE \"SETOR\" ADD CONSTRAINT CHK_STATUS_SETOR CHECK (\"STATUS_SETOR\" IN ('Cheia', 'Parcial', 'Livre'))"
            );

            migrationBuilder.Sql(
                "ALTER TABLE \"SETOR\" ADD CONSTRAINT CHK_TIPO_SETOR CHECK (\"TIPO_SETOR\" IN ('Pendência', 'Reparos Simples', 'Danos Estruturais Graves', 'Motor Defeituoso', 'Agendada Para Manutenção', 'Pronta para Aluguel', 'Sem Placa', 'Minha Mottu'))"
            );
            
            migrationBuilder.Sql(@"
                INSERT INTO ""SETOR"" (""TIPO_SETOR"", ""PATIO_ID_PATIO"", ""STATUS_SETOR"") VALUES
                ('Pendência', 1, 'Parcial'),
                ('Reparos Simples', 1, 'Parcial'),
                ('Danos Estruturais Graves', 1, 'Parcial'),
                ('Motor Defeituoso', 1, 'Parcial'),
                ('Agendada Para Manutenção', 1, 'Parcial'),
                ('Pronta para Aluguel', 1, 'Parcial'),
                ('Sem Placa', 1, 'Parcial'),
                ('Minha Mottu', 1, 'Parcial'),

                ('Pendência', 2, 'Livre'),
                ('Reparos Simples', 2, 'Livre'),
                ('Danos Estruturais Graves', 2, 'Livre'),
                ('Motor Defeituoso', 2, 'Livre'),
                ('Agendada Para Manutenção', 2, 'Livre'),
                ('Pronta para Aluguel', 2, 'Livre'),
                ('Sem Placa', 2, 'Livre'),
                ('Minha Mottu', 2, 'Livre'),

                ('Pendência', 3, 'Livre'),
                ('Reparos Simples', 3, 'Livre'),
                ('Danos Estruturais Graves', 3, 'Livre'),
                ('Motor Defeituoso', 3, 'Livre'),
                ('Agendada Para Manutenção', 3, 'Livre'),
                ('Pronta para Aluguel', 3, 'Livre'),
                ('Sem Placa', 3, 'Livre'),
                ('Minha Mottu', 3, 'Livre'),

                ('Pendência', 4, 'Livre'),
                ('Reparos Simples', 4, 'Livre'),
                ('Danos Estruturais Graves', 4, 'Livre'),
                ('Motor Defeituoso', 4, 'Livre'),
                ('Agendada Para Manutenção', 4, 'Livre'),
                ('Pronta para Aluguel', 4, 'Livre'),
                ('Sem Placa', 4, 'Livre'),
                ('Minha Mottu', 4, 'Livre'),

                ('Pendência', 5, 'Livre'),
                ('Reparos Simples', 5, 'Livre'),
                ('Danos Estruturais Graves', 5, 'Livre'),
                ('Motor Defeituoso', 5, 'Livre'),
                ('Agendada Para Manutenção', 5, 'Livre'),
                ('Pronta para Aluguel', 5, 'Livre'),
                ('Sem Placa', 5, 'Livre'),
                ('Minha Mottu', 5, 'Livre'),

                ('Pendência', 6, 'Livre'),
                ('Reparos Simples', 6, 'Livre'),
                ('Danos Estruturais Graves', 6, 'Livre'),
                ('Motor Defeituoso', 6, 'Livre'),
                ('Agendada Para Manutenção', 6, 'Livre'),
                ('Pronta para Aluguel', 6, 'Livre'),
                ('Sem Placa', 6, 'Livre'),
                ('Minha Mottu', 6, 'Livre'),

                ('Pendência', 7, 'Livre'),
                ('Reparos Simples', 7, 'Livre'),
                ('Danos Estruturais Graves', 7, 'Livre'),
                ('Motor Defeituoso', 7, 'Livre'),
                ('Agendada Para Manutenção', 7, 'Livre'),
                ('Pronta para Aluguel', 7, 'Livre'),
                ('Sem Placa', 7, 'Livre'),
                ('Minha Mottu', 7, 'Livre'),

                ('Pendência', 8, 'Livre'),
                ('Reparos Simples', 8, 'Livre'),
                ('Danos Estruturais Graves', 8, 'Livre'),
                ('Motor Defeituoso', 8, 'Livre'),
                ('Agendada Para Manutenção', 8, 'Livre'),
                ('Pronta para Aluguel', 8, 'Livre'),
                ('Sem Placa', 8, 'Livre'),
                ('Minha Mottu', 8, 'Livre');
            ");


            migrationBuilder.CreateTable(
                name: "VAGA",
                columns: table => new
                {
                    ID_VAGA = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    NUMERO_VAGA = table.Column<string>(type: "character varying(10)", maxLength: 10, nullable: false),
                    STATUS_OCUPADA = table.Column<int>(type: "integer", nullable: false),
                    SETOR_ID_SETOR = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VAGA", x => x.ID_VAGA);
                    table.ForeignKey(
                        name: "SETOR_FK_VAGA",
                        column: x => x.SETOR_ID_SETOR,
                        principalTable: "SETOR",
                        principalColumn: "ID_SETOR",
                        onDelete: ReferentialAction.Cascade);
                });
            
            migrationBuilder.InsertData(
                table: "VAGA",
                columns: new[] { "NUMERO_VAGA", "STATUS_OCUPADA", "SETOR_ID_SETOR" },
                values: new object[,]
                {
                    // Pátio A (setores 1 a 8)
                    { "A1-V1", 0, 1 }, { "A1-V2", 0, 1 }, { "A1-V3", 1, 1 }, { "A1-V4", 1, 1 },
                    { "A2-V1", 0, 2 }, { "A2-V2", 0, 2 }, { "A2-V3", 1, 2 }, { "A2-V4", 1, 2 },
                    { "A3-V1", 0, 3 }, { "A3-V2", 0, 3 }, { "A3-V3", 1, 3 }, { "A3-V4", 1, 3 },
                    { "A4-V1", 0, 4 }, { "A4-V2", 0, 4 }, { "A4-V3", 1, 4 }, { "A4-V4", 1, 4 },
                    { "A5-V1", 0, 5 }, { "A5-V2", 0, 5 }, { "A5-V3", 1, 5 }, { "A5-V4", 1, 5 },
                    { "A6-V1", 0, 6 }, { "A6-V2", 0, 6 }, { "A6-V3", 1, 6 }, { "A6-V4", 1, 6 },
                    { "A7-V1", 0, 7 }, { "A7-V2", 0, 7 }, { "A7-V3", 1, 7 }, { "A7-V4", 1, 7 },
                    { "A8-V1", 0, 8 }, { "A8-V2", 0, 8 }, { "A8-V3", 1, 8 }, { "A8-V4", 1, 8 }, { "A8-V5", 1, 8 },

                    // Pátio B (setores 9 a 16)
                    { "B1-V1", 0, 9 }, { "B1-V2", 0, 9 }, { "B1-V3", 0, 9 },
                    { "B2-V1", 0, 10 }, { "B2-V2", 0, 10 }, { "B2-V3", 0, 10 },
                    { "B3-V1", 0, 11 }, { "B3-V2", 0, 11 }, { "B3-V3", 0, 11 },
                    { "B4-V1", 0, 12 }, { "B4-V2", 0, 12 }, { "B4-V3", 0, 12 },
                    { "B5-V1", 0, 13 }, { "B5-V2", 0, 13 }, { "B5-V3", 0, 13 },
                    { "B6-V1", 0, 14 }, { "B6-V2", 0, 14 }, { "B6-V3", 0, 14 },
                    { "B7-V1", 0, 15 }, { "B7-V2", 0, 15 }, { "B7-V3", 0, 15 },
                    { "B8-V1", 0, 16 }, { "B8-V2", 0, 16 }, { "B8-V3", 0, 16 },

                    // Pátio C (setores 17 a 24)
                    { "C1-V1", 0, 17 }, { "C1-V2", 0, 17 }, { "C1-V3", 0, 17 },
                    { "C2-V1", 0, 18 }, { "C2-V2", 0, 18 }, { "C2-V3", 0, 18 },
                    { "C3-V1", 0, 19 }, { "C3-V2", 0, 19 }, { "C3-V3", 0, 19 },
                    { "C4-V1", 0, 20 }, { "C4-V2", 0, 20 }, { "C4-V3", 0, 20 },
                    { "C5-V1", 0, 21 }, { "C5-V2", 0, 21 }, { "C5-V3", 0, 21 },
                    { "C6-V1", 0, 22 }, { "C6-V2", 0, 22 }, { "C6-V3", 0, 22 },
                    { "C7-V1", 0, 23 }, { "C7-V2", 0, 23 }, { "C7-V3", 0, 23 },
                    { "C8-V1", 0, 24 }, { "C8-V2", 0, 24 }, { "C8-V3", 0, 24 },

                    // Pátio D (setores 25 a 32)
                    { "D1-V1", 0, 25 }, { "D1-V2", 0, 25 }, { "D1-V3", 0, 25 },
                    { "D2-V1", 0, 26 }, { "D2-V2", 0, 26 }, { "D2-V3", 0, 26 },
                    { "D3-V1", 0, 27 }, { "D3-V2", 0, 27 }, { "D3-V3", 0, 27 },
                    { "D4-V1", 0, 28 }, { "D4-V2", 0, 28 }, { "D4-V3", 0, 28 },
                    { "D5-V1", 0, 29 }, { "D5-V2", 0, 29 }, { "D5-V3", 0, 29 },
                    { "D6-V1", 0, 30 }, { "D6-V2", 0, 30 }, { "D6-V3", 0, 30 },
                    { "D7-V1", 0, 31 }, { "D7-V2", 0, 31 }, { "D7-V3", 0, 31 },
                    { "D8-V1", 0, 32 }, { "D8-V2", 0, 32 }, { "D8-V3", 0, 32 },

                    // Pátio E (setores 33 a 40)
                    { "E1-V1", 0, 33 }, { "E1-V2", 0, 33 }, { "E1-V3", 0, 33 },
                    { "E2-V1", 0, 34 }, { "E2-V2", 0, 34 }, { "E2-V3", 0, 34 },
                    { "E3-V1", 0, 35 }, { "E3-V2", 0, 35 }, { "E3-V3", 0, 35 },
                    { "E4-V1", 0, 36 }, { "E4-V2", 0, 36 }, { "E4-V3", 0, 36 },
                    { "E5-V1", 0, 37 }, { "E5-V2", 0, 37 }, { "E5-V3", 0, 37 },
                    { "E6-V1", 0, 38 }, { "E6-V2", 0, 38 }, { "E6-V3", 0, 38 },
                    { "E7-V1", 0, 39 }, { "E7-V2", 0, 39 }, { "E7-V3", 0, 39 },
                    { "E8-V1", 0, 40 }, { "E8-V2", 0, 40 }, { "E8-V3", 0, 40 },

                    // Pátio F (setores 41 a 48)
                    { "F1-V1", 0, 41 }, { "F1-V2", 0, 41 }, { "F1-V3", 0, 41 },
                    { "F2-V1", 0, 42 }, { "F2-V2", 0, 42 }, { "F2-V3", 0, 42 },
                    { "F3-V1", 0, 43 }, { "F3-V2", 0, 43 }, { "F3-V3", 0, 43 },
                    { "F4-V1", 0, 44 }, { "F4-V2", 0, 44 }, { "F4-V3", 0, 44 },
                    { "F5-V1", 0, 45 }, { "F5-V2", 0, 45 }, { "F5-V3", 0, 45 },
                    { "F6-V1", 0, 46 }, { "F6-V2", 0, 46 }, { "F6-V3", 0, 46 },
                    { "F7-V1", 0, 47 }, { "F7-V2", 0, 47 }, { "F7-V3", 0, 47 },
                    { "F8-V1", 0, 48 }, { "F8-V2", 0, 48 }, { "F8-V3", 0, 48 },

                    // Pátio G (setores 49 a 56)
                    { "G1-V1", 0, 49 }, { "G1-V2", 0, 49 }, { "G1-V3", 0, 49 },
                    { "G2-V1", 0, 50 }, { "G2-V2", 0, 50 }, { "G2-V3", 0, 50 },
                    { "G3-V1", 0, 51 }, { "G3-V2", 0, 51 }, { "G3-V3", 0, 51 },
                    { "G4-V1", 0, 52 }, { "G4-V2", 0, 52 }, { "G4-V3", 0, 52 },
                    { "G5-V1", 0, 53 }, { "G5-V2", 0, 53 }, { "G5-V3", 0, 53 },
                    { "G6-V1", 0, 54 }, { "G6-V2", 0, 54 }, { "G6-V3", 0, 54 },
                    { "G7-V1", 0, 55 }, { "G7-V2", 0, 55 }, { "G7-V3", 0, 55 },
                    { "G8-V1", 0, 56 }, { "G8-V2", 0, 56 }, { "G8-V3", 0, 56 },

                    // Pátio H (setores 57 a 64)
                    { "H1-V1", 0, 57 }, { "H1-V2", 0, 57 }, { "H1-V3", 0, 57 },
                    { "H2-V1", 0, 58 }, { "H2-V2", 0, 58 }, { "H2-V3", 0, 58 },
                    { "H3-V1", 0, 59 }, { "H3-V2", 0, 59 }, { "H3-V3", 0, 59 },
                    { "H4-V1", 0, 60 }, { "H4-V2", 0, 60 }, { "H4-V3", 0, 60 },
                    { "H5-V1", 0, 61 }, { "H5-V2", 0, 61 }, { "H5-V3", 0, 61 },
                    { "H6-V1", 0, 62 }, { "H6-V2", 0, 62 }, { "H6-V3", 0, 62 },
                    { "H7-V1", 0, 63 }, { "H7-V2", 0, 63 }, { "H7-V3", 0, 63 },
                    { "H8-V1", 0, 64 }, { "H8-V2", 0, 64 }, { "H8-V3", 0, 64 }
                });


            migrationBuilder.CreateTable(
                name: "MOVIMENTACAO",
                columns: table => new
                {
                    ID_MOVIMENTACAO = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    DT_ENTRADA = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    DT_SAIDA = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    DESCRICAO_MOVIMENTACAO = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: true),
                    MOTO_ID_MOTO = table.Column<int>(type: "integer", nullable: false),
                    VAGA_ID_VAGA = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MOVIMENTACAO", x => x.ID_MOVIMENTACAO);
                    table.ForeignKey(
                        name: "MOTO_FK",
                        column: x => x.MOTO_ID_MOTO,
                        principalTable: "MOTO",
                        principalColumn: "ID_MOTO",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "VAGA_FK",
                        column: x => x.VAGA_ID_VAGA,
                        principalTable: "VAGA",
                        principalColumn: "ID_VAGA",
                        onDelete: ReferentialAction.Cascade);
                });
            
            migrationBuilder.Sql(@"
                INSERT INTO ""MOVIMENTACAO"" (""DT_ENTRADA"", ""DT_SAIDA"", ""DESCRICAO_MOVIMENTACAO"", ""MOTO_ID_MOTO"", ""VAGA_ID_VAGA"") VALUES
                (DATE '2025-01-02', DATE '2025-01-03', 'Aguardando liberação', 1, 1),
                (DATE '2025-01-04', DATE '2025-01-05', 'Em análise documental', 2, 2),
                (DATE '2025-01-06', NULL, 'Aguardando vistoria', 3, 3),
                (DATE '2025-01-07', NULL, 'Pendência com cliente', 4, 4),
                (DATE '2025-01-08', DATE '2025-01-09', 'Revisão preventiva', 5, 5),
                (DATE '2025-01-10', DATE '2025-01-11', 'Troca de óleo', 6, 6),
                (DATE '2025-01-12', NULL, 'Troca de pneu', 7, 7),
                (DATE '2025-01-13', NULL, 'Correção de freio', 8, 8),
                (DATE '2025-01-14', DATE '2025-01-15', 'Colisão frontal', 9, 9),
                (DATE '2025-01-16', DATE '2025-01-17', 'Chassi danificado', 10, 10),
                (DATE '2025-01-18', NULL, 'Eixo empenado', 11, 11),
                (DATE '2025-01-19', NULL, 'Queda grave', 12, 12),
                (DATE '2025-01-20', DATE '2025-01-21', 'Problema de ignição', 13, 13),
                (DATE '2025-01-22', DATE '2025-01-23', 'Motor superaquecendo', 14, 14),
                (DATE '2025-01-24', NULL, 'Falha no motor', 15, 15),
                (DATE '2025-01-25', NULL, 'Vazamento de óleo', 16, 16),
                (DATE '2025-01-26', DATE '2025-01-27', 'Manutenção agendada', 17, 17),
                (DATE '2025-01-28', DATE '2025-01-29', 'Agendada para revisão', 18, 18),
                (DATE '2025-01-30', NULL, 'Revisão programada', 19, 19),
                (DATE '2025-01-31', NULL, 'Verificação agendada', 20, 20),
                (DATE '2025-02-01', DATE '2025-02-02', 'Liberada para uso', 21, 21),
                (DATE '2025-02-03', DATE '2025-02-04', 'Disponível', 22, 22),
                (DATE '2025-02-05', NULL, 'Disponível para locação', 23, 23),
                (DATE '2025-02-06', NULL, 'Pronta para retirada', 24, 24),
                (DATE '2025-02-07', DATE '2025-02-08', 'Sem placa na moto', 25, 25),
                (DATE '2025-02-09', DATE '2025-02-10', 'Placa removida', 26, 26),
                (DATE '2025-02-11', NULL, 'Moto sem identificação', 27, 27),
                (DATE '2025-02-12', NULL, 'Aguardando emplacamento', 28, 28),
                (DATE '2025-02-13', DATE '2025-02-14', 'Em uso por Mottu', 29, 29),
                (DATE '2025-02-15', DATE '2025-02-16', 'Reservada pela Mottu', 30, 30),
                (DATE '2025-02-17', NULL, 'Operação Mottu', 31, 31),
                (DATE '2025-02-18', NULL, 'Uso interno Mottu', 32, 32),
                (DATE '2025-02-18', NULL, 'Uso interno Mottu', 33, 33);
            ");


            migrationBuilder.CreateIndex(
                name: "IX_CLIENTE_CPF_CLIENTE",
                table: "CLIENTE",
                column: "CPF_CLIENTE",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_FUNCIONARIO_CARGO_ID_CARGO",
                table: "FUNCIONARIO",
                column: "CARGO_ID_CARGO");

            migrationBuilder.CreateIndex(
                name: "IX_FUNCIONARIO_PATIO_ID_PATIO",
                table: "FUNCIONARIO",
                column: "PATIO_ID_PATIO");

            migrationBuilder.CreateIndex(
                name: "IX_GERENTE_CPF_GERENTE",
                table: "GERENTE",
                column: "CPF_GERENTE",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_GERENTE_PATIO_ID_PATIO",
                table: "GERENTE",
                column: "PATIO_ID_PATIO");

            migrationBuilder.CreateIndex(
                name: "IX_MOTO_CHASSI_MOTO",
                table: "MOTO",
                column: "CHASSI_MOTO",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_MOTO_CLIENTE_ID_CLIENTE",
                table: "MOTO",
                column: "CLIENTE_ID_CLIENTE");

            migrationBuilder.CreateIndex(
                name: "IX_MOTO_PLACA_MOTO",
                table: "MOTO",
                column: "PLACA_MOTO",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_MOVIMENTACAO_MOTO_ID_MOTO",
                table: "MOVIMENTACAO",
                column: "MOTO_ID_MOTO");

            migrationBuilder.CreateIndex(
                name: "IX_MOVIMENTACAO_VAGA_ID_VAGA",
                table: "MOVIMENTACAO",
                column: "VAGA_ID_VAGA");

            migrationBuilder.CreateIndex(
                name: "IX_SETOR_PATIO_ID_PATIO",
                table: "SETOR",
                column: "PATIO_ID_PATIO");

            migrationBuilder.CreateIndex(
                name: "IX_VAGA_SETOR_ID_SETOR",
                table: "VAGA",
                column: "SETOR_ID_SETOR");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "FUNCIONARIO");

            migrationBuilder.DropTable(
                name: "GERENTE");

            migrationBuilder.DropTable(
                name: "MOVIMENTACAO");

            migrationBuilder.DropTable(
                name: "CARGO");

            migrationBuilder.DropTable(
                name: "MOTO");

            migrationBuilder.DropTable(
                name: "VAGA");

            migrationBuilder.DropTable(
                name: "CLIENTE");

            migrationBuilder.DropTable(
                name: "SETOR");

            migrationBuilder.DropTable(
                name: "PATIO");
        }
    }
}
