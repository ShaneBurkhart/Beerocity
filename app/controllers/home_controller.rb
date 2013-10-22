class HomeController < ApplicationController

  def index
    redirect_to content_path if current_user
  end

end
