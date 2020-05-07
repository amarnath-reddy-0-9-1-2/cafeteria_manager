class Menu < ApplicationRecord
  # created by cmd
  # rails generate model MenuItems name:string description:string price:integer menu_id:integer
  has_many :menu_items, dependent: :destroy
  validates :name, presence: true, length: { in: 1..25 }, uniqueness: true
  def self.marked_as_active
    all.where("active = ?", true)
  end

  def get_items(current_user)
    if current_user.is_owner?
      menu_items.order(:active)
    else
      menu_items.where("active = ?", true)
    end
  end

end
