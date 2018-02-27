class SpotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def result
    @q = Spot.ransack(params[:q])
    @spots = @q.result(distinct: true)
  end

  def index
    @spots = Spot.order('id DESC').page(params[:page]).per(30)
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
    @pictures = @spot.pictures.order(id: "ASC")
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
        redirect_to spot_path(@spot)
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
      redirect_to spot_path(@spot)
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
    @pictures = @spot.pictures.order(id: "ASC")
  end



  def search00
  end

  def result00  
    @spots = Spot.all
    unless params[:scene].blank?
      @scene = params[:scene]
      @spots = @spots.where("scenes like '%#{@scene}%'")
    end
    @spots = @spots.order(:created_at).page(params[:page]).per(3)
  end

  def show00

  end

  


  private
  def spot_params
    params.require(:spot).permit(:title, :prefecture, :city, :station, :price, :price_lunch, :price_dinner, :price_spot, :description, :address, :introduction, :retty, :browser, :phone, :heading, :tabelog, :point1, :point2, :point3, :photo, :label_list, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :holiday, :access, :payment, :service, :charge, :smoking, scenes:[], large:[], small:[], timezone:[])
  end

  def search_params
    params.require(:q).permit(:title_cont)
  end

end
