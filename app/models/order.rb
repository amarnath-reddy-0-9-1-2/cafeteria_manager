class Order < ApplicationRecord
  # created by cmd
  # rails generate model MenuItems date:datetime user_id:integer delivered_at:datetime
  has_many :order_items, dependent: :destroy
  belongs_to :user
  validates :address, presence: true, length: { in: 5..25 }

  def order_item(menu_item_name)
    order_items.where(menu_item_name: menu_item_name).first
  end

  def all_menu_item_names
    order_items.order(:menu_item_name).map { |item| item.menu_item_name }
  end

  def get_number_of_items(order_item)
    order_items.where(id: order_item.id).count
  end

  def self.get_order_by_id(id)
    order = all.where("id = ?", id).exists? ? find(id) : false
  end

  def self.under_process
    where("status= ?", "Under Process")
  end

  def to_clear_string
    "#{id} #{date} ITEMS:#{order_items.map { |item| item.menu_item_name }.join("--")} TOTAL PRICE:#{total_price} STATUS:++#{status} #{delivered_at}"
  end

  def self.not_under_process
    where.not("status = ? ", "Under Process")
  end

  def self.delivered
    where("status= ?", "order_delivered")
  end

  def self.pending_orders
    where("status= ?", "order_confirmed")
  end

  def order_status
    if status == "Under Process"
      "Being created"
    elsif status == "order_confirmed"
      "Order Confirmed"
    else
      "Delivered at #{delivered_at.strftime("%d %B,%Y - %I:%M %p")}"
    end
  end

  def total_price
    price = 0
    order_items.each { |item| price = price + item.menu_item_price }
    price
  end

  def walkin_order?
    user = User.find(user_id)
    if user.is_owner? || user.is_clerk?
      true
    else
      false
    end
  end

  def self.get_orders_between(start_date, end_date)
    all.where("date >= ? and  date<= ?", start_date, end_date)
  end
end
