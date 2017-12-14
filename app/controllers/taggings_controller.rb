class TaggingsController < ApplicationController
  
  def search
    @tags = ActsAsTaggableOn::Tag.most_used(30)
    @tags = Article.all_tags
    @articles1 = Article.tagged_with("サンプル").limit(7)
    @articles2 = Article.tagged_with("ちんすこう").limit(7)
  end

  def index
    @articles = params[:tag].present? ? Article.tagged_with(params[:tag]) : Article.all
    @tag = params[:tag]
  end

end