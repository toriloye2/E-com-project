class ProductsController < BaseController

  add_breadcrumb "home", :root_path
  def index
    add_breadcrumb "products", products_path
    @products = Product.page(params[:page])
    @recent_products = Product.recent_products
  end

  def all_products
    @products = params[:search].present? ? Product.joins(:product_category).where("product_categories.name ilike ? or products.name ilike ?","%#{params[:search]}%", "%#{params[:search]}%").page(params[:page]) : Product.all.page(params[:page]).per(12)
  end

  def recent_products
    @recent_products = Product.recent_products
  end

  def featured_products
    @featured_products = Product.featured_products
  end

  def show
    @product = Product.find_by(id: params[:id])
    @order_item = current_order.order_items.new
  end
end
