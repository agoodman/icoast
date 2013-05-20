class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :user_id
      t.integer :post_image_id
      t.integer :pre_image_id

      t.timestamps
    end
  end
end
