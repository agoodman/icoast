class Api::V1::ImagesController < Api::V1::BaseController
  
  acts_as_service :image
  
end
