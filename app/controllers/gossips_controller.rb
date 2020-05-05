class GossipsController < ApplicationController
  def new
    @gossip = Gossip.new
  end
  
  def create
    puts "$" * 60
    puts "ceci est le contenu de params :"
    puts params
    puts "$" * 60

    @gossip = Gossip.new(title: params[:title], content: params[:content])
    if @gossip.save
      redirect_to /gossips_path
      puts "ca a marché"
    else
      render 'new'
      puts "WTF!!!!!!!!!!!!!!!!!!!!"
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
