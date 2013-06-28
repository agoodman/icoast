class MatchesController < ApplicationController

  respond_to :js, :json
  
  def index
    @matches = Match.includes(:pre_image,:post_image)
    respond_with(@matches, {
      only: [:user_id], 
      include: {
        pre_image: {
          only: [:id,:latitude,:longitude]
        },
        post_image: {
          only: [:id,:latitude,:longitude]
        }
      }
    })
  end

  def exists
    if Match.exists?(pre_image_id: params[:pre], post_image_id: params[:post], user_id: current_user.id)
      head :ok
    else
      head :not_found
    end
  end
  
  # POST /matches
  # should be idempotent
  def create
    @match = Match.find_or_create_by_user_id_and_post_image_id_and_pre_image_id(current_user.id, params[:match][:post_image_id], params[:match][:pre_image_id])
    respond_to do |format|
      format.json { render json: @match }
    end
  end
  
  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    head :ok
  end

end
