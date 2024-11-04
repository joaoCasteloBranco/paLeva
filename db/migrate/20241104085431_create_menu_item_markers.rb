class CreateMenuItemMarkers < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_item_markers do |t|
      t.references :menu_item, null: false, foreign_key: true
      t.references :marker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
