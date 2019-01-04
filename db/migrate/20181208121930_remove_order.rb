class RemoveOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :responsibles, :order, :integer
  end
end
