# **PaLeva!**

<p align="center">
  <img src="https://img.shields.io/static/v1?label=Ruby%20ON%20RAILS&message=7.2.1&color=red&style=for-the-badge&logo=Ruby">
  <img src="https://img.shields.io/static/v1?label=Ruby&message=3.1&color=red&style=for-the-badge&logo=Ruby">
  <img src="https://img.shields.io/static/v1?label=Tailwind&message=3.4&color=blue&style=for-the-badge&logo=TailwindCSS">
</p>

---

## **Índice**
1. [Descrição do Projeto](#descrição-do-projeto)
2. [Funcionalidades](#funcionalidades)
3. [Tecnologias](#tecnologias)
4. [Gems Instaladas](#gems-instaladas)
5. [Configurações](#configurações)
6. [Rodando os Testes](#rodando-os-testes)
7. [Protótipo](#protótipo)
8. [Próximos passos](#próximos-passos)

---

## **Descrição do Projeto**
O **PaLeva!** é um sistema completo para gestão de restaurantes com foco em estabelecimentos **take-away**. Ele oferece ferramentas para gerenciar:
- Cadastro de estabelecimentos.
- Criação de pratos, bebidas e cardápios temáticos.
- Gestão de pedidos e status em tempo real.
- Controle de funcionários com sistema de pré-cadastro e autenticação.

Com ele, donos e funcionários podem organizar o fluxo operacional de forma eficiente e integrada.

---

## **Funcionalidades**

### **Dono do Restaurante**
- **Cadastro e Gerenciamento**
  - Criar conta com CPF único e válido.
  - Cadastrar estabelecimento com informações detalhadas.
  - Configurar horários de funcionamento por dia.
  
- **Gestão de Produtos**
  - Adicionar/editar/remover pratos e bebidas com descrição, calorias, imagem, preço e porções.
  - Ativar/desativar itens e adicionar marcadores para classificação.
  - Criar cardápios temáticos e vinculá-los aos produtos.
  - Criar cardápios sazonais com período de atuação.

- **Gestão de Pedidos**
  - Criar pedidos personalizados com notas e detalhes de porções.
  - Monitorar status e valor total dos pedidos.

- **Gestão de Funcionários**
  - Pré-cadastrar e gerenciar contas de funcionários vinculados ao restaurante.

- **API**
  - Endpoints para listar pedidos, consultar detalhes e atualizar status.

### **Funcionário**
  - Criar pedidos com personalização de porções e notas.
  - Visualizar o status e o valor total do pedido.

### **Cliente**
  - Visualizar o status e o valor total do pedido.
  - Acompanhar cada etapa do processo de preparação do pedido com horário informado

---

## **Tecnologias**
- **Back-end:** Ruby on Rails (7.2.1)
- **Front-end:** Tailwind CSS
- **Autenticação:** Devise
- **Internacionalização:** i18n
- **Testes:** RSpec e Capybara
- **Interatividade:** Stimulus/Hotwired

---

## **Gems Instaladas**
- **Autenticação:** Devise
- **Testes:** rspec-rails, capybara
- **Estilo:** tailwindcss-rails
- **Validação de Documentos:** cpf_cnpj

---

## **Configurações**

### Clone o projeto:

```bash
git clone https://github.com/joaoCasteloBranco/paLeva
````

````bash
cd paLeva
````

````bash
bundle install
````

````bash
rails db:create db:migrate db:seed
````

```bash
rails s
```

> Acessar http://localhost:3000 

## Rodando os testes 

```bash
RAILS_ENV=test rails db:create db:migrate
```

```bash
rspec 
```

### Protótipo

O projeto já possui uma série de registros pré-cadastrados para facilitar a visualização das funcionalidades da plataforma.

No terminal:

````
rails db:seed
````

No arquivo de seeds:

### Dono de Restaurante:
```ruby 
user = User.create!(
  cpf: "109.789.030-99",
  email:  "sergio.vieira.de.melo@ri.com",
  name: "Sergio",
  last_name: "Vieira",
  password: "nacoesunidas",
)
```

### Funcionário:
```ruby 
employee = Employee.create!(
  cpf: "165.180.750-74",
  email: "email2@email.com",
  status: :active,
  restaurant: restaurant,
  password: "nacoesunidas"
)
```

## Próximos Passos

### Funcionalidades

- Aplicação de descontos
- Em progresso na <code> branch feature/discounts </code>  
