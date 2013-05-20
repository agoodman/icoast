class AddEnabledToImages < ActiveRecord::Migration
  def change
    add_column :images, :enabled, :boolean
    Image.update_all(enabled: true)
  end
end
