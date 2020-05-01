
class User < ApplicationRecord
  has_secure_password


  def self.get_user_by_email(email)
    user = all.where("email = ?", email).exists? ? find_by(email: email) : false
  end

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
end