class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in, only: [:new, :create]

  def new
    render "index"
  end

  def create
    user = User.find_by(email: params[:email])&.authenticate(params[:password])
    if user
      session[:current_user_id] = user.id
      redirect_to todos_path
    else
      flash[:error] = "Invalid email/password!"
      redirect_to new_sessions_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
