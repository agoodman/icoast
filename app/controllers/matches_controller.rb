class MatchesController < ApplicationController

  respond_to :js

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
