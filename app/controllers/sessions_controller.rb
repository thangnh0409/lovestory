class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to root_path
      else
        flash[:warning] = "Account not activated."
        redirect_to user
      end
    else
      flash.now[:danger] = 'Invalid email/password!'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
