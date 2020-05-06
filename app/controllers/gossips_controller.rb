class GossipsController < ApplicationController
  def new
    @gossip = Gossip.new
  end

  # possibilité de retoruver l'attribut flash dans application.html.erb
  # le bootstrap des bannières peut être retrouvé dans helper > application helper
  def create
    @gossip = Gossip.new(title: params[:title], content: params[:content],  user: User.find(params[:user]))
    if @gossip.save
      flash[:success] = "The super potin was succesfully saved !"
      redirect_to gossip_path(@gossip.id)
    else
      messages = []
      if @gossip.errors.any? 
          @gossip.errors.full_messages.each do |message| 
          messages << message
        end 
        flash[:error] = "Tu t'es trompé poulet, la liste des erreurs est :#{messages.join(" ")}"
      end 
      redirect_to 'new'
    end
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comment = Comment.new
  end

  def index
    @gossips = Gossip.all
  end 

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update(gossip_params)
      flash[:success] = "Ton super potin a correctement été mis à jour !"
      redirect_to gossips_path
    else
      render 'edit'
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    if @gossip.destroy
      flash[:success] = "Ton super potin a correctement été détruit !"
      redirect_to gossips_path
    else
      render'destroy'
    end
  end
end

private

def gossip_params
  params.require(:gossip).permit(:title, :content)
end