# Mottu Mottion - API

## Integrantes

- Giovanna Revito Roz - RM558981
- Kaian Gustavo de Oliveira Nascimento - RM558986
- Lucas Kenji Kikuchi - RM554424

## Descrição do Projeto

A Mottion nasce como resposta a um dos maiores gargalos operacionais
enfrentados atualmente pela Mottu: a falta de controle, rastreabilidade e padronização
na gestão de pátios de motos em suas filiais. Com mais de 100 unidades espalhadas
por diferentes regiões e layouts, a tarefa de localizar motos, controlar manutenções e
evitar furtos se tornou complexa, sujeita a falhas manuais e impactos diretos na
produtividade e segurança. 

Nosso projeto tem como missão automatizar e otimizar a operação física de
motos no pátio, garantindo visibilidade em tempo real, ações corretivas proativas e
total rastreabilidade — usando sensores IoT, visão computacional e um sistema web
/ mobile responsivo.

Nossa aplicação é responsável por gerenciar informações sobre os clientes, motos, pátios, vagas, setores, funcionários, gerentes, cargos e movimentações. Além disso, ela será de suma importância para a atualização e localização em tempo real da ocupação de motos em cada um dos setores do pátio, além de fornecer o histórico de movimentações de uma moto dentro da filial.

## Benefícios para o Negócio

O nosso projeto Mottu Mottion proporciona maior **controle e rastreabilidade** das motos e operações nos pátios, com registro digital de movimentações e histórico completo de cada veículo, reduzindo falhas dentro do pátio. 

Ao automatizar processos manuais, otimiza a **produtividade operacional**, permitindo localizar motos e vagas em tempo real, planejar manutenções e gerenciar o fluxo de forma eficiente. A **redução de erros humanos**, aliada a um sistema web/mobile responsivo, garante informações confiáveis e acesso remoto às filiais. 

Além disso, oferece **segurança reforçada**, controle de acesso e visibilidade de todas as movimentações, permitindo decisões estratégicas baseadas em dados precisos e relatórios detalhados sobre ocupação e desempenho dos setores.


## Instalação

### Instalação e Execução da API (.NET 9)
#### 📋 Pré-requisitos
Antes de instalar, verifique se os seguintes itens estão instalados:

- Azure CLI

- Docker Hub

- Interface de acesso ao PostgreSQL (ex: pgAdmin 4)

- Visual Studio 2022+ ou Rider (opcional)

- Git Bash (opcional)

### Clone o repositório e acesse o diretório:

```bash
git clone https://github.com/dinozindev/sprint3-devops.git
cd sprint3-devops
```

### Abra o seu Docker Desktop para que seja possível fazer o build-push da imagem da API

### Faça o Login na Azure:
```bash
az login
```

### Registre o resource provider do PostgreSQL dentro da sua subscription no Azure:
```bash
az provider register --namespace Microsoft.DBforPostgreSQL
```

### Execute o script de criação do servidor PostgreSQL em nuvem:
```bash
./criar-server.sh
```

### OBS.: Caso o script fique preso na seguinte linha de comando, abra outro terminal para executar o script de criação do container da API.
```code
{ 
  "connectionString": "postgresql://adminuser:adminpassword@postgres-mottu-mottion.postgres.database.azure.com/postgres?sslmode=require", 
  "databaseName": "postgres", 
  "firewallName": "AllowAllAzureServicesAndResourcesWithinAzureIps_2025-9-11_12-21-49", 
  "host": "postgres-mottu-mottion.postgres.database.azure.com",
  "id": "/subscriptions/91d53c89-301c-463a-944e-15d9be7b01f5/resourceGroups/rg-api-mottu-mottion/providers/Microsoft.DBforPostgreSQL/flexibleServers/postgres-mottu-mottion", 
  "location": "Brazil South", 
  "password": "adminpassword", 
  "resourceGroup": "rg-api-mottu-mottion", 
  "skuname": "Standard_B1ms", 
  "username": "adminuser", 
  "version": "14" 
} 
/ Waiting ..
```

### Em seguida, execute o script de criação do container da aplicação:
```code
./build-e-deploy.sh
```

### Para acessar a API (Scalar), utilize o FQDN do Container: 
```bash
http://mottu-mottion-api.brazilsouth.azurecontainer.io:8080/
```

### Para acessar o banco de dados PostgreSQL pelo pgAdmin 4, utilize as seguintes credenciais ao criar um novo servidor: 

- **Host name/address**: postgres-mottu-mottion.postgres.database.azure.com
- **Port**: 5432
- **Maintenance database**: apidb
- **Username**: adminuser
- **Password**: adminpassword
- **SSL mode**: require ou prefer

### Para acessar a documentação da aplicação: 
```bash
http://mottu-mottion-api.brazilsouth.azurecontainer.io:8080/scalar
```

### Para testar os endpoints de Cliente por meio de um script, execute:
```bash
./teste-endpoints.sh
```

## Rotas da API para teste (Cliente)

### Parâmetros de Rotas Paginadas

| Parâmetro   | Tipo       | Descrição                                   |
| :---------- | :--------- | :------------------------------------------ |
| `pageNumber`      | `int` | **Obrigatório**. O número da página atual |
| `pageSize`      | `int` | **Obrigatório**. A quantidade de registros por página |

