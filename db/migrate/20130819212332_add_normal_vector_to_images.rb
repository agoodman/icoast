class AddNormalVectorToImages < ActiveRecord::Migration
  def change
    add_column :images, :normal_x, :float
    add_column :images, :normal_y, :float
  end
end
