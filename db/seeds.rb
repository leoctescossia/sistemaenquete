# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



# Usuário já existente
user = User.find(3)

# Criando algumas enquetes
polls = [
  {
    title: "Qual sua linguagem de programação favorita?",
    description: "Vote na linguagem que você mais gosta de usar no dia a dia.",
    poll_type: "single_choice",
    status: "open",
    options: ["Ruby", "Python", "JavaScript", "JavaScript#"]
  },
  {
    title: "Quais tecnologias você gostaria de aprender em 2025?",
    description: "Selecione todas as tecnologias que tem interesse em estudar.",
    poll_type: "multiple_choice",
    status: "open",
    options: ["Docker", "Kubernetes", "React", "Elixir", "Rust"]
  },
  {
    title: "Você prefere trabalhar remoto ou presencial?",
    description: "Responda de acordo com sua preferência de ambiente de trabalho.",
    poll_type: "single_choice",
    status: "open",
    options: ["Remoto", "Presencial", "Híbrido"]
  }
]

polls.each do |poll_data|
  Poll.create!(
    title: poll_data[:title],
    description: poll_data[:description],
    poll_type: poll_data[:poll_type],
    status: poll_data[:status],
    user_id: user.id,
    options_attributes: poll_data[:options].map { |text| { text: text } }
  )
end

puts "✅ Enquetes criadas para o usuário #{user.name} (id: #{user.id})"