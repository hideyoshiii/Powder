class SeeksController < ApplicationController
  before_action :set_params, only: [:area,:distance,:category,:meal,:choice,:result]

  def home
  end

  def method
  end

  def line
  end

  def mail
  end

  def confirmline
    @starts = params[:time_start]
    @start_h = @starts["(4i)"]
    @start_m = @starts["(5i)"]
    @ends = params[:time_end]
    @end_h = @ends["(4i)"]
    @end_m = @ends["(5i)"]
  end

  def confirmmail
  end

  def distance
  end

  def area
  end

  def meal
  end

  def category
  	#@spotsを定義
  	@spots = Spot.all
    #@latitudeがない物を排除
    @spots = @spots.where.not(latitude: nil)
  	#同じスポットが含まれないように
    unless @ss.blank?
      @ss.each do |s|
        @spot = Spot.find(s)
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
      unless @ss.blank?
        unless params[:distance].blank?
          @spot_last = Spot.find(@ss.last)
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
    unless @ss.blank?
      @ss.each do |s|
        @spot = Spot.find(s)
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
      unless @ss.blank?
    		unless params[:distance].blank?
          @spot_last = Spot.find(@ss.last)
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

  
  def result

  #フラッシュ
	flash.now[:notice] = "コースが作成されました"

  end


  private
  def set_params

  	#何軒目かを定義
  	if params[:spot1].blank?
  		@spot_n = 1
  	else
  		if params[:spot2].blank?
  			@spot_n = 2
  			@spot1 = Spot.find(params[:spot1])
  		else
  			if params[:spot3].blank?
  				@spot_n = 3
  				@spot1 = Spot.find(params[:spot1])
  				@spot2 = Spot.find(params[:spot2])
  			end
  		end
  	end

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