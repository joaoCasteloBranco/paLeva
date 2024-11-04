class CreateServings < ActiveRecord::Migration[7.2]
  def change
    create_table :servings do |t|
      t.references :menu_item, null: false, foreign_key: true
      t.string :description
      t.integer :price

      t.timestamps
    end
  end
end
