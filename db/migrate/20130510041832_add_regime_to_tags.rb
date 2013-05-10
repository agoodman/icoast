class AddRegimeToTags < ActiveRecord::Migration
  def change
    add_column :tags, :regime, :boolean
  end
end
