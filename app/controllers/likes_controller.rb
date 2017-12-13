class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot

  def create1
  	
    @like = Like.new(user_id: current_user.id, spot_id: params[:spot_id], kind: 1, sex: current_user.sex)
    @like.save
  end

  def create2
    
    @like = Like.new(user_id: current_user.id, spot_id: params[:spot_id], kind: 2, sex: current_user.sex)
    @like.save
  end

  def update1
    @like = Like.find_by(user_id: current_user.id, spot_id: params[:spot_id], kind: 2)
    @like.kind = 1
    @like.save
  end

   def update2
    @like = Like.find_by(user_id: current_user.id, spot_id: params[:spot_id], kind: 1)
    @like.kind = 2
    @like.save
  end

  def destroy1
  	
    @like = Like.find_by(user_id: current_user.id, spot_id: params[:spot_id], kind: 1)
    @like.destroy
  end

  def destroy2
    
    @like = Like.find_by(user_id: current_user.id, spot_id: params[:spot_id], kind: 2)
    @like.destroy
  end

  def create
    @like = Like.create(user_id: current_user.id, spot_id: params[:spot_id])
    
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, spot_id: params[:spot_id])
    like.destroy
    
  end

  private
  def set_spot
  @spot = Spot.find(params[:spot_id])
  end

end
