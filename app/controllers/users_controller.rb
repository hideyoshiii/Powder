class UsersController < ApplicationController
  def show 
  	@user = User.find(params[:id]) 
    @spots = Spot.where(user_id: current_user.id)
  	@wants = Like.where(user_id: @user.id, kind: 1)
  	@dones = Like.where(user_id: @user.id, kind: 2)
  end

  def want
  	@user = User.find(params[:id]) 
  	@wants = Like.where(user_id: @user.id, kind: 1)
  end

  def done
  	@user = User.find(params[:id]) 
  	@dones = Like.where(user_id: @user.id, kind: 2)
  end

end
