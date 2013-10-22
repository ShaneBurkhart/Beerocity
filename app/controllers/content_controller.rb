class ContentController < ApplicationController
  before_filter :authenticate_user!

  def basic
    authorize! :view, :basic, :message => 'Access limited to subscribers.'
  end

end
