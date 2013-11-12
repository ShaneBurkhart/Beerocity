class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.string :coupon
      t.integer :user_id
      t.string :customer_id
      t.string :last_4_digits


      t.timestamps
    end
  end
end
