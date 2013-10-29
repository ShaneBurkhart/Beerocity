class Recipe < ActiveRecord::Base
  attr_accessible :description, :name, :month, :year
  has_attached_file :image

  validates :description, :name, :month, :year, presence: true

  has_many :comments

  def human_date
    "#{Date::MONTHNAMES[month]} #{year}"
  end

  def self.current_recipe
    Recipe.find_by_month_and_year(Date.today.month, Date.today.year)
  end

end
