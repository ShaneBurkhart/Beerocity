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
      redirect_to content_path, flash: {notice: "You have already done that."} if current_user.order
    end
end
