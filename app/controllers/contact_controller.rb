class ContactController < ApplicationController
  def index
  end

  def message
    redirect_to root_path
  end
end
