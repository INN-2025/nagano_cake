class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :payment_method
      t.integer :shipping_cost
      t.integer :total_payment
      t.integer :status

      t.timestamps
    end
  end
end
