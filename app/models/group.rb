class Group < ActiveRecord::Base
  
  has_many :tags, dependent: :destroy
  
  attr_accessible :name
  
end
