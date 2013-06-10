class AnnotationsController < ApplicationController
  
  respond_to :js, :json
  
  def create
    @annotation = Annotation.new(params[:annotation])
    @annotation.user = current_user
    @annotation.save
    respond_with(@annotation)
  end
  
  def destroy
    @annotation = Annotation.find(params[:id])
    @annotation.destroy
    head :ok
  end
  
end
