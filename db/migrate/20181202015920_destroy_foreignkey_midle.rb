class DestroyForeignkeyMidle < ActiveRecord::Migration[5.2]
  def change
    remove_column :responsibles, :employees_id, :integer
    remove_column :responsibles, :stores_id, :integer
  end
end
