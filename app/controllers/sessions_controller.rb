class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: session_params[:email])
    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to shops_url, notice: "ログインしました。"
    else
      flash.now[:danger] = "invalid enmail/password combination"
      render :new
    end 
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "ログアウトしました。"
  end
  private 
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
