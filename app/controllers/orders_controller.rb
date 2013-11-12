class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user!

  def new

  end

  def create
  end

  def update
  end

  private

    def authorize_user!
      authorize! :manage, :order
      redirect_to content_path, flash: {error: "You have already done that."} if current_user.order && controller.action_name != "update"
    end
end
