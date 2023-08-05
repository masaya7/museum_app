class CreateEmpathies < ActiveRecord::Migration[7.0]
  def change
    create_table :empathies do |t|
      t.integer :empathy
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
