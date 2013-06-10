require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  should belong_to :image
  should belong_to :user
  
  should validate_presence_of :image_id
  should validate_presence_of :user_id
  
end
