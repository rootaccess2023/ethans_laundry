class LoyaltyCard < ApplicationRecord
  STAMPS_REQUIRED = 10

  belongs_to :customer
  has_many :stamps, dependent: :destroy

  enum :status, { active: 0, completed: 1 } # active MUST stay 0 — idx_one_active_card_per_customer depends on it

  def reward_ready?
    stamps_count >= STAMPS_REQUIRED
  end

  def add_stamp!(by:)
    with_lock do # FOR UPDATE: serializes two employees stamping the same card
      return false unless active? && stamps_count < STAMPS_REQUIRED

      stamps.create!(admin_user: by, stamped_at: Time.current)
    end
  end

  def claim_free_laundry!
    with_lock do
      return false unless active? && stamps_count >= STAMPS_REQUIRED

      update!(status: :completed, completed_at: Time.current)
      customer.loyalty_cards.create!(status: :active) # old card flipped to completed first, so partial index stays satisfied
    end
  end
end
