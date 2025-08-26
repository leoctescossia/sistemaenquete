class Poll < ApplicationRecord
  belongs_to :user
  has_many :options, dependent: :destroy
  has_many :votes, through: :options

  enum :poll_type, single_choice: "single_choice", multiple_choice: "multiple_choice"
  enum :status,  open: "open", closed: "closed"

  validates :title, :poll_type, presence: true
  validates :options, length: { minimum: 2, message: "é necessário ter pelo menos 2 opções" }

  accepts_nested_attributes_for :options, allow_destroy: true, reject_if: :all_blank

  def close!
    update(status: "closed")
  end

  def resultados
    options.includes(:votes).map do |opt|
      { option: opt.text, votes: opt.votes.count }
    end
  end

  
end
