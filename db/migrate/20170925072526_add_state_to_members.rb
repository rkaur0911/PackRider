class AddStateToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :state, :string
  end
end
