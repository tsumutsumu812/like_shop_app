class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  before_action :login_required, only: [:new, :edit, :create, :update, :destroy]
  before_action :authenticate_edit_shop, only: [:edit, :update, :destroy]

  def index
    @q = Shop.ransack(params[:q])
    @shops = @q.result(distinct: true).page(params[:page])
  end

  def show
    @comment = Comment.new(shop_id: @shop.id)
    @user = @shop.user
    @likes_count = Like.where(shop_id: @shop.id).count
  end

  def new
    @shop = Shop.new
  end

  def edit
  end

  def create
    @shop = current_user.shops.new(shop_params)
    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, flash: {success: "#{@shop.name}を追加しました。"}}
        format.json { render :show, status: :created, location: @shop }
      else
        format.html { render :new }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, flash:{ success: "#{@shop.name}の情報を編集しました。" }}
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, flash: {success: "#{@shop.name}を削除しました。"}}
      format.json { head :no_content }
    end
  end

  private
    def set_shop
      @shop = Shop.find(params[:id])
    end

    def shop_params
      params.require(:shop).permit(:name, :area, :genre, :address, :likey, :description, :url, :picture)
    end

    def authenticate_edit_shop
      @shop = Shop.find(params[:id])
      if @shop.user_id != current_user.id && !current_user.admin?
        redirect_to shops_path, flash: { danger: "編集権限がありません" }
      end
    end
end
