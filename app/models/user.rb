class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  # has_many :user_roles
  has_many :roles, through: :user_roles, source: :role

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:customer) if self.roles.blank?
  end
end
