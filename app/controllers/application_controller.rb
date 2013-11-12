class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :verify_order!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    case current_user.roles.first.name
      when 'admin'
        users_path
      when 'basic'
        content_path
      else
        root_path
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    if(current_user)
      path = content_path
    else
      path = root_pat
    end
    redirect_to path, :alert => exception.message
  end

  private

    def verify_order!
      return unless params[:controller] != "orders" && (params[:action] != "create" || params[:action] != "new")
      return if current_user.has_role? :admin
      redirect_to new_user_order_path, flash: {error: "You need to finish ordering."} unless current_user.order
    end

end
