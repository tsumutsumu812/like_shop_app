class SessionsController < ApplicationController
  before_action :forbid_login_user, only: [:new, :create]

  def new
  end
  
  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to shops_url, flash:{ success: "ログインしました。" }
    else
      flash.now[:danger] = "ログイン情報が正しくありません。"
      render :new
    end 
  end

  def destroy
    reset_session
    redirect_to root_url, flash: { success: "ログアウトしました。"}
  end
  private 
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
