class AddGeocodeFieldsToImages < ActiveRecord::Migration
  def change
    add_column :images, :locality, :string
    add_column :images, :city, :string
    add_column :images, :state, :string
    add_column :images, :geocoded_at, :timestamp
  end
end
