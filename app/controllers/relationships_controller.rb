class RelationshipsController < ApplicationController
  before_action :login_required
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end
  def destroy
    user = Relationship.find(params[:id])
    current_user.follow(user)
    redirect_to user
  end
end
