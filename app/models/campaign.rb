class Campaign < ActiveRecord::Base
  
  belongs_to :user
  has_many :inclusions
  has_many :images, through: :inclusions
  has_many :annotations
  has_many :tags, through: :annotations
  
  validates_presence_of :user_id, :title
  
  attr_accessible :body, :title, :user_id
  
end
