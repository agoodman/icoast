class Image < ActiveRecord::Base
  
  DELTA = 0.001
  
  has_many :annotations
  has_many :tags, through: :annotations
  has_many :matches, foreign_key: 'post_image_id'
  has_many :comments
  
  attr_accessible :filename, :full_url, :geo_area, :latitude, :longitude, :pre, :storm, :taken_at, :thumb_url, :position, :enabled
  
  scope :positioned, order('position')
  scope :pre, where(pre: true)
  scope :post, where(pre: false)
  scope :nearby, lambda {|lat,lng,rng=DELTA| where('latitude > ?',lat-rng).where('latitude <= ?',lat+rng).where('longitude > ?',lng-rng).where('longitude <= ?',lng+rng)}
  scope :random, lambda {|max| where(position: rand(max)).limit(1) }
  scope :enabled, where(enabled: true)

  def self.update_positions(strategy)
    strategy.pre.each_with_index {|e,k| e.update_attributes(position: k)}
    strategy.post.each_with_index {|e,k| e.update_attributes(position: k)}
  end

  def tags_for_user(user)
    annotations.for_user(user).map(&:tag) rescue []
  end
  
  def location
    geocode! unless geocoded?
    "#{city || locality}, #{state}"
  end
  
  def geocoded?
    !geocoded_at.blank?
  end
  
  def geocode!
    puts "geocoding image #{id}"
    geo=Geocoder.search("#{latitude},#{longitude}").first rescue nil
    self.locality = geo.address_components.select {|e| e['types'].include?('locality')}.first['short_name'] rescue nil
    self.city = geo.address_components.select {|e| e['types'].include?('administrative_area_level_3')}.first['short_name'] rescue nil
    self.state = geo.address_components.select {|e| e['types'].include?('administrative_area_level_1')}.first['short_name'] rescue nil
    self.geocoded_at = Time.now
    save
  rescue
    false
  end
  
  
end
