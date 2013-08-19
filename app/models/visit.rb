class Visit < ActiveRecord::Base

  belongs_to :user
  belongs_to :image
  
  attr_accessible :image_id, :user_id
  
  validates_presence_of :user_id, :image_id
  
end
