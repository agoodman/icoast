class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :image

  validates_presence_of :user_id, :image_id
  
  attr_accessible :body, :image_id, :user_id
  
end
