class RemoveStatusFromOrders < ActiveRecord::Migration[6.0]
  def change

    remove_column :orders, :status, :string
  end
end
