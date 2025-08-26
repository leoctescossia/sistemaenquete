class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :polls, dependent: :nullify
  has_many :votes, dependent: :destroy

  # Enum de roles
  enum :role, user: 0, admin: 1

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  # Apenas usuários ativos podem logar
  def active_for_authentication?
    super && active?
  end

  # Mensagem personalizada para usuários inativos
  def inactive_message
    active? ? super : :inactive
  end

  # before_destroy :fechar_se_usuario
  def inativar!
    update(active: false, delete_at: Time.current)
    fechar_se_usuario
  end

  def ativar!
    update(active: true, created_at: Time.current)
  end


  private

  def fechar_se_usuario
    return unless user?
    polls.update_all(status: "closed")
  end
end
