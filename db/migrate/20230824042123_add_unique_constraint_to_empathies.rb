class AddUniqueConstraintToEmpathies < ActiveRecord::Migration[7.0]
  def change
    add_index :empathies, [:user_id, :post_id, :empathy], unique: true
  end
end
