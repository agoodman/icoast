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
  
  def title
    geo=Geocoder.search("#{latitude},#{longitude}").first rescue nil
    puts geo.address_components
    locality = geo.address_components.select {|e| e['types'].include?('locality')}.first['short_name'] rescue nil
    city = geo.address_components.select {|e| e['types'].include?('administrative_area_level_3')}.first['short_name'] rescue nil
    state = geo.address_components.select {|e| e['types'].include?('administrative_area_level_1')}.first['short_name'] rescue nil
    "#{pre ? 'PRE' : 'POST'}-STORM at #{taken_at.to_formatted_s(:long)} in #{city || locality} #{state}"
  end
  
end
