class UsersController < ApplicationController
before_action :login_required, only: [:edit, :update]
before_action :ensure_correct_user, only: [:edit, :update]
before_action :authenticate_edit_user, only: [:edit, :update, :destroy]

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "ユーザー#{@user.name}を登録しました。"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "ユーザーを#{@user.name}変更しました。"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "ユーザー#{@user.name}を削除しました。"
  end
  
  private
    def  user_params
      params.require(:user).permit(:name, :email, :introduction, :password, :password_confirmation)
    end

    def  ensure_correct_user
      if current_user.id != params[:id].to_i
        redirect_to shops_path, notice: "権限がありません"
      end
    end

    def authenticate_edit_user
      @user = User.find(params[:id])
      if @user.id != current_user.id
        redirect_to shops_url, notice: "編集権限がありません"
      end
    end
end
