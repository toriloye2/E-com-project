class OrdersController < BaseController
  def create
    @order_item = OrderItem.where("product_id = ? AND order_id = ?", params[:order_item][:product_id], session[:order_id]).first
    if @order_item
      @order_item.update(quantity: @order_item.quantity + params[:order_item][:quantity].to_i)
      @order_item.save
    else
      @order = current_order
      @order.user = current_user.present? ? current_user : User.last
      @order.order_items.new(order_item_params)
      @order.save
      session[:order_id] = @order.id
    end
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find_by(id: params[:id])
    @order_item.update(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find_by(id: params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end

  def checkout
    if !current_user
      redirect_to new_user_session_path
    elsif params["payment_method"] == "0"
      current_order.update(address: params["address"], payment_method: params["payment_method"].to_i, user_id: current_user.id, status: 0)
      redirect_to post_checkout_path
    else
      redirect_to new_payment_path
    end
  end

  def post_checkout
    @order = current_order
    session[:order_id] = nil
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :price)
  end

end
