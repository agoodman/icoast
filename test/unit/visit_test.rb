require 'test_helper'

class VisitTest < ActiveSupport::TestCase

  should belong_to :user
  should belong_to :image
  
  should validate_presence_of :user_id
  should validate_presence_of :image_id
  
end
