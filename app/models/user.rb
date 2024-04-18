class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :user_roles
  # has_many :roles, through: :user_roles, source: :role

  # has_one : user_role

  after_create :assign_default_role
# Add stripe_customer_id attribute
attribute :stripe_customer_id, :string

  def assign_default_role
    self.add_role(:customer) if self.roles.blank?
  end
end
