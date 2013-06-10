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
  
end
