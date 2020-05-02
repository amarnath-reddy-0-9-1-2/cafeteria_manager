class RemoveRatingFromMenuItems < ActiveRecord::Migration[6.0]
  def change

    remove_column :menu_items, :rating, :decimal
  end
end
