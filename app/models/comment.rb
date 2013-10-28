class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id, :recipe_id, :user_id

  belongs_to :recipe
  belongs_to :user

end
