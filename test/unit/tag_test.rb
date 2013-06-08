require 'test_helper'

class TagTest < ActiveSupport::TestCase

  should belong_to :user
  should have_many :annotations
  should have_many :images

end
