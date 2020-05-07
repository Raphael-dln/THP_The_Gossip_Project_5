class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @comment = Comment.new 
  end

  def create
    @comment = Comment.new(gossip_id: params[:gossip], content: params[:content],  user: current_user)
    if @comment.save
      flash[:success] = "The commentaire was succesfully saved !"
      redirect_to gossip_path(@comment.gossip.id)
    else
      messages = []
      if @comment.errors.any? 
          @comment.errors.full_messages.each do |message| 
          messages << message
        end 
        flash.now[:error] = "Tu t'es trompé poulet, la liste des erreurs est :#{messages.join(" ")}"
      end 
      render 'new'
    end
  end

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
    # Condition pour définir si l'utilisateur connecté à la session est celui qui a écrit le commentaire
    if !current_user?(@comment.user)
      flash[:error] = "Vous n'êtes pas le bon utilisateur."
      redirect_to gossips_path
    end
  end

  def update
    @comment = Comment.find(params[:id])
    # Condition pour définir si l'utilisateur connecté à la session est celui qui a écrit le commentaire
    if !current_user?(@comment.user)
      flash[:error] = "Vous n'êtes pas le bon utilisateur."
      redirect_to gossips_path
    else
      if @comment.update(comment_params)
        flash[:success] = "Ton super comment a correctement été mis à jour !"
        redirect_to gossip_path(@comment.gossip.id)
      else
        render 'edit'
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    # Condition pour définir si l'utilisateur connecté à la session est celui qui a écrit le commentaire
    if !current_user?(@comment.user)
      flash[:error] = "Vous n'êtes pas le bon utilisateur."
      redirect_to gossips_path
    else
      if @comment.destroy
      flash[:success] = "Ton commentaire de comère de luxe a été correctement destroy!"
        redirect_to gossip_path(@comment.gossip.id)
      else
        render 'edit'
      end
    end
  end

private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def authenticate_user
    unless current_user
      flash[:error] = "Vous devez vous connecter pour accéder au contenu."
      redirect_to new_session_path
    end
  end
end
