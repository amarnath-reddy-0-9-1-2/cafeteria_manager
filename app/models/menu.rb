class Menu < ApplicationRecord
  # created by cmd
  # rails generate model MenuItems name:string description:string price:integer menu_id:integer
  has_many :menu_items, dependent: :destroy
  validates :name, presence: true, length: { in: 1..25 }, uniqueness: true
  def self.marked_as_active
    all.where("active = ?", true)
  end
end
