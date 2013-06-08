require 'test_helper'

class AnnotationTest < ActiveSupport::TestCase

  should belong_to :user
  should belong_to :tag

end
