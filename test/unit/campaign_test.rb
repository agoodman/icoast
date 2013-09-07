require 'test_helper'

class CampaignTest < ActiveSupport::TestCase

  should belong_to :user
  should have_many :inclusions
  should have_many :images
  should have_many :annotations
  should validate_presence_of :user_id
  should validate_presence_of :title
  
end
