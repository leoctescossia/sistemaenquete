class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :option

  validate :nao_votar_na_propria_enquete
  validates :user_id, uniqueness: { scope: :option_id, message: "já votou nesta opção" }

  private

  def nao_votar_na_propria_enquete
    if option.poll.user_id == user_id
      errors.add(:base, "Você não pode votar em sua própria enquete")
    end
  end
end
