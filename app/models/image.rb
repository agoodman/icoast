class Image < ActiveRecord::Base
  
  DELTA = 0.001
  
  attr_accessible :filename, :full_url, :geo_area, :latitude, :longitude, :pre, :storm, :taken_at, :thumb_url
  
  scope :pre, where(pre: true)
  scope :post, where(pre: false)
  scope :nearby, lambda {|lat,lng| where('latitude > ?',lat-DELTA).where('latitude <= ?',lat+DELTA).where('longitude > ?',lng-DELTA).where('longitude <= ?',lng+DELTA) }
  
end
