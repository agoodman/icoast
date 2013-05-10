class AnnotationsController < ApplicationController
  
  respond_to :js
  
  def create
    @annotation = Annotation.new(params[:annotation])
    @annotation.save
    head :ok
  end
  
  def destroy
    @annotation = Annotation.find(params[:id])
    @annotation.destroy
    head :ok
  end
  
end
