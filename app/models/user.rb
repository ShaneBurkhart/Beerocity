class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password,
    :password_confirmation, :remember_me, :stripe_token, :coupon,
    :address, :city, :state, :zipcode, :country

  has_many :comments
  has_one :order

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  after_create :send_welcome


  def update_plan(role)
    self.role_ids = []
    self.add_role(role.name)
    unless customer_id.nil?
      # customer = Stripe::Customer.retrieve(customer_id)
      # customer.update_subscription(:plan => role.name)
    end
    true
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    false
  end

  def expire
    UserMailer.expire_email(self).deliver
    destroy
  end

  def full_name
    first_name + last_name
  end

  def self.avatar_url email
    hash = Digest::MD5.hexdigest(email.strip)
    "http://www.gravatar.com/avatar/#{hash}?s=200&d=mm"
  end

  private

    def send_welcome
      UserMailer.signup_email(self).deliver
    end

end
