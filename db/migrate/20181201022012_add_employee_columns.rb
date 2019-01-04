class AddEmployeeColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :sex, :string
  end
end
