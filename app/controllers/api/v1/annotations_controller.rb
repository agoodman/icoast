class Api::V1::AnnotationsController < Api::V1::BaseController
  
  acts_as_service :annotation
  
end
