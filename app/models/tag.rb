class Tag < ActiveRecord::Base
  has_many :annotations
  has_many :images, through: :annotations
  attr_accessible :name, :regime
  
  scope :regime, where(regime: true)
  scope :visual, where(regime: false)
  
  before_validation :init_regime
  
  def init_regime
    self.regime = false if regime.blank?
  end
  
end
