class PaymentsController < BaseController
  def new
  end

  def create
    @amount = current_order.total

    customer = Stripe::Customer.create email: params[:"cardholder-email"],
                                       :source => params[:stripeToken]

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => 5000,
      :description => 'Stripe customer',
      :currency => 'usd'
    )

    session[:order_id] = nil
    current_order.update(user_id: current_user.id, status: 1)

  rescue Stripe::CardError => e
    flash[:notice] = e.message
    redirect_to new_payment_path
  end

end
