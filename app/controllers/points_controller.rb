class PointsController < ApplicationController
  before_action :set_params, only: [:spot,:area,:distance,:category,:choice,:add]
  before_action :authenticate_user!, only: [:spot,:area,:distance,:category,:choice,:add]

	def new
		@course = Course.find(params[:id])
		@user = current_user
		@points = Point.where(course_id: @course.id)
  		@likes = Like.where(user_id: @user.id).order('id DESC')
        
  	end

  	def create
  		@course = Course.find(params[:id])
      @point_end = Point.where(course_id: @course.id).order(number: "ASC").last
      @number = @point_end.number + 1
      @spot = Spot.find(params[:spot_id])
      @point = Point.new(spot_id: @spot.id, course_id: @course.id, number: @number)
      if @point.save
        redirect_to edit_course_path(@course) #保存完了
      else
        redirect_back(fallback_location: root_path) #ポイント1が保存できなかった
      end
  	end

    def destroy
        @point = Point.find(params[:id])
        if @point.destroy
            redirect_to "/seeks/course/#{@point.course.id}/edit" , notice: "スポットを削除しました" 
        else
            redirect_to "/seeks/course/#{@point.course.id}/edit" , error: "スポットの削除に失敗しました" 
        end
  	end

    def memo
      @point = Point.find(params[:id])
      @memo = @point.memo
    end

    def update
      @point = Point.find(params[:id])
      @course = Course.find(@point.course_id)
      if @point.update(memo: params[:memo])
        redirect_to course_path(@course)
      end
    end

    def number
      @n = 0
      params[:sample_form][:colors].each do |color|
        @n = @n + 1
        if @n == 1
          @point1 = Point.find(color.to_i)
        end
        if @n == 2
          @point2 = Point.find(color.to_i)
        end
      end

      if !@point1.blank? && !@point2.blank?
        @number1 = @point1.number
        @number2 = @point2.number
        if @point1.update(number: @number2) && @point2.update(number: @number1)
          redirect_back(fallback_location: root_path)
        else
          redirect_back(fallback_location: root_path)
        end
      else
        redirect_back(fallback_location: root_path)
      end

    end






  def spot   
  end


  def distance
    unless params[:distance_spot].blank?
      @distance_spot = Spot.find(params[:distance_spot])
    end
  end

  def area
  end

  def category
    #@spotsを定義
    @spots = Spot.all
    #@latitudeがない物を排除
    @spots = @spots.where.not(latitude: nil)
    #同じスポットが含まれないように
    unless @points.blank?
      @points.each do |point|
        @spot = Spot.find(point.spot_id)
        @spots = @spots.where.not(title: @spot.title)
      end
    end
    #時間帯で絞る
    if params[:timezone] == "すべての時間帯"
    else
      @timezone = params[:timezone]
      @spots = @spots.where("timezone like '%#{@timezone}%'")
    end
    #距離で絞るorエリアで絞る
    if params[:distance_on] == "true"
      unless params[:distance_spot].blank?
        unless params[:distance].blank?
          @spot_last = Spot.find(params[:distance_spot])
          @distance = params[:distance].to_f / 1000
          @spots = @spots.near([@spot_last.latitude, @spot_last.longitude], @distance.to_f, :units => :km, :order => false)
        end
      end
    else
      if params[:city] == "すべてのエリア"
      else
        @spots = @spots.where(city: params[:city])
      end
    end
    #朝食,ランチ,ディナー用に予算で絞る
    @price_start = params[:price_min].to_i
    @price_end = params[:price_max].to_i    
    @breakfast = @spots.where(price_lunch: @price_start..@price_end)    
    @lunch = @spots.where(price_lunch: @price_start..@price_end) 
    @dinner = @spots.where(price_dinner: @price_start..@price_end)
    #朝食,ランチ,ディナー用にジャンルで絞る
    if params[:small] == "すべてのジャンル"
    else
      @small = params[:small]
      @breakfast = @breakfast.where("small like '%#{@small}%'")
      @lunch = @lunch.where("small like '%#{@small}%'")
      @dinner = @dinner.where("small like '%#{@small}%'")
    end
    
  #カテゴリーごとに抽出
    @breakfast = @breakfast.where("large like '%朝食%'")
    @lunch = @lunch.where("large like '%ランチ%'")
    @dinner = @dinner.where("large like '%ディナー%'")
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
    @spa = @spots.where("large like '%スパ・温泉%'")
    @game = @spots.where("large like '%ゲームセンター%'")
    @temple = @spots.where("large like '%お寺・神社%'")
    @theater = @spots.where("large like '%劇場%'")
    @cyber = @spots.where("large like '%インターネットカフェ%'")
    @consept = @spots.where("large like '%コンセプトカフェ・バー%'")
    @street = @spots.where("large like '%ストリート%'")
    @complex = @spots.where("large like '%複合施設%'")
    @other = @spots.where("large like '%その他%'")
    #数を抽出
    @breakfast_n = @breakfast.size
    @lunch_n = @lunch.size
    @dinner_n = @dinner.size
    @cafe_n = @cafe.size
    @animal_n = @animal.size
    @sweets_n = @sweets.size
    @bar_n = @bar.size
    @movie_n = @movie.size
    @shop_n = @shop.size
    @karaoke_n = @karaoke.size
    @sport_n = @sport.size
    @night_view_n = @nitht_view.size
    @planetarium_n = @planetarium.size
    @zoo_n = @zoo.size
    @aquarium_n = @aquarium.size
    @museum_n = @museum.size
    @amusement_park_n = @amusement_park.size
    @bowling_n = @bowling.size
    @darts_n = @darts.size
    @walk_eat_n = @walk_eat.size
    @park_n = @park.size
    @spa_n = @spa.size
    @game_n = @game.size
    @temple_n = @temple.size
    @theater_n = @theater.size
    @cyber_n = @cyber.size
    @consept_n = @consept.size
    @street_n = @street.size
    @complex_n = @complex.size
    @other_n = @other.size

  end

  def choice
    #@spotsを定義
    @spots = Spot.all
    #@latitudeがない物を排除
    @spots = @spots.where.not(latitude: nil)
    #同じスポットが含まれないように
    unless @points.blank?
      @points.each do |point|
        @spot = Spot.find(point.spot_id)
        @spots = @spots.where.not(title: @spot.title)
      end
    end
    #カテゴリーで絞る
    @large = params[:large]
    @spots = @spots.where("large like '%#{@large}%'")
    #時間帯で絞る
    if params[:timezone] == "すべての時間帯"
    else
      @timezone = params[:timezone]
      @spots = @spots.where("timezone like '%#{@timezone}%'")
    end
    #距離で絞るorエリアで絞る
    if params[:distance_on] == "true"
      unless params[:distance_spot].blank?
        unless params[:distance].blank?
          @spot_last = Spot.find(params[:distance_spot])
          @distance = params[:distance].to_f / 1000
          @spots = @spots.near([@spot_last.latitude, @spot_last.longitude], @distance.to_f, :units => :km, :order => false)
        end
      end
    else
      if params[:city] == "すべてのエリア"
      else
        @spots = @spots.where(city: params[:city])
      end
    end
    #予算で絞る
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
    if @large == "バー"
      @spots = @spots.where(price_dinner: @price_start..@price_end)
    end
    if @large == "カフェ"
      if params[:timezone] == "昼"
        @spots = @spots.where(price_lunch: @price_start..@price_end)
      end
      if params[:timezone] == "夜"
        @spots = @spots.where(price_dinner: @price_start..@price_end)
      end
    end
    #ジャンルで絞る
    if params[:small] == "すべてのジャンル"
    else
      @small = params[:small]
      @spots = @spots.where("small like '%#{@small}%'")
    end
    #ランダムにして２つ抽出
    @spots = @spots.order("RANDOM()")
  end

  def add
    unless params[:distance_spot].blank?
      @distance_spot = Spot.find(params[:distance_spot])
      @distance_point = Point.find_by(spot_id: @distance_spot.id, course_id: @course.id)
      @points.each.with_index(1) do |point, i|
        if point.spot_id == params[:distance_spot].to_i
          @before_number = i
        end
        unless @before_number.blank?
          if i > @before_number
            @change_number = point.number + 1
            point.update(number: @change_number)
          end
        end
      end
      @add_number = @distance_point.number + 1
      @add_spot = Spot.find(params[:add_spot])
      @add_point = Point.new(spot_id: @add_spot.id, course_id: @course.id, number: @add_number)
    end

    if @add_point.save
      redirect_to "/seeks/course/#{@course.id}/edit", notice: "スポットを追加しました" 
    else
      redirect_to "/seeks/course/#{@course.id}/edit", error: "スポットの追加に失敗しました" 
    end
  end

    private

    def number_params
      params.require(:sample_form).permit(
        colors: []
      )
    end

    def set_params

    #@courseを定義
    @course =  Course.find(params[:id])
    @points = Point.where(course_id: @course.id).order(number: "ASC")

    #時間帯で絞る
    if params[:timezone].blank?
      params[:timezone] = "すべての時間帯"
    end

    #時間帯で絞る
    if params[:distance].blank?
      params[:distance] = 500
    end

    #params[:city]がない場合の定義
    if params[:city].blank?
      if @spot_n == 1
        params[:city] = "すべてのエリア"
        @all = true
      end
      if @spot_n == 2
        params[:city] = @spot1.city
      end
      if @spot_n == 3
        params[:city] = @spot2.city
      end
    end

    #params[price_min]がない時のの定義
  if params[:price_min].blank?
      params[:price_min] = 0
    end
    #params[price_max]がない時のの定義
  if params[:price_max].blank?
      params[:price_max] = 20000
    end

    #params[price_max]がない時のの定義
    if params[:small].blank?
      params[:small] = "すべてのジャンル"
    end
  
    @all_genre = false
    @japanese = false
    @yakitori = false
    @sushi = false
    @yakiniku = false
    @steak = false
    @pot = false
    @french = false
    @italian = false
    @western = false
    @chinese = false
    @asia = false
    @cafe_s = false
    @otherwise = false
    @bread = false
    @coffee = false
    @sweets = false
    if !params[:small].blank?
      if params[:small] == "すべてのジャンル"
        @all_genre = true
      end
      if params[:small] == "和食"
        @japanese = true
      end
      if params[:small] == "焼き鳥・鳥料理"
        @yakitori = true
      end
      if params[:small] == "寿司"
        @sushi = true
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
      if params[:small] == "カフェ"
        @cafe = true
      end
      if params[:small] == "その他"
        @otherwise = true
      end
      if params[:small] == "パン・サンドイッチ"
        @bread = true
      end
      if params[:small] == "コーヒー・ジュース"
        @coffee = true
      end
      if params[:small] == "スイーツ"
        @sweets = true
      end
    end

    @all = false
    @ebisu = false
    @shibuya = false
    @harajuku = false
    @shinjuku = false
    @tokyo = false
    @roppongi = false
    @odaiba = false
    @shinagawa = false
    @ikebukuro = false
    @ginze = false
    @shinbashi = false
    @ueno = false
    @asakusa = false
    @meguro = false
    @kichijoji = false
    @kagurazaka = false
    @shimokitazawa = false
    @taninaka = false
    @kanda = false
    @akasaka = false
    @yotsuya = false
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
      if params[:city] == "お台場"
        @odaiba = true
      end
      if params[:city] == "品川"
        @shinagawa = true
      end
      if params[:city] == "池袋"
        @ikebukuro = true
      end
      if params[:city] == "銀座・有楽町"
        @ginze = true
      end
      if params[:city] == "新橋・汐留・浜松町"
        @shinbashi = true
      end
      if params[:city] == "上野"
        @ueno = true
      end
      if params[:city] == "浅草・押上"
        @asakusa = true
      end
      if params[:city] == "目黒・白金・五反田"
        @meguro = true
      end
      if params[:city] == "吉祥寺・三鷹"
        @kichijoji = true
      end
      if params[:city] == "神楽坂・飯田橋"
        @kagurazaka = true
      end
      if params[:city] == "下北沢"
        @shimokitazawa = true
      end
      if params[:city] == "谷中・根津・千駄木"
        @taninaka = true
      end
      if params[:city] == "神田・秋葉原・御茶ノ水"
        @kanda = true
      end
      if params[:city] == "赤坂・虎ノ門・永田町"
        @akasaka = true
      end
      if params[:city] == "四ツ谷・信濃町・千駄ヶ谷"
        @yotsuya = true
      end
    end

    @breakfast = false
    @lunch = false
    @dinner = false
    @cafe = false
    @animal = false
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
    @spa = false
    @game = false
    @temple = false
    @theater = false
    @cyber = false
    @consept = false
    @experience = false
    @street = false
    @complex = false
    @other = false
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
      if params[:large] == "スパ・温泉"
        @spa = true
      end
      if params[:large] == "ゲームセンター"
        @game = true
      end
      if params[:large] == "お寺・神社"
        @temple = true
      end
      if params[:large] == "劇場"
        @theater = true
      end
      if params[:large] == "インターネットカフェ"
        @cyber = true
      end
      if params[:large] == "コンセプトカフェ・バー"
        @consept = true
      end
      if params[:large] == "体験"
        @experience = true
      end
      if params[:large] == "ストリート"
        @street = true
      end
      if params[:large] == "複合施設"
        @complex = true
      end
      if params[:large] == "その他"
        @other = true
      end
    end

     @distance_on = false
    if params[:distance_on] == "true"
      @distance_on = true
    end

    @all_timezone = false
    @morning = false
    @noon = false
    @night = false
    @late_night = false
    if !params[:timezone].blank?
      if params[:timezone] == "すべての時間帯"
        @all_timezone = true
      end
      if params[:timezone] == "朝"
        @morning = true
      end
      if params[:timezone] == "昼"
        @noon = true
      end
      if params[:timezone] == "夜"
        @night = true
      end
      if params[:timezone] == "深夜"
        @late_night = true
      end
    end

    @distance_on_on = false
    @distance_on_off = false
    if !params[:distance_on].blank?
      if params[:distance_on] == "true"
        @distance_on_on = true
      end
      if params[:distance_on] == "false"
        @distance_on_off = true
      end
    end


    @wday = Date.today.wday

    @ss = []
    unless params[:ss].blank?
      @ss = params[:ss]
    end

  end

end



