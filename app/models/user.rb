class User < ApplicationRecord
  has_secure_password
  has_many :orders
  validates :name, presence: true, length: { in: 3..50 }
  validates :email, presence: true, uniqueness: true
  def is_clerk?
    clerk = role == "clerk" ? true : false
  end

  def is_owner?
    owner = role == "owner" ? true : false
  end

  def self.clerks
    where("role = ?", "clerk")
  end

  def self.customers
    where("role = ?", "customer")
  end

  def self.owners
    where("role = ?", "owner")
  end

  def self.get_user_by_email(email)
    user = all.where("email = ?", email).exists? ? find_by(email: email) : false
  end
end