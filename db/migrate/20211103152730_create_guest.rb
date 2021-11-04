class CreateGuest < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :email, index: true, unique: true
      t.string :first_name
      t.string :last_name
      t.string :phone_numbers, array: true
      t.text   :localized_description

      t.timestamps
    end
  end
end
