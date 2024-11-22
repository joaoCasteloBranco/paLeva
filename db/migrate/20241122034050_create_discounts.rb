class CreateDiscounts < ActiveRecord::Migration[7.2]
  def change
    create_table :discounts do |t|
      t.string :name, null: false
      t.integer :value, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :limit_usage

      t.timestamps
    end
  end
end
