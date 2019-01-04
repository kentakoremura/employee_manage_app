class AddForeignkeyMidle < ActiveRecord::Migration[5.2]
  def change
    # 基本形: user_idという名前で users.id への外部キー制約をはる
    #add_reference :tasks, :user, foreign_key: true
    add_reference :responsibles, :employees, foreign_key: true
    add_reference :responsibles, :stores, foreign_key: true
  end
end
