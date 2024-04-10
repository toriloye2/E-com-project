class OrderItem < ApplicationRecord
  belongs_to :product
  # belongs_to :order
  # validate :product_necessary
  # validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  # validate :order_necessary

  before_save :calculate_total_amount
  after_save :update_order

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_id", "price", "product_id", "quantity", "updated_at"]
  end
  private

  def order_necessary
    if order_id.nil?
      errors.add(:order, "is necessary.")
    end
  end
  def product_necessary
    if product_id.nil?
      errors.add(:product, "is necessary.")
    end
  end

  def calculate_total_amount
    self.total_amount = quantity.to_f * price.to_f
  end

  def update_order
    order = Order.find_by(id: self.order_id)
    order.total = order.order_items.sum(:total_amount)
    order.save!
  end

end
