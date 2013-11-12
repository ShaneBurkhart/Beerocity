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

  def update_card
    @user = current_user
    @user.stripe_token = params[:user][:stripe_token]
    if @user.save
      redirect_to edit_user_registration_path, :notice => 'Updated card.'
    else
      flash.alert = 'Unable to update card.'
      render :edit
    end
  end


  private

    def authorize_user!
      authorize! :manage, :order
      redirect_to content_path, flash: {error: "You have already done that."} if current_user.order && controller.action_name != "update"
    end
end
