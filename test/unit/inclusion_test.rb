require 'test_helper'

class InclusionTest < ActiveSupport::TestCase

  should belong_to :campaign
  should belong_to :image
  
  should validate_presence_of :campaign_id
  should validate_presence_of :image_id
  should validate_presence_of :pre

end
