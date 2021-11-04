class CreateReservation < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer  :guest_id, index: true
      t.string   :code, index: true, unique: true
      t.string   :status
      t.datetime :start_date
      t.datetime :end_date
      t.integer  :nights
      t.integer  :guests
      t.integer  :adults
      t.integer  :children
      t.integer  :infants
      t.string   :currency
      t.decimal  :payout_price, default: 0.0
      t.decimal  :security_price, default: 0.0
      t.decimal  :total_price, default: 0.0
      t.decimal  :expected_payout_amount, default: 0.0

      t.timestamps
    end
  end
end
