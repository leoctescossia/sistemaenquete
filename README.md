# Sistema de enquete

[![Ruby Version](https://img.shields.io/badge/Ruby-3.3.7-%23CC342D)](https://www.ruby-lang.org/)
[![Rails Version](https://img.shields.io/badge/Rails-8.0.2-%23CC0000)](https://rubyonrails.org)
[![TailwindCSS Version](https://img.shields.io/badge/Tailwind_CSS-grey)](https://tailwindcss.com/docs/installation/framework-guides/ruby-on-rails)


Sistema de enquetes desenvolvido em Ruby on Rails que permite a criação, gerenciamento e votação em enquetes. O sistema possui dois tipos de usuários (Admin e User) com permissões diferenciadas.

Aqui está o passo a passo utilizado para a construção do projeto, e como rodar ele.


* Paleta de cores: Azul, laranja, âmber e tons de cinza


# Como Executar

**Pré-requisitos**

- rails 8.0.2

- ruby-3.3.7

- PostgreSQL

- TailwindCSS

- HTML5 + ERB


# Como configurar o create do Banco de Dados com o seu PostgreSQL


1 - git clone https://github.com/leoctescossia/sistemaenquete
2 - cd sistemaenquete
3 - bundle install/yarn install
4 - Descubra seu usuário do PostgreSQL e sua senha de acesso
5 - Modifique e troque os:
```
username, password.
```
Ambos estarão comentados.
6 - Siga os próximos passos
7 - rails db:create
8 - rails db:migrate
9 - (Opcional) Caso queira executar a seed.
```
rails db:seed
```
9 - rails server
10 - (Opcional, mas recomendo para ver melhor o design do tailwindcss): rails tailwindcss:watch

# Regras Definidas
```
Usuários comuns podem criar enquetes e votar
```
```
Administradores podem gerenciar todos os usuários
```
```
Votação própria é impedida
```
```
Exibir as próprias enquetes, e quais enquetes votou
```
```
Enquetes abertas permitem votação (Múltiplas ou Única)
```
```
Exclusão/Inativar usuário fecha suas enquetes
```


## 👥 Usuários de Teste
| Perfil       | Email               | Senha     | Acesso  |
|--------------|---------------------|-----------|---------|
| Administrador| admin@example.com   | 123456    | Admin   |
| Usuário      | leleomengo201233@gmail.com | teste123 | User |
| Novo Usuário | novousuario1@gmail.com | teste1234 | User |


**Dica:** Crie seu usuário personalizado:
- Rails c
- Insira no console:
```ruby
User.create!(
    name: "Exemplo1",
    email: "example1@example.com",
    password: "teste123",
    password_confirmation: "teste123",
    role: "admin",
    active: true
)
```