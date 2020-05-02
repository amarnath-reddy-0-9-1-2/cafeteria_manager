class AddRatingsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :ratings, :integer, default: 0
  end
end
