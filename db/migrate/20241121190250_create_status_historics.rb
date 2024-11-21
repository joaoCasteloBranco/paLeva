class CreateStatusHistorics < ActiveRecord::Migration[7.2]
  def change
    create_table :status_historics do |t|
      t.references :order, null: false, foreign_key: true
      t.string :status, null: false
      t.datetime :changed_at, null: false
      t.text :notes

      t.timestamps
    end
  end
end
