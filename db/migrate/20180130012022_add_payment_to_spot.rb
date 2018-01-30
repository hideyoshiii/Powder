class AddPaymentToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :payment, :string
  end
end
