class Annotation < ActiveRecord::Base
  belongs_to :image
  belongs_to :tag
  belongs_to :user
  attr_accessible :image_id, :tag_id, :user_id
  
  scope :for_user, lambda {|user| where(user_id: user.id)}
end
