require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_many :annotations
  should have_many :tags
  should have_many :comments
  should have_many :visits
  should have_many :visited_images
  should have_many :campaigns
  
end
