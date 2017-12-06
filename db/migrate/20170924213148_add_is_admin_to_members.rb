class AddIsAdminToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :isAdmin, :boolean
  end
end
