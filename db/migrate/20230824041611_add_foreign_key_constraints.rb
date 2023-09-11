class AddForeignKeyConstraints < ActiveRecord::Migration[7.0]
  def change
    change_column_null :empathies, :user_id, false
    change_column_null :empathies, :post_id, false
    change_column_null :posts, :user_id, false

    add_foreign_key :empathies, :users, column: :user_id
    add_foreign_key :empathies, :posts, column: :post_id
    add_foreign_key :posts, :users, column: :user_id
  end
end
