class CreateSuggestions < ActiveRecord::Migration[5.1]
  def change
    create_table :suggestions do |t|
      t.string 'email'
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
