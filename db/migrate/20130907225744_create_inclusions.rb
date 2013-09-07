class CreateInclusions < ActiveRecord::Migration
  def change
    create_table :inclusions do |t|
      t.integer :image_id
      t.integer :campaign_id
      t.boolean :pre
      t.integer :position

      t.timestamps
    end
  end
end
