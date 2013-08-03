class AddCrowdTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :crowd_type, :string
  end
end
