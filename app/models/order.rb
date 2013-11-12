class Order < ActiveRecord::Base
  attr_accessible :address, :city, :coupon, :state, :zipcode,
    :country, :last_4_digits, :customer_id, :stripe_token

  belongs_to :user

  validates :address, :city, :state, :zipcode, :country, presence: true, if: lambda{|o| o.current_step == "shipping"}
  validates :stripe_token, presence: true, if: lambda{|o| o.current_step == "payment"}

  attr_accessor :current_step, :stripe_token

  before_save :update_stripe
  before_validation :country_usa


  def update_stripe
    return if self.user.has_role? :admin
    return if self.user.email.include?('@example.com') and not Rails.env.production?
    if customer_id.nil?
      if !stripe_token.present?
        raise "Stripe token not present. Can't create account."
      end
        customer = Stripe::Customer.create(
          :email => self.user.email,
          :description => self.user.full_name,
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

  def last_step?
    self.current_step == steps.last
  end

  def first_step?
    self.current_step == steps.first
  end

  def next_step
    self.current_step = steps[steps.index(self.current_step) + 1]
  end

  def previous_step
    self.current_step = steps[steps.index(self.current_step) - 1]
  end

  def current_step
    @current_step || steps.first
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

  def progress
    steps.index(self.current_step).to_f / steps.length * 100
  end

  private

    def steps
      %w[shipping payment]
    end

    def country_usa
      self.country = "USA"
    end

end
