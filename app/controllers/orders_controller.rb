class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user!

  def new
    @order = current_user.build_order
  end

  def create
    @order = current_user.build_order params[:order]
  end

  def update
    @order = current_user.order
  end

  private

    def authorize_user!
      authorize! :manage, :order
      redirect_to content_path, flash: {error: "You have already done that."} if current_user.order && controller.action_name != "update"
    end
end
