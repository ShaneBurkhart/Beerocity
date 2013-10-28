class ContentController < ApplicationController
  before_filter :authenticate_user!

  def basic
    authorize! :view, :basic, :message => 'Access limited to subscribers.'
    @recipe = Recipe.find_by_month_and_year(Date.today.month, Date.today.year)
  end

end
