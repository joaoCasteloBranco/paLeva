class CreateDiscountServings < ActiveRecord::Migration[7.2]
  def change
    create_table :discount_servings do |t|
      t.references :discount, null: false, foreign_key: true
      t.references :serving, null: false, foreign_key: true

      t.timestamps
    end
  end
end
