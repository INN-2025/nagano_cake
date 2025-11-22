class SetDefaultStatusOnExistingOrders < ActiveRecord::Migration[6.1]
  def up
    Order.where(status: nil).update_all(status: 0)
  end

  def down
    Order.where(status: 0).update_all(status: nil)
  end
end
