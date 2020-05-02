class AddNoOfRatingsToMenuItems < ActiveRecord::Migration[6.0]
  def change
    add_column :menu_items, :no_of_ratings, :integer, default: 0
  end
end
