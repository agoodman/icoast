class Tag < ActiveRecord::Base
  has_many :annotations
  has_many :images, through: :annotations
  attr_accessible :name
  
  scope :regime, where(regime: true)
  scope :visual, where('regime != ?',true)
  
  before_save :init_regime
  
  def init_regime
    self.regime = false    
  end
  
end
