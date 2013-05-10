class Admin::TagsController < ApplicationController

  respond_to :html, :js

  def index
    @tags = Tag.all
    respond_with(@tags)
  end
  
  def new
    @tag = Tag.new(params[:tag])
    respond_with(@tag)
  end
  
  def create
    @tag = Tag.new(params[:tag])
    @tag.save
    redirect_to admin_tags_path
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to admin_tags_path
  end
  
end
