class AddMissingIndexes < ActiveRecord::Migration

  def change
    add_index :annotations, [ :image_id ]
    add_index :annotations, [ :image_id, :user_id ]
    add_index :annotations, [ :user_id ]
    add_index :annotations, [ :tag_id ]
    add_index :annotations, [ :image_id, :tag_id, :user_id ]
    add_index :annotations, [ :tag_id, :user_id ]
    add_index :annotations, [ :image_id, :tag_id ]
    add_index :comments, [ :image_id ]
    add_index :comments, [ :user_id ]
    add_index :comments, [ :image_id, :user_id ]
    add_index :matches, [ :pre_image_id, :post_image_id ]
    add_index :matches, [ :pre_image_id, :post_image_id, :user_id ]
    add_index :tags, [ :user_id ]
  end

end
