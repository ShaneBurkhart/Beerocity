class ContentController < ApplicationController
  before_filter :authenticate_user!

  def basic
    authorize! :view, :basic, :message => 'Access limited to subscribers.'
    @recipe = Recipe.find_by_month_and_year(Date.today.month, Date.today.year)
    @comment = Comment.new(user_id: current_user.id, recipe_id: @recipe.id)
  end

end
