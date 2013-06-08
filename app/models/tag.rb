class Tag < ActiveRecord::Base

  belongs_to :user
  has_many :annotations
  has_many :images, through: :annotations

  attr_accessible :name, :regime, :user_id
  
  scope :regime, where(regime: true)
  scope :visual, where(regime: false)
  scope :user_generated, where('tags.user_id is not null')
  
end
