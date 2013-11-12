class Order < ActiveRecord::Base
  attr_accessible :address, :city, :coupon, :state, :stripe_token, :zipcode
end
