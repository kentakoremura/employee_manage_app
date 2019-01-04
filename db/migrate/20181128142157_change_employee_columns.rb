class ChangeEmployeeColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :password_digest, :string
    remove_column :employees, :password, :string
  end
end
