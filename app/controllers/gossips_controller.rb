class GossipsController < ApplicationController
  def new
    @gossip = Gossip.new
  end
  
  def create
    @gossip = Gossip.new(title: params[:title], content: params[:content],  user: User.find(params[:user]))
    if @gossip.save
      redirect_to gossips_path
    else
      render 'new'
    end
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def index
    puts "Ca c'est la page d'accueil"
  end 

  def edit
  end

  def update
  end

  def destroy
  end
end
