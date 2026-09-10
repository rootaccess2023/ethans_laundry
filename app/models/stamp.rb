class Stamp < ApplicationRecord
  belongs_to :loyalty_card, counter_cache: true
  belongs_to :admin_user, optional: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[stamped_at created_at updated_at id loyalty_card_id admin_user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[loyalty_card admin_user]
  end
end
