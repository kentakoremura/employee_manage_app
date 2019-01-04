class CreateResponsibles < ActiveRecord::Migration[5.2]
  def change
    create_table :responsibles do |t|
      t.integer :employee_id
      t.integer :store_id
      t.integer :order

      t.timestamps
    end
  end
end
