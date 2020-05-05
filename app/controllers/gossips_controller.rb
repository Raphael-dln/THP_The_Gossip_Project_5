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
      redirect_to gossips_path
    else
      messages = []
      if @gossip.errors.any? 
          @gossip.errors.full_messages.each do |message| 
          messages << message
        end 
        flash[:error] = "Tu t'es trompé poulet, la liste des erreurs est :#{messages.join(" ")}"
      end 
      render 'new'
    end
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def index
    @gossips = Gossip.all
  end 

  def edit
  end

  def update
  end

  def destroy
    Gossip.find(params[:id]).delete
    redirect_to gossips_path
  end
end
