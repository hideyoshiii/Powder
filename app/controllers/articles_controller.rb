class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]


  def search
  end

  def result
    @article = Article.where(city: params[:city], timezone: params[:timezone].to_i, price: params[:price].to_i, number: params[:number].to_i).order("RANDOM()").first
  end

  def show  
  end

  def index
  end

  def new
    @article = Article.new
    @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
  end

  def create
    if params[:article][:image]

    @article = current_user.articles.build(article_params)

      if @article.save
        @snap = Snap.new(image: params[:article][:image], article_id: @article.id, user_id: current_user.id)
        @snap.save
        redirect_to user_path(current_user)
      else
        redirect_to new_article_path
      end

      else
        redirect_to new_article_path
      end
  end

  def edit
    @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    @article = Article.find(params[:id])
    if !(current_user == @article.user)
      redirect_to root_path
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to root_path
    end
  end

  def addsnaps
    @article = Article.find(params[:id])
    @snap = Snap.new
  end

  def snaps
    @article = Article.find(params[:id])
    @snaps = @article.snaps
  end

  def show1
    @article = Article.find(1)
  end

  def show2
    @article = Article.find(2)
  end

  def show3
    @article = Article.find(3)
  end

  def show4
    @article = Article.find(4)
  end

  def show5
    @article = Article.find(5)
  end

  def show6
    @article = Article.find(6)
  end

  private
  def article_params
    params.require(:article).permit(:title, :prefecture, :city, :station, :content, :price, :timezone, :number, :photo, :movie_list, scenes:[])
  end

end