- #### Retorna todos os clientes

```http
  GET /clientes?pageNumber=&pageSize=
```

Response Body:

```json
{
  "totalCount": 1,
  "pageNumber": 1,
  "pageSize": 1,
  "totalPages": 1,
  "data": [
    {
      "clienteId": 1,
      "nomeCliente": "string",
      "telefoneCliente": "string",
      "sexoCliente": "string",
      "emailCliente": "string",
      "cpfCliente": "string",
      "motos": [
        {
          "motoId": 1,
          "placaMoto": null,
          "modeloMoto": "string",
          "situacaoMoto": "string",
          "chassiMoto": "string"
        }
      ]
    }
  ],
  "links": [
    {
      "rel": "string",
      "href": "string",
      "method": "string"
    }
  ]
}
```

Códigos de Resposta

| Código HTTP | Significado                     | Quando ocorre                                             |
|-------------|----------------------------------|-----------------------------------------------------------|
| 200 OK      | Requisição bem-sucedida         | Quando há clientes cadastrados                            |
| 204 No Content | Sem conteúdo a retornar      | Quando não há clientes cadastrados                        |
| 500 Internal Server Error | Erro interno     | Quando ocorre uma falha inesperada no servidor            |

- #### Retorna um cliente pelo ID

```http
  GET /clientes/{id}
```

| Parâmetro   | Tipo       | Descrição                                   |
| :---------- | :--------- | :------------------------------------------ |
| `id`      | `int` | **Obrigatório**. O ID do cliente que você deseja consultar |

Response Body:

```json
  {
  "data": {
    "clienteId": 1,
    "nomeCliente": "string",
    "telefoneCliente": "string",
    "sexoCliente": "string",
    "emailCliente": "string",
    "cpfCliente": "string",
    "motos": [
      {
        "motoId": 1,
        "placaMoto": null,
        "modeloMoto": "string",
        "situacaoMoto": "string",
        "chassiMoto": "string"
      }
    ]
  },
  "links": [
    {
      "rel": "string",
      "href": "string",
      "method": "string"
    }
  ]
}
```

Códigos de Resposta

| Código HTTP | Significado                     | Quando ocorre                                             |
|-------------|----------------------------------|-----------------------------------------------------------|
| 200 OK      | Requisição bem-sucedida         | Quando o cliente foi encontrado                            |
| 404 Not Found | Recurso não encontrado        | Quando o cliente especificado não existe       |
| 500 Internal Server Error | Erro interno     | Quando ocorre uma falha inesperada no servidor            |

- #### Cria um cliente

```http
  POST /clientes
```

Request Body:

```json
{
  "nomeCliente": "",
  "telefoneCliente": "",
  "sexoCliente": "",
  "emailCliente": "",
  "cpfCliente": ""
}
```

Códigos de Resposta

| Código HTTP       | Significado                     | Quando ocorre                                                  |
|-------------------|----------------------------------|----------------------------------------------------------------|
| 201 Created       | Recurso criado com sucesso      | Quando um cliente é criado com êxito |
| 400 Bad Request   | Requisição malformada           | Quando os dados enviados estão incorretos ou incompletos       |
| 409 Conflict      | Conflito de estado              | Quando há conflito, como dados duplicados (CPF)                     |
| 500 Internal Server Error | Erro interno             | Quando ocorre uma falha inesperada no servidor                 |

- #### Atualiza um cliente

```http
  PUT /clientes/{id}
```

Request Body:

```json
{
  "nomeCliente": "",
  "telefoneCliente": "",
  "sexoCliente": "",
  "emailCliente": "",
  "cpfCliente": ""
}
```

| Parâmetro   | Tipo       | Descrição                                   |
| :---------- | :--------- | :------------------------------------------ |
| `id`      | `int` | **Obrigatório**. O ID do cliente que você atualizar |

Códigos de Resposta

| Código HTTP       | Significado                     | Quando ocorre                                                  |
|-------------------|----------------------------------|----------------------------------------------------------------|
| 201 Created       | Recurso criado com sucesso      | Quando um cliente é criado com êxito |
| 400 Bad Request   | Requisição malformada           | Quando os dados enviados estão incorretos ou incompletos       |
| 404 Not Found | Recurso não encontrado        |  Quando nenhum cliente foi encontrado com o ID especificado      |
| 409 Conflict      | Conflito de estado              | Quando há conflito, como dados duplicados (CPF)                     |
| 500 Internal Server Error | Erro interno             | Quando ocorre uma falha inesperada no servidor                 |

- #### Deleta um cliente

```http
  DELETE /clientes/{id}
```

| Parâmetro   | Tipo       | Descrição                                   |
| :---------- | :--------- | :------------------------------------------ |
| `id`      | `int` | **Obrigatório**. O ID do cliente que você deseja deletar |

Códigos de Resposta

| Código HTTP       | Significado                     | Quando ocorre                                                  |
|-------------------|----------------------------------|----------------------------------------------------------------|
| 204 No Content    | Sem conteúdo a retornar         | Quando a remoção do cliente é válida, mas não há dados para retornar   |
| 404 Not Found     | Recurso não encontrado          | Quando o cliente especificado não é encontrado                |
| 500 Internal Server Error | Erro interno             | Quando ocorre uma falha inesperada no servidor                 |
