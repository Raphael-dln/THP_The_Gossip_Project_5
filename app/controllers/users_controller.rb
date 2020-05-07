class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(first_name: user_params[:first_name],last_name: user_params[:last_name], city: City.find(params[:city]), email: user_params[:email], password: user_params[:password])
    puts params
    if @user.save
      flash[:success] = "Ton profil a bien été créé ! "
      redirect_to gossips_path
    else
      messages = []
      if @user.errors.any? 
          @user.errors.full_messages.each do |message| 
          messages << message
        end 
        flash[:error] = "Erreur jeune comère, ton profil n'a pas été créé parce que :#{messages.join(" ")}"
      end
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @user = User.all
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end
