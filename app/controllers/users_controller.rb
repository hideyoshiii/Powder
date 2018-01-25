class UsersController < ApplicationController
  def show 
  	@user = User.find(params[:id]) 
    @spots = Spot.where(user_id: @user.id)
  	@wants = Like.where(user_id: @user.id, kind: 1)
  	@dones = Like.where(user_id: @user.id, kind: 2)
  end

  def want
  	@user = User.find(params[:id]) 
  	@wants = Like.where(user_id: @user.id, kind: 1).order('id DESC')
  end

  def done
  	@user = User.find(params[:id]) 
  	@dones = Like.where(user_id: @user.id, kind: 2).order('id DESC')
  end

  def spot 
    @user = User.find(params[:id]) 
    @spots = Spot.where(user_id: @user.id).order('id DESC')
  end

  def clip
    @user = User.find(params[:id]) 
    @clips = Clip.where(user_id: @user.id)
  end

  def article 
    @user = User.find(params[:id]) 
    @articles = Article.where(user_id: @user.id)
  end

end
