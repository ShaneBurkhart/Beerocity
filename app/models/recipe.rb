class Recipe < ActiveRecord::Base
  attr_accessible :description, :name, :month, :year

  validates :description, :name, :month, :year, presence: true

  def human_date
    "#{Date::MONTHNAMES[month]} #{year}"
  end

end
