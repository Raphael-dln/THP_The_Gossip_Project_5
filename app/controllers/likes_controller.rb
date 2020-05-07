class LikesController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :update, :destroy]
 
 
  def new
    @like = Like.new
  end

  def index
    @like = Like.all
  end

  
  def create
    @like = Like.new(value: params[:value], gossip_id: params[:gossip], user: current_user)
      if @like.save
        flash[:success] = "Merci d'avoir liké!"
      else
        flash[:error] = @like.errors.full_messages.join(', ')
      end
  end
   
  def destroy
    @like = Like.find(params[:id])
  private
  end

  def like_params
    params.require(:like).permit(:value, :user_id, :gossip_id)
  end
  
  def authenticate_user
    unless current_user
      flash[:error] = "Vous devez vous connecter pour accéder au contenu."
      redirect_to new_session_path
    end
  end


end
