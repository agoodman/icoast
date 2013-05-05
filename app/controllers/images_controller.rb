class ImagesController < ApplicationController
  
  respond_to :html, :js, :json
  
  def index
    @pre_images = Image.pre.order('taken_at asc')
    @post_images = Image.post.order('taken_at asc')
    @storms = Image.all.map(&:storm).uniq
  end
  
  def pre
    @image = Image.pre.find(params[:id])
    respond_with(@image)
  end
  
  def post
    @image = Image.post.find(params[:id])
    respond_with(@image)
  end
  
  def nearest_pre
    post_image = Image.find(params[:id])
    @image = Image.pre.nearby(post_image.latitude, post_image.longitude).first
    respond_with(@image)
  end
  
  def nearest_post
    pre_image = Image.find(params[:id])
    @image = Image.post.nearby(pre_image.latitude, pre_image.longitude).first
    respond_with(@image)
  end
  
end
