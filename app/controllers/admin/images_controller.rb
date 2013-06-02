class Admin::ImagesController < ApplicationController
  
  layout 'admin'
  
  respond_to :html, :js, :json
  
  def index
    @images = Image.scoped
    respond_with(@images)
  end
  
  def index_pre
    @images = Image.pre
    respond_with(@images, only: params[:only].split(',').map(&:to_sym))
  end
  
  def index_post
    @images = Image.post.enabled
    respond_with(@images, only: params[:only].split(',').map(&:to_sym))
  end
  
end
