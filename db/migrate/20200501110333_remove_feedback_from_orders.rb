class RemoveFeedbackFromOrders < ActiveRecord::Migration[6.0]
  def change

    remove_column :orders, :feedback, :string
  end
end
