class AddAmountToHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :histories, :amount, :float
  end
end
