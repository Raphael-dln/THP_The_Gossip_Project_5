class GossipsController < ApplicationController
  def new
  end

  def create
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
