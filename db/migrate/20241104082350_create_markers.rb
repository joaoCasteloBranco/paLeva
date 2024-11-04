class CreateMarkers < ActiveRecord::Migration[7.2]
  def change
    create_table :markers do |t|
      t.string :name
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
