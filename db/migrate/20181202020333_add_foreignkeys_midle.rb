class AddForeignkeysMidle < ActiveRecord::Migration[5.2]
  def change
    remove_column :responsibles, :employee_id
    remove_column :responsibles, :store_id
    add_reference :responsibles, :employee, foreign_key: true
    add_reference :responsibles, :store, foreign_key: true
  end
end
