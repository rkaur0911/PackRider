class History < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.string 'email'
      t.string 'lic'
      t.text 'status'
      t.datetime 'from'
      t.datetime 'to'
      end
  end
end
