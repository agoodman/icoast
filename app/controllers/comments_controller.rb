class CommentsController < ApplicationController

  before_filter :authenticate_user!
  
  respond_to :json

  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.save
    respond_with(@comment)
  end

end
