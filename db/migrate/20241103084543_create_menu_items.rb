class CreateMenuItems < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_items do |t|
      t.string :type
      t.string :name
      t.text :description
      t.integer :status, default: 1
      t.integer :calories
      t.string :photo
      t.references :restaurant, null: false, foreign_key: true
      t.boolean :alcoholic

      t.timestamps
    end
  end
end
