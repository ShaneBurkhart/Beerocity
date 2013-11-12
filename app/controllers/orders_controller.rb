class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user!

  def new
    session[:order_params] ||= {}
    @order = current_user.build_order session[:order_params]
    @order.current_step = session[:order_step]
  end

  def create
    session[:order_params].deep_merge!(params[:order]) if params[:order]
    @order = current_user.build_order session[:order_params]
    @order.current_step = session[:order_step]
    if @order.valid?
      if params[:back_button]
        @order.previous_step
      elsif @order.last_step?
        @order.save if @order.all_valid?
      else
        @order.next_step
      end
      session[:order_step] = @order.current_step
    end
    if @order.new_record?
      render "new"
    else
      session[:order_step] = session[:order_params] = nil
      redirect_to content_path, flash: {notice: "You are successfully signed up!"}
    end
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
