require 'position_normal_strategy'
class Image < ActiveRecord::Base
  
  DELTA = 0.001
  
  has_many :annotations
  has_many :tags, through: :annotations
  has_many :matches, foreign_key: 'post_image_id'
  has_many :comments
  has_many :visits
  has_many :visitors, through: :visits, source: :user, class_name: 'User'
  
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

  def as_json(options={})
    json = super(options)
    json['annotated'] = annotated(options[:user_id]) if options[:user_id]
    json
  end
  
  def tags_for_user(user)
    annotations.for_user(user).map(&:tag) rescue []
  end
  
  def location
    geocode! unless geocoded?
    "#{city || locality}, #{state}"
  end
  
  def annotated(user_id)
    annotations.select {|e| e.user_id.to_i==user_id.to_i}.any?
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
  rescue Exception => e
    puts "error: #{e}"
    false
  end
  
  def normal?
    !normal_x.blank? && !normal_y.blank?
  end
  
  def calculate_normal!
    puts "calculating normal for image #{id}"
    strategy = PositionNormalStrategy
    nx, ny = strategy.normal_for(self)
    self.normal_x = nx
    self.normal_y = ny
    save
  rescue Exception => e
    puts "error: #{e}"
    false
  end
  
end
