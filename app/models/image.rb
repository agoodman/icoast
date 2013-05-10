class Image < ActiveRecord::Base
  
  DELTA = 0.001
  
  attr_accessible :filename, :full_url, :geo_area, :latitude, :longitude, :pre, :storm, :taken_at, :thumb_url, :position
  
  scope :positioned, order('position')
  scope :pre, where(pre: true)
  scope :post, where(pre: false)
  scope :nearby, lambda {|lat,lng,rng=DELTA| where('latitude > ?',lat-rng).where('latitude <= ?',lat+rng).where('longitude > ?',lng-rng).where('longitude <= ?',lng+rng)}

  def self.update_positions(strategy)
    strategy.pre.each_with_index {|e,k| e.update_attributes(position: k)}
    strategy.post.each_with_index {|e,k| e.update_attributes(position: k)}
  end
  
end
