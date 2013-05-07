class ImagesController < ApplicationController
  
  respond_to :html, :js, :json
  
  def index
    @pre_images = Image.pre.order('position')
    @post_images = Image.post.order('position')
    @pre_position = 378
    @post_position = 2402
    @storms = Image.all.map(&:storm).uniq
  end
  
  def pre
    @image = Image.pre.where(position: params[:position]).first
    load_thumbs
    respond_with(@image)
  end
  
  def post
    @image = Image.post.where(position: params[:position]).first
    load_thumbs
    respond_with(@image)
  end
  
  def nearest_pre
    post_image = Image.post.where(position: params[:position]).first
    delta = 0.001
    for k in 1..3
      @image = Image.pre.nearby(post_image.latitude, post_image.longitude, delta*k).first rescue nil
      break unless @image.nil?
    end
    load_thumbs
    respond_with(@image)
  end
  
  def nearest_post
    pre_image = Image.pre.where(position: params[:position]).first
    @image = Image.post.nearby(pre_image.latitude, pre_image.longitude).first
    load_thumbs
    respond_with(@image)
  end
  
  def load_thumbs
    @thumbs = []
    @thumbs[0] = Image.where(pre: @image.pre).where(position: @image.position-1).limit(1).first.thumb_url rescue nil
    @thumbs[1] = @image.thumb_url rescue nil
    @thumbs[2] = Image.where(pre: @image.pre).where(position: @image.position+1).limit(1).first.thumb_url rescue nil
  end
  
end
