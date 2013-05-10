class Annotation < ActiveRecord::Base
  belongs_to :image
  belongs_to :tag
  attr_accessible :image_id, :tag_id
end
