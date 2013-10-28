module RecipesHelper

  def years
    (Date.today.year - 3) .. (Date.today.year + 3)
  end

  def months
    (1..12).map do |month|
      [Date::MONTHNAMES[month], month]
    end
  end

  def recipe_class(recipe)
    if(recipe.month == Date.today.month && recipe.year == Date.today.year)
      "success"
    elsif(recipe.month > Date.today.month && recipe.year >= Date.today.year)
      "warning"
    else
      ""
    end
  end

end
