class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.text :address
      t.decimal :zipcode
      t.integer :contact
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
