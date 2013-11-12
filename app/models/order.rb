class Order < ActiveRecord::Base
  attr_accessible :address, :city, :coupon, :state, :stripe_token, :zipcode, :country

  belongs_to :user

  validates :stripe_token, :address, :city, :state, :zipcode, :country, presence: true

  before_save :update_stripe

  def update_stripe
    return if self.has_role? :admin
    return if email.include?('@example.com') and not Rails.env.production?
    if customer_id.nil?
      if !stripe_token.present?
        raise "Stripe token not present. Can't create account."
      end
        customer = Stripe::Customer.create(
          :email => email,
          :description => full_name,
          :card => stripe_token
        )
    else
      customer = Stripe::Customer.retrieve(customer_id)
      if stripe_token.present?
        customer.card = stripe_token
      end
      customer.email = email
      customer.description = full_name
      customer.save
    end
    self.last_4_digits = customer.cards.data.first["last4"]
    self.customer_id = customer.id
    self.stripe_token = nil

    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "#{e.message}."
      self.stripe_token = nil
      false
  end


end
