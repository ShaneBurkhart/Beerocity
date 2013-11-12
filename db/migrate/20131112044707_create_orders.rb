class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :stripe_token
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :coupon

      t.timestamps
    end
  end
end
