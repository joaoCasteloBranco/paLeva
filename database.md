# **Estrutura do Banco de Dados**

## Índice
- [Tabelas](#tabelas)
  - [employees](#employees)
  - [markers](#markers)
  - [menu_contents](#menu_contents)
  - [menu_item_markers](#menu_item_markers)
  - [menu_items](#menu_items)
  - [menus](#menus)
  - [operating_days](#operating_days)
  - [order_items](#order_items)
  - [orders](#orders)
  - [price_histories](#price_histories)
  - [restaurants](#restaurants)
  - [servings](#servings)
  - [users](#users)

---

## Tabelas


### `employees`

| Nome da Coluna     | Tipo           | PT-BR-i18n                  | Validações                   |
|---------------------|----------------|-----------------------------|------------------------------|
| email              | string         | E-mail                     | `null: false, unique: true` |
| encrypted_password | string         | Senha Encriptada           | `null: false`               |
| reset_password_token | string       | Token de Redefinição       | `unique: true`              |
| reset_password_sent_at | datetime   | Enviado em                 |                              |
| remember_created_at | datetime      | Lembrado em                |                              |
| restaurant_id      | integer        | ID do Restaurante          | `null: false`               |
| name               | string         | Nome                       |                              |
| cpf                | string         | CPF                        |                              |
| status             | integer        | Status                     |                              |
| created_at         | datetime       | Criado em                  | `null: false`               |
| updated_at         | datetime       | Atualizado em              | `null: false`               |

---

### `markers`

| Nome da Coluna     | Tipo           | PT-BR-i18n                  | Validações                   |
|---------------------|----------------|-----------------------------|------------------------------|
| name               | string         | Nome                       |                              |
| restaurant_id      | integer        | ID do Restaurante          | `null: false`               |
| created_at         | datetime       | Criado em                  | `null: false`               |
| updated_at         | datetime       | Atualizado em              | `null: false`               |

---

### `menu_contents`

| Nome da Coluna     | Tipo           | PT-BR-i18n                  | Validações                   |
|---------------------|----------------|-----------------------------|------------------------------|
| menu_id            | integer        | ID do Menu                 | `null: false`               |
| menu_item_id       | integer        | ID do Item do Menu         | `null: false`               |
| created_at         | datetime       | Criado em                  | `null: false`               |
| updated_at         | datetime       | Atualizado em              | `null: false`               |

---

### `menu_item_markers`

| Nome da Coluna     | Tipo           | PT-BR-i18n                  | Validações                   |
|---------------------|----------------|-----------------------------|------------------------------|
| menu_item_id       | integer        | ID do Item do Menu         | `null: false`               |
| marker_id          | integer        | ID do Marcador             | `null: false`               |
| created_at         | datetime       | Criado em                  | `null: false`               |
| updated_at         | datetime       | Atualizado em              | `null: false`               |

---

### `menu_items`

| Nome da Coluna     | Tipo           | PT-BR-i18n                  | Validações                   |
|---------------------|----------------|-----------------------------|------------------------------|
| type               | string         | Tipo                       |                              |
| name               | string         | Nome                       |                              |
| description        | text           | Descrição                  |                              |
| status             | integer        | Status                     | `default: 1`                |
| calories           | integer        | Calorias                   |                              |
| photo              | string         | Foto                       |                              |
| restaurant_id      | integer        | ID do Restaurante          | `null: false`               |
| alcoholic          | boolean        | Alcoólico                  |                              |
| created_at         | datetime       | Criado em                  | `null: false`               |
| updated_at         | datetime       | Atualizado em              | `null: false`               |

---


### `menus`

| Nome da Coluna     | Tipo           | PT-BR-i18n                  | Validações                   |
|---------------------|----------------|-----------------------------|------------------------------|
| name               | string         | Nome                       |                              |
| restaurant_id      | integer        | ID do Restaurante          | `null: false`               |
| created_at         | datetime       | Criado em                  | `null: false`               |
| updated_at         | datetime       | Atualizado em              | `null: false`               |

---

### `operating_days`

| Nome da Coluna     | Tipo           | PT-BR-i18n                  | Validações                   |
|---------------------|----------------|-----------------------------|------------------------------|
| restaurant_id      | integer        | ID do Restaurante          | `null: false`               |
| week_day           | integer        | Dia da Semana              |                              |
| open               | boolean        | Aberto                     |                              |
| opening_time       | time           | Hora de Abertura           |                              |
| closing_time       | time           | Hora de Fechamento         |                              |
| created_at         | datetime       | Criado em                  | `null: false`               |
| updated_at         | datetime       | Atualizado em              | `null: false`               |

---

### `order_items`

| Nome da Coluna     | Tipo           | PT-BR-i18n                  | Validações                   |
|---------------------|----------------|-----------------------------|------------------------------|
| note               | string         | Observação                 |                              |
| order_id           | integer        | ID do Pedido               | `null: false`               |
| serving_id         | integer        | ID da Porção               | `null: false`               |
| created_at         | datetime       | Criado em                  | `null: false`               |
| updated_at         | datetime       | Atualizado em              | `null: false`               |

---

### `orders`

| Nome da Coluna     | Tipo           | PT-BR-i18n                  | Validações                   |
|---------------------|----------------|-----------------------------|------------------------------|
| customer_name      | string         | Nome do Cliente            |                              |
| contact_phone      | string         | Telefone de Contato        |                              |
| contact_email      | string         | E-mail de Contato          |                              |
| cpf                | string         | CPF                        |                              |
| code               | string         | Código do Pedido           |                              |
| status             | integer        | Status                     |                              |
| restaurant_id      | integer        | ID do Restaurante          | `null: false`               |
| created_at         | datetime       | Criado em                  | `null: false`               |
| updated_at         | datetime       | Atualizado em              | `null: false`               |

---

### `price_histories`

| Nome da Coluna     | Tipo           | PT-BR-i18n                  | Validações                   |
|---------------------|----------------|-----------------------------|------------------------------|
| serving_id         | integer        | ID da Porção               | `null: false`               |
| price              | integer        | Preço                      |                              |
| changed_at         | datetime       | Alterado em                |                              |
| created_at         | datetime       | Criado em                  | `null: false`               |
| updated_at         | datetime       | Atualizado em              | `null: false`               |

---

### `restaurants`

| Nome da Coluna     | Tipo           | PT-BR-i18n                  | Validações                   |
|---------------------|----------------|-----------------------------|------------------------------|
| user_id            | integer        | ID do Usuário              | `null: false`               |
| registered_name    | string         | Razão Social               |                              |
| comercial_name     | string         | Nome Comercial             |                              |
| cnpj               | string         | CNPJ                       | `unique: true`               |
| address            | text           | Endereço                   |                              |
| phone              | string         | Telefone                   |                              |
| email              | string         | E-mail                     |                              |
| code               | string         | Código do Restaurante      |                              |
| created_at         | datetime       | Criado em                  | `null: false`               |
| updated_at         | datetime       | Atualizado em              | `null: false`               |

---

### `servings`

| Nome da Coluna     | Tipo           | PT-BR-i18n                  | Validações                   |
|---------------------|----------------|-----------------------------|------------------------------|
| menu_item_id       | integer        | ID do Item do Menu         | `null: false`               |
| description        | string         | Descrição                  |                              |
| price              | integer        | Preço                      |                              |
| created_at         | datetime       | Criado em                  | `null: false`               |
| updated_at         | datetime       | Atualizado em              | `null: false`               |

---

### `users`

| Nome da Coluna     | Tipo           | PT-BR-i18n                  | Validações                   |
|---------------------|----------------|-----------------------------|------------------------------|
| email              | string         | E-mail                     | `null: false, unique: true` |
| encrypted_password | string         | Senha Encriptada           | `null: false`               |
| reset_password_token | string       | Token de Redefinição       | `unique: true`              |
| reset_password_sent_at | datetime   | Enviado em                 |                              |
| remember_created_at | datetime      | Lembrado em                |                              |
| name               | string         | Nome                       |                              |
| cpf                | string         | CPF                        |                              |
| last_name          | string         | Sobrenome                  |                              |
| created_at         | datetime       | Criado em                  | `null: false`               |
| updated_at         | datetime       | Atualizado em              | `null: false`               |

---
