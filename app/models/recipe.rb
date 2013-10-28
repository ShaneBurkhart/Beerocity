class Recipe < ActiveRecord::Base
  attr_accessible :description, :name, :month, :year

  validates :description, :name, :month, :year, presence: true

  has_many :comments

  def human_date
    "#{Date::MONTHNAMES[month]} #{year}"
  end

end
