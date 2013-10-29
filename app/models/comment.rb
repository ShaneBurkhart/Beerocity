class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id, :recipe_id, :user_id

  belongs_to :recipe
  belongs_to :user

  validates :recipe_id, :user_id, :body, presence: true
end
