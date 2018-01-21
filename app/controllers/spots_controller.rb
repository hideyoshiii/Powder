class SpotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def result
    @q = Spot.ransack(params[:q])
    @spots = @q.result(distinct: true)
  end

  def index
    @spots = Spot.order('id DESC').limit(50)
    @q = Spot.ransack(params[:q])
    
  end

  def rank
    @ranks = Spot.find(Like.group(:spot_id).order('count(spot_id) desc').limit(50).pluck(:spot_id))
    @q = Spot.ransack(params[:q])
    @spots = @q.result(distinct: true)
  end

  def show
    @spot = Spot.find(params[:id])
    @tags = @spot.label_list
    @pictures = @spot.pictures
  end

  def new
    @spot = current_user.spots.build
    @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
  end

  def create
    if params[:spot][:image]

    @spot = current_user.spots.build(spot_params)

      if @spot.save
        @picture = Picture.new(image: params[:spot][:image], spot_id: @spot.id, user_id: current_user.id)
        @picture.save
        redirect_to user_path(current_user)
      else
        redirect_to new_spot_path
      end

      else
        redirect_to new_spot_path
      end
  end

  def edit
    @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    @spot = Spot.find(params[:id])
    if !(current_user == @spot.user)
      redirect_to root_path
    end
  end

  def update
    @spot = Spot.find(params[:id])
    if @spot.update(spot_params)
      redirect_to user_path(current_user)
    end
  end

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    redirect_to user_path(current_user)
  end

  def addpictures
    @spot = Spot.find(params[:id])
    @picture = Picture.new
  end

  def tags
    @spot = Spot.find(params[:id])
  end

  def pictures
    @spot = Spot.find(params[:id])
    @pictures = @spot.pictures
  end

  


  private
  def spot_params
    params.require(:spot).permit(:title, :prefecture, :city, :station, :price, :description, :address, :introduction, :retty, :browser, :phone, :large, :small, :heading, :photo, :label_list, scenes:[])
  end

  def search_params
    params.require(:q).permit(:title_cont)
  end

end
