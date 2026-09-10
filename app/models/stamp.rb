class Stamp < ApplicationRecord
  belongs_to :loyalty_card, counter_cache: true
  belongs_to :admin_user, optional: true
end
