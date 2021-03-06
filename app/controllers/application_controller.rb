class ApplicationController < ActionController::Base
  helper_method :current_user

  private
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def login_required
      redirect_to login_url, flash: {danger: 'ログインが必要です。'} unless current_user
    end

    def forbid_login_user
      if current_user
        redirect_to shops_path, flash: { danger: "すでにログインしています。" }
      end
    end
    
end
