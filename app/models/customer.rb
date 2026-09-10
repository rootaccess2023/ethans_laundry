class Customer < ApplicationRecord
  has_secure_token :public_token

  has_many :loyalty_cards, dependent: :destroy

  after_create :create_active_card

  def active_card
    loyalty_cards.find_by(status: :active)
  end

  def completed_cards_count
    loyalty_cards.completed.count
  end

  private

  def create_active_card
    loyalty_cards.create!(status: :active)
  end
end
