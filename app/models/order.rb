class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  # validate :user_present
  enum status: { new: 0, paid: 1, shipped: 2, cancelled: 3 }, _prefix: :type
  enum payment_method: { cash_on_delivery: 0, online_payment: 1 }

  private

  def user_present
    if user_id.nil?
      errors.add(:user, "is necessary.")
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "delivery_charges", "id", "payment_method", "status", "total", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "user"]
  end
end
