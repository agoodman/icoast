class Admin::ImagesController < ApplicationController
  
  layout 'admin'
  
  respond_to :html, :js
  
  def index
    @images = Image.paginate(page: params[:page] || 1, per_page: params[:per_page] || 100)
    respond_with(@images)
  end
  
end
