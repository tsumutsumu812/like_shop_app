class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  before_action :login_required, only: [:new, :edit, :create, :update, :destroy]
  before_action :authenticate_edit_shop, only: [:edit, :update, :destroy]

  # GET /shops
  # GET /shops.json
  def index
    @q = Shop.ransack(params[:q])
    @shops = @q.result(distinct: true).page(params[:page])
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    @comment = Comment.new(shop_id: @shop.id)
    @user = @shop.user
    @likes_count = Like.where(shop_id: @shop.id).count
  end

  # GET /shops/new
  def new
    @shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops
  # POST /shops.json
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

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
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

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, flash: {success: "#{@shop.name}を削除しました。"}}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
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
