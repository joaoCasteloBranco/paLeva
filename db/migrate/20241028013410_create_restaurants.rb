class CreateRestaurants < ActiveRecord::Migration[7.2]
  def change
    create_table :restaurants do |t|
      t.references :user, null: false, foreign_key: true
      t.string :registered_name
      t.string :comercial_name
      t.string :cnpj
      t.text :address
      t.string :phone
      t.string :email
      t.string :code

      t.timestamps
    end
  end
end
