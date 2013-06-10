require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_many :annotations
  should have_many :tags
  should have_many :comments
  
end
