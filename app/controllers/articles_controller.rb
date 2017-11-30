class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
  end



  def new
    @article = Article.new
    @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to root_path
    else
      redirect_to new_article_path
    end
  end

  def edit
    @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to root_path
    end
  end

  def show1
    @article = Article.find(1)
  end

  def show2
    @article = Article.find(2)
  end

  private
  def article_params
    params.require(:article).permit(:title, :prefecture, :city, :station, :price, :photo, scenes:[])
  end

end
