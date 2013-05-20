class Match < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :pre_image, class_name: 'Image'
  belongs_to :post_image, class_name: 'Image'
  
  attr_accessible :post_image_id, :pre_image_id, :user_id
  
  scope :for_user, lambda {|user| where(user_id: user.id)}

end
