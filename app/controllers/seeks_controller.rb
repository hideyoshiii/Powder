class SeeksController < ApplicationController
  before_action :set_params, only: [:category,:term,:choice]
  before_action :set_wday, only: []

  def category

  	if params[:city].blank?
  		params[:city] = "すべてのエリア"
  		@all = true
  		@spots = Spot.all
  	else
  		if params[:city] == "すべてのエリア"
  			@spots = Spot.all
  		else
  			@spots = Spot.where(city: params[:city])
  		end
  	end

  	@breakfast = @spots.where("large like '%朝食%'")
  	@lunch = @spots.where("large like '%ランチ%'")
  	@dinner = @spots.where("large like '%ディナー%'")
  	@cafe = @spots.where("large like '%カフェ%'")
  	@animal = @spots.where("large like '%アニマルカフェ%'")
  	@sweets = @spots.where("large like '%スイーツ%'")
  	@bar = @spots.where("large like '%バー%'")
  	@movie = @spots.where("large like '%映画%'")
  	@shop = @spots.where("large like '%ショップ・雑貨屋%'")
  	@karaoke = @spots.where("large like '%カラオケ%'")
  	@sport = @spots.where("large like '%スポーツ%'")
  	@nitht_view = @spots.where("large like '%夜景%'")
  	@planetarium = @spots.where("large like '%プラネタリウム%'")
  	@zoo = @spots.where("large like '%動物園%'")
  	@aquarium = @spots.where("large like '%水族館%'")
  	@museum = @spots.where("large like '%美術館%'")
  	@amusement_park = @spots.where("large like '%遊園地%'")
  	@bowling = @spots.where("large like '%ボーリング%'")
  	@darts = @spots.where("large like '%ダーツ%'")
  	@walk_eat = @spots.where("large like '%食べ歩き%'")
  	@park = @spots.where("large like '%公園%'")


  	@breakfast_n = @breakfast.count
    @lunch_n = @lunch.count
    @dinner_n = @dinner.count
    @cafe_n = @cafe.count
    @animal_n = @animal.count
    @sweets_n = @sweets.count
    @bar_n = @bar.count
    @movie_n = @movie.count
    @shop_n = @shop.count
    @karaoke_n = @karaoke.count
    @sport_n = @sport.count
    @night_view_n = @nitht_view.count
    @planetarium_n = @planetarium.count
    @zoo_n = @zoo.count
    @aquarium_n = @aquarium.count
    @museum_n = @museum.count
    @amusement_park_n = @amusement_park.count
    @bowling_n = @bowling.count
    @darts_n = @darts.count
    @walk_eat_n = @walk_eat.count
    @park_n = @park.count
  end

  def term
  	@large = params[:large]
  end

  def choice
  	@n = 0
  	@large = params[:large]

  	@spots = Spot.where("large like '%#{@large}%'")

  	if params[:city] == "すべてのエリア"
  	else
  		@spots = @spots.where(city: params[:city])
  	end

    @price_start = params[:price_min].to_i
    @price_end = params[:price_max].to_i
    if @large == "朝食"
    	@spots = @spots.where(price_lunch: @price_start..@price_end)
    end
    if @large == "ランチ"
    	@spots = @spots.where(price_lunch: @price_start..@price_end)
    end
    if @large == "ディナー"
    	@spots = @spots.where(price_dinner: @price_start..@price_end)
    end

    if !params[:small].blank?
      @small = params[:small]
      @spots = @spots.where("small like '%#{@small}%'")
    end

    @spots = @spots.order("RANDOM()").limit(2)
  end

  def result
  end


  private
  def set_params
  

    @japanese = false
    @yakiniku = false
    @steak = false
    @pot = false
    @french = false
    @italian = false
    @western = false
    @chinese = false
    @asia = false
    @otherwise = false
    if !params[:small].blank?
      if params[:small] == "和食"
        @japanese = true
      end
      if params[:small] == "焼肉・ホルモン"
        @yakiniku = true
      end
      if params[:small] == "ステーキ・ハンバーグ"
        @steak = true
      end
      if params[:small] == "鍋"
        @pot = true
      end
      if params[:small] == "フレンチ"
        @french = true
      end
      if params[:small] == "イタリアン"
        @italian = true
      end
      if params[:small] == "西洋各国料理"
        @western = true
      end
      if params[:small] == "中華料理"
        @chinese = true
      end
      if params[:small] == "アジア・エスニック"
        @asia = true
      end
      if params[:small] == "その他"
        @otherwise = true
      end
    end

    @all = false
    @ebisu = false
    @shibuya = false
    @harajuku = false
    @shinjuku = false
    @tokyo = false
    @roppongi = false
    if !params[:city].blank?
      if params[:city] == "すべてのエリア"
        @all = true
      end
      if params[:city] == "恵比寿・代官山・中目黒"
        @ebisu = true
      end
      if params[:city] == "渋谷"
        @shibuya = true
      end
      if params[:city] == "原宿・表参道・青山"
        @harajuku = true
      end
      if params[:city] == "新宿"
        @shinjuku = true
      end
      if params[:city] == "東京・丸の内・日本橋"
        @tokyo = true
      end
      if params[:city] == "六本木・麻布・赤坂"
        @roppongi = true
      end
    end

    @breakfast = false
    @lunch = false
    @dinner = false
    @cafe = false
    @animal = false
    @sweets = false
    @bar = false
    @movie = false
    @shop = false
    @karaoke = false
    @sport = false
    @nitht_view = false
    @planetarium = false
    @zoo = false
    @aquarium = false
    @museum = false
    @amusement_park = false
    @bowling = false
    @darts = false
    @walk_eat = false
    @park = false
    if !params[:large].blank?
    	if params[:large] == "朝食"
        @breakfast = true
      end
      if params[:large] == "ランチ"
        @lunch = true
      end
      if params[:large] == "ディナー"
        @dinner = true
      end
      if params[:large] == "カフェ"
        @cafe = true
      end
      if params[:large] == "アニマルカフェ"
        @animal = true
      end
      if params[:large] == "スイーツ"
        @sweets = true
      end
      if params[:large] == "バー"
        @bar = true
      end
      if params[:large] == "映画"
        @movie = true
      end
      if params[:large] == "ショップ・雑貨屋"
        @shop = true
      end
      if params[:large] == "カラオケ"
        @karaoke = true
      end
      if params[:large] == "スポーツ"
        @sport = true
      end
      if params[:large] == "夜景"
        @nitht_view = true
      end
      if params[:large] == "プラネタリウム"
        @planetarium = true
      end
      if params[:large] == "動物園"
        @zoo = true
      end
      if params[:large] == "水族館"
        @aquarium = true
      end
      if params[:large] == "美術館"
        @museum = true
      end
      if params[:large] == "遊園地"
        @amusement_park = true
      end
      if params[:large] == "ボーリング"
        @bowling = true
      end
      if params[:large] == "ダーツ"
        @darts = true
      end
      if params[:large] == "食べ歩き"
        @walk_eat = true
      end
      if params[:large] == "公園"
        @park = true
      end
    end

  end

  def set_wday
    @wday = Date.today.wday
  end


end