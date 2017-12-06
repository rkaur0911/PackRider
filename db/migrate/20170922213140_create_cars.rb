class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string 'lic'
      t.string 'manf'
      t.string 'mod'
      t.string 'style'
      t.string 'location'
      t.float 'rate'
      t.text 'status'
      t.timestamps null: false
    end
  end
end
