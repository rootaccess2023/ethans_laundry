class CreateStamps < ActiveRecord::Migration[7.1]
  def change
    create_table :stamps do |t|
      t.references :loyalty_card, null: false, foreign_key: true
      t.references :admin_user, null: true, foreign_key: true
      t.datetime :stamped_at, null: false

      t.timestamps
    end
  end
end
