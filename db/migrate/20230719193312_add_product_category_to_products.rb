class AddProductCategoryToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :product_category, foreign_key: true
  end
end
