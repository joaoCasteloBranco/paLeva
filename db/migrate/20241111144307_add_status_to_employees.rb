class AddStatusToEmployees < ActiveRecord::Migration[7.2]
  def change
    add_column :employees, :status, :integer
  end
end
