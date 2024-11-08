class CreateMenuContents < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_contents do |t|
      t.references :menu, null: false, foreign_key: true
      t.references :menu_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
