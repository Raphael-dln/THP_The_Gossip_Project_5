class SessionsController < ApplicationController
  def new
    id = session[:user_id]
    @user = User.find_by(email: params[:email])
    #et hop, cette variable @user est l'instance User contenant toutes les infos de l'utilisateur connecté
  end

  def create
    # cherche s'il existe un utilisateur en base avec l’e-mail
    @user = User.find_by(email: params[:session][:email])
  
    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = 'Connectay'
      redirect_to gossips_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to gossips_path
  end

end
