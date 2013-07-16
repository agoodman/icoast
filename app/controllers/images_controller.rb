class ImagesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :set_defaults, only: [ :index, :alt ]
  
  respond_to :html, :js, :json
  
  def index
    @groups = Group.scoped
    @regimes = Tag.regime
    # TODO: decide whether there should be a random image here or a static predefined image
    # @post_position = Image.post.enabled.random(Image.post.enabled.count).first.position
  end
  
  def alt
    @groups = Group.scoped
    @regimes = Tag.regime
    render layout: 'alt'
  end
  
  def index_pre
    @images = Image.pre.includes(:annotations).order('position').paginate(page: params[:page], per_page: params[:per_page])
    respond_to do |format|
      format.json { render json: @images.as_json(only: (params[:only].split(',').map(&:to_sym) rescue []), user_id: current_user.id) }
    end
  end
  
  def index_post
    @images = Image.post.enabled.includes(:annotations).order('position').paginate(page: params[:page], per_page: params[:per_page])
    respond_to do |format|
      format.json { render json: @images.as_json(only: (params[:only].split(',').map(&:to_sym) rescue []), user_id: current_user.id) }
    end
  end
  
  def pre
    @image = Image.pre.where(position: params[:position]).first
    load_thumbs
    respond_with(@image)
  end
  
  def post
    @image = Image.post.enabled.includes(annotations: :tag).where(position: params[:position]).first
    load_thumbs
    respond_with(@image)
  end
  
  def nearest_pre
    post_image = Image.post.enabled.where(position: params[:position]).first
    delta = 0.001
    for k in 1..15
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
  
  def random_post
    @image = Image.post.enabled.random(Image.post.enabled.count).first
    respond_with(@image)
  end
  
  def load_thumbs
    @thumbs = []
    @thumbs[0] = Image.where(pre: @image.pre).where(position: @image.position-1).limit(1).first.thumb_url rescue nil
    @thumbs[1] = @image.thumb_url rescue nil
    @thumbs[2] = Image.where(pre: @image.pre).where(position: @image.position+1).limit(1).first.thumb_url rescue nil
  end

  def set_defaults
    # here, there be <strike>hacks</strike> preferences for initial image
    @pre_position = 2949
    @post_position = 80
  end
  
end
