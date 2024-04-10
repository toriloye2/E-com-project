class ApplicationController < ActionController::Base

  helper_method :current_order

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path
    else
      products_path
    end
  end

  def current_order
    if session[:order_id].nil?
      Order.new
    else
      begin
        Order.find_by(id: session[:order_id])
      rescue ActiveRecord::RecordNotFound => e
        Order.new
      end
    end
  end
end
