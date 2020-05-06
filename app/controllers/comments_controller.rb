class CommentsController < ApplicationController
  def new
    @comment = Comment.new 
  end

  def create
    @comment = Comment.new(gossip_id: params[:gossip], content: params[:content],  user: User.find(params[:user]))
    if @comment.save
      flash[:success] = "The commentaire was succesfully saved !"
      redirect_to gossip_path(@comment.gossip.id)
    else
      messages = []
      if @comment.errors.any? 
          @comment.errors.full_messages.each do |message| 
          messages << message
        end 
        flash[:error] = "Tu t'es trompé poulet, la liste des erreurs est :#{messages.join(" ")}"
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
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = "Ton super comment a correctement été mis à jour !"
      redirect_to gossip_path(@comment.gossip.id)
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
    flash[:success] = "Ton commentaire de comère de luxe a été correctement destroy!"
      redirect_to gossip_path(@comment.gossip.id)
    else
      render 'edit'
    end
  end

private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
