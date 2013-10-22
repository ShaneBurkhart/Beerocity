class HomeController < ApplicationController

  def index
    redirect_to content_path, notice: flash[:notice] if current_user
  end

end
