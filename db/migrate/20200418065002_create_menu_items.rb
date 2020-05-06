class CreateMenuItems < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_items do |t|
      t.integer :menu_id
      t.string :name
      t.string :description
      t.integer :price
      t.decimal :rating
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
