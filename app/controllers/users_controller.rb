class UsersController < ApplicationController
before_action :login_required, only: [:edit, :update, :destroy,:following, :followers]
before_action :ensure_correct_user, only: [:edit, :update]
before_action :authenticate_edit_user, only: [:edit, :update, :destroy]
before_action :forbid_login_user, only: [:new, :create]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
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
      redirect_to @user, flash: { success: "ユーザー#{@user.name}を登録しました。" }
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, flash:{ success: "ユーザー#{@user.name}を変更しました。" }
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, flash:{ success:  "ユーザー#{@user.name}を削除しました。" }
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end
  
  private
    def  user_params
      params.require(:user).permit(:name, :email, :introduction, :password, :password_confirmation)
    end

    def  ensure_correct_user
      if current_user.id != params[:id].to_i && !current_user.admin?
        redirect_to shops_path, flash:{ danger: "権限がありません" }
      end
    end

    def authenticate_edit_user
      @user = User.find(params[:id])
      if @user.id != current_user.id && !current_user.admin?
        redirect_to shops_url, flash:{ danger: "編集権限がありません" }
      end
    end

end
