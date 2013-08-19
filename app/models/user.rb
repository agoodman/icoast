class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :annotations
  has_many :tags
  has_many :matches
  has_many :comments
  has_many :visits
  has_many :visited_images, through: :visits, source: :image, class_name: 'Image'
  
  def visit!(image)
    visits.create(image_id: image.id)
  end
  
end
