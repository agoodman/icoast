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
  
  def create
    @match = Match.new(params[:match])
    @match.user = current_user
    @match.save
    head :ok
  end
  
  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    head :ok
  end

end
