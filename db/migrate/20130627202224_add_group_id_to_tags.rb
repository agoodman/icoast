class AddGroupIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :group_id, :integer
    add_index :tags, [ :group_id ]
  end
end
