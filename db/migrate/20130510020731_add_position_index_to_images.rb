class AddPositionIndexToImages < ActiveRecord::Migration
  
  def change
    add_index :images, [:position]
  end
  
end
