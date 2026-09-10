class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :public_token, null: false

      t.timestamps
    end

    add_index :customers, :public_token, unique: true
  end
end
