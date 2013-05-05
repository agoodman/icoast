class ImagesController < ApplicationController
  
  respond_to :html, :js, :json
  
  def index
    @pre_images = Image.pre.order('taken_at asc')
    @post_images = Image.post.order('taken_at asc')
    @storms = Image.all.map(&:storm).uniq
  end
  
  def pre
    @image = Image.pre.find(params[:id])
    load_thumbs
    respond_with(@image)
  end
  
  def post
    @image = Image.post.find(params[:id])
    load_thumbs
    respond_with(@image)
  end
  
  def nearest_pre
    post_image = Image.find(params[:id])
    @image = Image.pre.nearby(post_image.latitude, post_image.longitude).first
    load_thumbs
    respond_with(@image)
  end
  
  def nearest_post
    pre_image = Image.find(params[:id])
    @image = Image.post.nearby(pre_image.latitude, pre_image.longitude).first
    load_thumbs
    respond_with(@image)
  end
  
  def load_thumbs
    @thumbs = []
    @thumbs[0] = Image.where(pre: @image.pre).where('taken_at < ?',@image.taken_at).order('taken_at desc').limit(1).first.thumb_url rescue nil
    @thumbs[1] = @image.thumb_url
    @thumbs[2] = Image.where(pre: @image.pre).where('taken_at < ?',@image.taken_at).order('taken_at desc').limit(1).first.thumb_url rescue nil
  end
  
end
