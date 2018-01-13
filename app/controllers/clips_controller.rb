class ClipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create 	
    @clip = Clip.new(user_id: current_user.id, article_id: params[:article_id], sex: current_user.sex)
    @clip.save
  end

  def destroy	
    @clip = Clip.find_by(user_id: current_user.id, article_id: params[:article_id])
    @clip.destroy
  end

  private
  def set_article
  @article = Article.find(params[:article_id])
  end

end
