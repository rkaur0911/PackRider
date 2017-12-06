class CreateCarAvailability < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string 'email'
      t.string 'lic'
    end
  end
end
