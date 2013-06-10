require 'test_helper'

class ImageTest < ActiveSupport::TestCase

  should have_many :annotations
  should have_many :tags
  should have_many :matches
  should have_many :comments
  
end
