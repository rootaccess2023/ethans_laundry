class CreateLoyaltyCards < ActiveRecord::Migration[7.1]
  def change
    create_table :loyalty_cards do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.integer :stamps_count, null: false, default: 0
      t.datetime :completed_at

      t.timestamps
    end

    add_index :loyalty_cards, [:customer_id, :status]

    add_index :loyalty_cards, :customer_id, unique: true,
              where: "status = 0", name: "idx_one_active_card_per_customer"
  end
end
