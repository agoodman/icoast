class Api::V1::BaseController < ApplicationController

  include Serviceable
  
  def did_assign_collection
    @collection = @collection.scoped
  end
  
end
