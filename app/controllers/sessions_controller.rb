class SessionsController < ApplicationController
  def new
    render "index"
  end

  def create
    user = User.find_by(email: params[:email])&.authenticate(params[:password])
    if user
      render plain: "Password correct."
    else
      render plain: "Password incorrect!"
    end
  end
end
