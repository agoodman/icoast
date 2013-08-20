class Admin::ImagesController < ApplicationController
  
  respond_to :html, :js, :json
  
  def index
    @images = Image.paginate(page: params[:page] || 1, per_page: params[:per_page] || 100)
    respond_with(@images)
  end
  
  def index_pre
    @images = Image.pre.paginate(page: params[:page] || 1, per_page: params[:per_page] || 100)
    respond_with(@images, only: params[:only].split(',').map(&:to_sym))
  end
  
  def index_post
    @images = Image.post.enabled.paginate(page: params[:page] || 1, per_page: params[:per_page] || 100)
    respond_with(@images, only: params[:only].split(',').map(&:to_sym))
  end

  def import
    csv = CSV.parse(params[:file].tempfile, headers: true)
    for row in csv
      year = row["YEAR1"].to_i
      month = Date::MONTHNAMES.index(row["MONTH_"])
      day = row["DAY1"].to_i
      hour, min, sec = row["HR_MIN_SEC"].split("_").map(&:to_i)
      taken = Time.utc(year, month, day, hour, min, sec)
      attrs = { 
        filename: row["SLIDE"], 
        full_url: row["FULL_SLIDE"], 
        thumb_url: row["THUMBNAIL_"], 
        geo_area: row["GEO_AREA"], 
        pre: row["PRE_POST"].downcase=="pre", 
        storm: row["STORM"], 
        latitude: row["LATITUDE"], 
        longitude: row["LONGITUDE"], 
        taken_at: taken
      }
      Image.create!(attrs) unless Image.where(attrs).exists?
    end
    redirect_to admin_images_path
  end
  
end
