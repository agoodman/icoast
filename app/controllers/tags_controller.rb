class TagsController < ApplicationController

  def create
    @tag = Tag.new(params[:tag])
    @tag.save
    respond_with(@tag)
  end
  
end
