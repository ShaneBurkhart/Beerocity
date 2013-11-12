class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :stripe_token
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.string :coupon
      t.integer :user_id

      t.timestamps
    end
  end
end
