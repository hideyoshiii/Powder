class LikesController < ApplicationController
  before_action :authenticate_user!

  def create1
  	
    @like = Like.new(user_id: current_user.id, spot_id: params[:spot_id], kind: 1, sex: current_user.sex)
    @like.save
    redirect_back(fallback_location: root_path) 
  end

  def create2
    
    @like = Like.new(user_id: current_user.id, spot_id: params[:spot_id], kind: 2, sex: current_user.sex)
    @like.save
    redirect_back(fallback_location: root_path) 
  end

  def update1
    @like = Like.find_by(user_id: current_user.id, spot_id: params[:spot_id], kind: 2)
    @like.kind = 1
    @like.save
    redirect_back(fallback_location: root_path) 
  end

   def update2
    @like = Like.find_by(user_id: current_user.id, spot_id: params[:spot_id], kind: 1)
    @like.kind = 2
    @like.save
    redirect_back(fallback_location: root_path) 
  end

  def destroy1
  	
    @like = Like.find_by(user_id: current_user.id, spot_id: params[:spot_id], kind: 1)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  def destroy2
    
    @like = Like.find_by(user_id: current_user.id, spot_id: params[:spot_id], kind: 2)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

end
