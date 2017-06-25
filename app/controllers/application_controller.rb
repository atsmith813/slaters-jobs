class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

 def load_order
		params[:order_param] ||= session[:order_param]
		session[:order_param] = params[:order_param]
		if params[:order_param].present?
			order_param = params[:order_param]
		else
			order_param = nil
		end
	end
end
