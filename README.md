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


# Imagens do sistema
![Dashboard Admin](/app/assets/images/Captura%20de%20tela%202025-08-27%20081729.png)


# Como configurar o create do Banco de Dados com o seu PostgreSQL


- git clone https://github.com/leoctescossia/sistemaenquete
- cd sistemaenquete
- bundle install/yarn install
- Descubra seu usuário do PostgreSQL e sua senha de acesso
- Modifique e troque os:
```
username, password.
```
Ambos estarão comentados.
- Siga os próximos passos
- rails db:create
- rails db:migrate
- (Opcional) Caso queira executar a seed.
```
rails db:seed
```
- rails server
- (Opcional, mas recomendo para ver melhor o design do tailwindcss): rails tailwindcss:watch

# Como instalar o tailwindcss em Ruby on Rails
```
./bin/bundle add tailwindcss-ruby
./bin/bundle add tailwindcss-rails
./bin/rails tailwindcss:install
```

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
Exclusão/Inativar usuário fecha suas enquetes (Optei por utilizar o método de inativação ao invés da exclusão. Mantém os registros das enquetes, e mantém o usuário no sistema, permitindo a reativação por parte do Admin.)
```

## Pontos que poderiam ser melhorados
- Experiência do usuário: Adicionar mais páginações. Modais de conclusão e exclusão. Mais filtros de busca
- Prazo de data: Permitir que o usuário adicione uma data limite, e quando a data chegar, a enquete ser encerrada automaticamente.
- Aumentar o número de opções de votação, para além de 4 opções.




## Paineis Usuário
<div style="display: flex; justify-content: center; gap: 10px;">
  <img src="/app/assets/images/Captura de tela 2025-08-25 201021.png" alt="Usuários" style="width: 40%; height: auto; object-fit: cover;" />
  <img src="/app/assets/images/Captura de tela 2025-08-25 201030.png" alt="User" style="width: 40%; height: auto; object-fit: cover;" />
  <img src="/app/assets/images/Captura de tela 2025-08-25 201059.png" alt="Criar-User" style="width: 40%; height: auto; object-fit: cover;" />
  <img src="/app/assets/images/Captura de tela 2025-08-25 201049.png" alt="User" style="width: 40%; height: auto; object-fit: cover;" />
  <img src="/app/assets/images/Captura de tela 2025-08-25 222052.png" alt="Enquetes" style="width: 40%; height: auto; object-fit: cover;" />
</div>

## Enquetes
<div style="display: flex; justify-content: center; gap: 10px;">
  <img src="/app/assets/images/Captura de tela 2025-08-27 081743.png" alt="Enquetes" style="width: 40%; height: auto; object-fit: cover;" />
  <img src="/app/assets/images/Captura de tela 2025-08-25 204300.png" alt="Enquetes" style="width: 40%; height: auto; object-fit: cover;" />
  <img src="/app/assets/images/Captura de tela 2025-08-25 204439.png" alt="Enquetes" style="width: 40%; height: auto; object-fit: cover;" />
  <img src="/app/assets/images/Captura de tela 2025-08-27 082136.png" alt="Enquetes" style="width: 40%; height: auto; object-fit: cover;" />
  <img src="/app/assets/images/Captura de tela 2025-08-27 084215.png" alt="Enquetes" style="width: 40%; height: auto; object-fit: cover;" />
</div>

## Login
<div style="display: flex; justify-content: center; gap: 10px;">
  <img src="/app/assets/images/Captura de tela 2025-08-27 084204.png" alt="Login" style="width: 40%; height: auto; object-fit: cover;" />
  <img src="/app/assets/images/Captura de tela 2025-08-27 084240.png" alt="Login" style="width: 40%; height: auto; object-fit: cover;" />
</div>


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

## Diagrama Relacional
![Diagrama Relacional](/app/assets/images/dunnas.png)