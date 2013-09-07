class Inclusion < ActiveRecord::Base
  
  belongs_to :campaign
  belongs_to :image
  
  validates_presence_of :campaign_id, :image_id, :pre
  
  attr_accessible :campaign_id, :image_id
  
end
