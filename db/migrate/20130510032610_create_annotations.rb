class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.integer :image_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
