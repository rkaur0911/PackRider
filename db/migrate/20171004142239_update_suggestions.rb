class UpdateSuggestions < ActiveRecord::Migration[5.1]
  def change
    add_column :suggestions, :active, :boolean, default: true
  end
end
