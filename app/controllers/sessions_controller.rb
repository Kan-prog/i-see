class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        log_in user
        flash[:success] = "ようこそ" + current_user.name + "様!"
        redirect_to user
    else
      flash.now[:danger] = 'パスワードまたはメールアドレスが間違っているようです。'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
