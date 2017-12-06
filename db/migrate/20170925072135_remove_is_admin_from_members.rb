class RemoveIsAdminFromMembers < ActiveRecord::Migration[5.1]
  def change
    remove_column :members, :isAdmin, :boolean
  end
end
