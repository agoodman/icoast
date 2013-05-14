class Image < ActiveRecord::Base
  
  DELTA = 0.001
  
  has_many :annotations
  has_many :tags, through: :annotations
  
  attr_accessible :filename, :full_url, :geo_area, :latitude, :longitude, :pre, :storm, :taken_at, :thumb_url, :position
  
  scope :positioned, order('position')
  scope :pre, where(pre: true)
  scope :post, where(pre: false)
  scope :nearby, lambda {|lat,lng,rng=DELTA| where('latitude > ?',lat-rng).where('latitude <= ?',lat+rng).where('longitude > ?',lng-rng).where('longitude <= ?',lng+rng)}
  scope :random_post, lambda {|max| post.where(position: rand(max)).limit(1) }

  def self.update_positions(strategy)
    strategy.pre.each_with_index {|e,k| e.update_attributes(position: k)}
    strategy.post.each_with_index {|e,k| e.update_attributes(position: k)}
  end
  
end
