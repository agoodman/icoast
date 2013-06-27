require 'test_helper'

class TagTest < ActiveSupport::TestCase

  should belong_to :user
  should belong_to :group
  should have_many :annotations
  should have_many :images

end
