require 'test_helper'

class MatchTest < ActiveSupport::TestCase

  should belong_to :user
  should belong_to :pre_image
  should belong_to :post_image
  
end
