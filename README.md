# Sistema de Cadastro de Veículos

Projeto desenvolvido em **Dart**, com integração ao banco de dados **Supabase**, para realizar o gerenciamento de veículos de uma locadora.

## Funcionalidades

O sistema possui as seguintes operações:

- **Cadastrar veículos:** registra um novo veículo no banco de dados.
- **Listar veículos:** exibe todos os veículos cadastrados.
- **Atualizar veículos:** permite modificar os dados de um veículo existente por meio do seu ID.
- **Excluir veículos:** remove um veículo após confirmação do usuário.

O sistema também possui validações de dados, mensagens de sucesso e tratamento de erros.

## Tecnologias utilizadas

- Dart
- Supabase
- PostgreSQL
- Biblioteca `supabase`
- Biblioteca `dotenv`

## Estrutura do projeto

```text
locadoraSistema/
│
├── bin/
│   └── main.dart
│
├── lib/
│   ├── conexao.dart
│   └── veiculos.dart
│
├── .env
├── .gitignore
├── pubspec.yaml
└── README.md
```

## Configuração da conexão com o Supabase

Para conectar o projeto ao Supabase, é necessário criar um arquivo `.env` na raiz do projeto, no mesmo nível do arquivo `pubspec.yaml`.

Dentro do arquivo `.env`, devem ser informadas as credenciais do projeto:

```env
SUPABASE_URL=sua_url_do_supabase
SUPABASE_PUBLISHABLE_KEY=sua_chave_publica
```

As informações podem ser encontradas nas configurações do projeto no painel do Supabase.

O arquivo `conexao.dart` utiliza a biblioteca `dotenv` para carregar as variáveis de ambiente e a biblioteca `supabase` para estabelecer a conexão com o banco de dados.

**Importante:** o arquivo `.env` contém credenciais e não deve ser enviado ao GitHub. Ele deve estar incluído no `.gitignore`.

## Instalação das dependências

Com o terminal aberto na raiz do projeto, execute:

```bash
dart pub get
```

Esse comando instala as dependências definidas no arquivo `pubspec.yaml`.

## Como executar o projeto

Abra o terminal na raiz do projeto, na pasta onde está localizado o arquivo `pubspec.yaml`, e execute:

```bash
dart run bin/main.dart
```

Após a execução, o sistema estabelecerá a conexão com o Supabase e apresentará o menu principal para utilização das funcionalidades.

## Banco de dados

O projeto utiliza uma tabela chamada `veiculos`, com os seguintes campos:

| Campo | Tipo |
|---|---|
| id | bigint (chave primária, autoincremento) |
| marca | varchar(50) |
| modelo | varchar(100) |
| ano | integer |
| valor | decimal(12,2) |
| quilometragem | integer |

O banco de dados utiliza políticas de segurança (RLS) para controlar as operações realizadas pela aplicação.

## Autor

Desenvolvido como atividade prática de programação utilizando Dart e Supabase.
