class AddRatingsToMenuItems < ActiveRecord::Migration[6.0]
  def change
    add_column :menu_items, :ratings, :decimal, precision: 2, scale: 1, default: 0.0
  end
end
