class SpotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @spots = Spot.order('id DESC').limit(25)
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def new
    @spot = current_user.spots.build
    @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
  end

  def create
    @spot = current_user.spots.build(spot_params)

    if @spot.save
      redirect_to user_path(current_user), notice: "リスティングを作成・保存をしました"
    else
      redirect_to new_spot_path, notice: "リスティングを作成・保存出来ませんでした"
    end
  end

  def edit
    @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    @spot = Spot.find(params[:id])
    if !(current_user == @spot.user)
      redirect_to root_path, notice: "他人の編集ページにはアクセスできません"
    end
  end

  def update
    @spot = Spot.find(params[:id])
    if @spot.update(spot_params)
      redirect_to user_path(current_user), notice: "更新しました"
    end
  end

  private
  def spot_params
    params.require(:spot).permit(:title, :prefecture, :price, :description, :photo, :label_list, scenes:[])
  end

end
