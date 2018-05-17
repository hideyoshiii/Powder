class ExamsController < ApplicationController

before_action :set_params, only: [:spots]

def theme
end

def budget	
end

def home
	#@spotsを定義
	@spots = Spot.all
	#@latitudeがない物を排除
    @spots = @spots.where.not(latitude: nil)
    #@スポットを10個に限定
	@spots = @spots.where(prefecture: "東京").order("RANDOM()").page(params[:page]).per(5)

	#@cityを定義
	if params[:city].blank?  
      @city = "指定なし"
    end

    #@categoryを定義
    if params[:category].blank?  
      @category = "指定なし"
    end

    #params[price_min]がない時のの定義
    if params[:price_min].blank?
      params[:price_min] = 0
    end
    #params[price_max]がない時のの定義
    if params[:price_max].blank?
      params[:price_max] = 10000
    end
    #@price_minを定義
    @price_min = params[:price_min].to_i
    #@price_maxを定義
    @price_max = params[:price_max].to_i

end

def spots
	#@spotsを定義
	@spots = Spot.all
	#@latitudeがない物を排除
    @spots = @spots.where.not(latitude: nil)

	if params[:city].blank?  
      @city = "指定なし"
    else
	  @city = params[:city]
      unless params[:city] == "指定なし"
        @spots = @spots.where(city: @city)
      end
    end

    if params[:category].blank?  
    	@category = "指定なし"
    else
      @category = params[:category]
      unless params[:category] == "指定なし"
        @spots = @spots.where("large like '%#{@category}%'")
      end
    end

    #params[price_min]がない時のの定義
    if params[:price_min].blank?
      params[:price_min] = 0
    end
    #params[price_max]がない時のの定義
    if params[:price_max].blank?
      params[:price_max] = 10000
    end
    #@price_minを定義
    @price_min = params[:price_min].to_i
    #@price_maxを定義
    @price_max = params[:price_max].to_i
    #料金で絞る
    if @category == "朝食"
    	if @price_max == 10000
    		@spots = @spots.where(price_lunch: @price_min..50000)
    	else
  			@spots = @spots.where(price_lunch: @price_min..@price_max)
  		end
  	end
  	if @category == "ランチ"
  		if @price_max == 10000
  			@spots = @spots.where(price_lunch: @price_min..50000)
    	else
  			@spots = @spots.where(price_lunch: @price_min..@price_max)
  		end
  	end
  	if @category == "ディナー"
  		if @price_max == 10000
  			@spots = @spots.where(price_dinner: @price_min..50000)
    	else
  			@spots = @spots.where(price_dinner: @price_min..@price_max)
  		end
  	end

    @spots = @spots.order("RANDOM()").page(params[:page]).per(30)
end

def result   

unless params[:theme].blank?

   #@spotsを定義
   @spots = Spot.all
   #@latitudeがない物を排除
   @spots = @spots.where.not(latitude: nil)
   #距離定義
   @distance = 0.5.to_f
   #昼のカテゴリー定義
   @noons = ["アニマルカフェ", "映画", "ショップ・雑貨屋", "スポーツ", "プラネタリウム", "ボーリング", "ダーツ", "カラオケ", "公園", "動物園", "水族館", "美術館", "遊園地", "食べ歩き", "スパ・温泉", "ゲームセンター", "お寺・神社", "劇場", "コンセプトカフェ・バー", "体験", "ストリート", "複合施設", "その他"]
   #夜のカテゴリー定義
   @nights = ["カフェ","バー", "夜景"]
   #予算定義
   if params[:budget] == "1"
     @price_start = 0
     @price_end = 1000
     @price_startz = 0
     @price_endz = 5000
   end
   if params[:budget] == "2"
     @price_start = 1001
     @price_end = 2000
     @price_startz = 5001
     @price_endz = 8000
   end
   if params[:budget] == "3"
     @price_start = 1001
     @price_end = 6000
     @price_startz = 8001
     @price_endz = 50000
   end

   #ディナーデート
   if params[:theme] == "ディナー"
   	#timezomeを定義
    params[:timezone] = "night"
    #スポット１
    @spot1_category = @spots.where("large like '%ディナー%'")
    @spot1_price = @spot1_category.where(price_dinner: @price_startz..@price_endz)
    @spot1 = @spot1_price.order("RANDOM()").first
    #スポット２
    @spot2_not = @spots.where.not(title: @spot1.title)
    @spot2_not_lunch = @spot2_not.where.not("large like '%ディナー%'")
    @spot2_timezone = @spot2_not_lunch.where("timezone like '%夜%'")
    @spot2_category = @spot2_timezone
    @spot2_category = @spot2_category.where(
      @nights.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@nights.map { |attr| "%#{attr}%" }
      )
    @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
    until @spot2_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
    end
    @spot2 = @spot2_distance.order("RANDOM()").first
   end

   #ランチデート
   if params[:theme] == "ランチ"
   	#timezomeを定義
    params[:timezone] = "noon"
   	#スポット１(ランチ)
    @spot1_category = @spots.where("large like '%ランチ%'")
    @spot1_price = @spot1_category.where(price_lunch: @price_start..@price_end)
    @spot1 = @spot1_price.order("RANDOM()").first
    #スポット２
    @spot2_not = @spots.where.not(title: @spot1.title)
    @spot2_not_lunch = @spot2_not.where.not("large like '%ランチ%'")
    @spot2_timezone = @spot2_not_lunch.where("timezone like '%昼%'")
    @spot2_category = @spot2_timezone
    @spot2_category = @spot2_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
    until @spot2_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
    end
    @spot2 = @spot2_distance.order("RANDOM()").first
   end

   #水族館デート
   if params[:theme] == "水族館"
   	#timezomeを定義
    params[:timezone] = "noon"
   	#スポット２
   	@spot2_category = @spots.where("large like '%水族館%'")
   	@spot2 = @spot2_category.order("RANDOM()").first
   	#スポット１(ランチ)
    @spot1_not = @spots.where.not(title: @spot2.title)
    @spot1_category = @spot1_not.where("large like '%ランチ%'")
    @spot1_price = @spot1_category.where(price_lunch: @price_start..@price_end)
    @spot1_distance = @spot1_price.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    until @spot1_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot1_distance = @spot1_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    end
    @spot1 = @spot1_distance.order("RANDOM()").first
    #スポット３
    @spot3_not = @spots.where.not(title: @spot1.title)
    @spot3_not = @spot3_not.where.not(title: @spot2.title)
    @spot3_not_lunch = @spot3_not.where.not("large like '%ランチ%'")
    @spot3_timezone = @spot3_not_lunch.where("timezone like '%昼%'")
    @spot3_category = @spot3_timezone
    @spot3_category = @spot3_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    until @spot3_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    end
    @spot3 = @spot3_distance.order("RANDOM()").first
    #スポット４(ディナー)
    @spot4_not = @spots.where.not(title: @spot1.title)
    @spot4_not = @spot4_not.where.not(title: @spot2.title)
    @spot4_not = @spot4_not.where.not(title: @spot3.title)
    @spot4_category = @spot4_not.where("large like '%ディナー%'")
    @spot4_price = @spot4_category.where(price_dinner: @price_startz..@price_endz)
    @spot4_distance = @spot4_price.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    until @spot4_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot4_distance = @spot4_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    end
    @spot4 = @spot4_distance.order("RANDOM()").first
    #スポット５
    @spot5_not = @spots.where.not(title: @spot1.title)
    @spot5_not = @spot5_not.where.not(title: @spot2.title)
    @spot5_not = @spot5_not.where.not(title: @spot3.title)
    @spot5_not = @spot5_not.where.not(title: @spot4.title)
    @spot5_not_lunch = @spot5_not.where.not("large like '%ディナー%'")
    @spot5_timezone = @spot5_not_lunch.where("timezone like '%夜%'")
    @spot5_category = @spot5_timezone
    @spot5_category = @spot5_category.where(
      @nights.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@nights.map { |attr| "%#{attr}%" }
      )
    @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    until @spot5_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    end
    @spot5 = @spot5_distance.order("RANDOM()").first
   end

   #動物園デート
   if params[:theme] == "動物園"
   	#timezomeを定義
    params[:timezone] = "noon"
   	#スポット２
   	@spot2_category = @spots.where("large like '%動物園%'")
   	@spot2 = @spot2_category.order("RANDOM()").first
   	#スポット１(ランチ)
    @spot1_not = @spots.where.not(title: @spot2.title)
    @spot1_category = @spot1_not.where("large like '%ランチ%'")
    @spot1_price = @spot1_category.where(price_lunch: @price_start..@price_end)
    @spot1_distance = @spot1_price.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    until @spot1_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot1_distance = @spot1_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    end
    @spot1 = @spot1_distance.order("RANDOM()").first
    #スポット３
    @spot3_not = @spots.where.not(title: @spot1.title)
    @spot3_not = @spot3_not.where.not(title: @spot2.title)
    @spot3_not_lunch = @spot3_not.where.not("large like '%ランチ%'")
    @spot3_timezone = @spot3_not_lunch.where("timezone like '%昼%'")
    @spot3_category = @spot3_timezone
    @spot3_category = @spot3_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    until @spot3_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    end
    @spot3 = @spot3_distance.order("RANDOM()").first
    #スポット４(ディナー)
    @spot4_not = @spots.where.not(title: @spot1.title)
    @spot4_not = @spot4_not.where.not(title: @spot2.title)
    @spot4_not = @spot4_not.where.not(title: @spot3.title)
    @spot4_category = @spot4_not.where("large like '%ディナー%'")
    @spot4_price = @spot4_category.where(price_dinner: @price_startz..@price_endz)
    @spot4_distance = @spot4_price.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    until @spot4_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot4_distance = @spot4_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    end
    @spot4 = @spot4_distance.order("RANDOM()").first
    #スポット５
    @spot5_not = @spots.where.not(title: @spot1.title)
    @spot5_not = @spot5_not.where.not(title: @spot2.title)
    @spot5_not = @spot5_not.where.not(title: @spot3.title)
    @spot5_not = @spot5_not.where.not(title: @spot4.title)
    @spot5_not_lunch = @spot5_not.where.not("large like '%ディナー%'")
    @spot5_timezone = @spot5_not_lunch.where("timezone like '%夜%'")
    @spot5_category = @spot5_timezone
    @spot5_category = @spot5_category.where(
      @nights.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@nights.map { |attr| "%#{attr}%" }
      )
    @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    until @spot5_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    end
    @spot5 = @spot5_distance.order("RANDOM()").first
   end

   #映画デート
   if params[:theme] == "映画"
   	#timezomeを定義
    params[:timezone] = "noon"
   	#スポット２
   	@spot2_category = @spots.where("large like '%映画%'")
   	@spot2 = @spot2_category.order("RANDOM()").first
   	#スポット１(ランチ)
    @spot1_not = @spots.where.not(title: @spot2.title)
    @spot1_category = @spot1_not.where("large like '%ランチ%'")
    @spot1_price = @spot1_category.where(price_lunch: @price_start..@price_end)
    @spot1_distance = @spot1_price.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    until @spot1_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot1_distance = @spot1_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    end
    @spot1 = @spot1_distance.order("RANDOM()").first
    #スポット３
    @spot3_not = @spots.where.not(title: @spot1.title)
    @spot3_not = @spot3_not.where.not(title: @spot2.title)
    @spot3_not_lunch = @spot3_not.where.not("large like '%ランチ%'")
    @spot3_timezone = @spot3_not_lunch.where("timezone like '%昼%'")
    @spot3_category = @spot3_timezone
    @spot3_category = @spot3_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    until @spot3_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    end
    @spot3 = @spot3_distance.order("RANDOM()").first
    #スポット４(ディナー)
    @spot4_not = @spots.where.not(title: @spot1.title)
    @spot4_not = @spot4_not.where.not(title: @spot2.title)
    @spot4_not = @spot4_not.where.not(title: @spot3.title)
    @spot4_category = @spot4_not.where("large like '%ディナー%'")
    @spot4_price = @spot4_category.where(price_dinner: @price_startz..@price_endz)
    @spot4_distance = @spot4_price.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    until @spot4_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot4_distance = @spot4_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    end
    @spot4 = @spot4_distance.order("RANDOM()").first
    #スポット５
    @spot5_not = @spots.where.not(title: @spot1.title)
    @spot5_not = @spot5_not.where.not(title: @spot2.title)
    @spot5_not = @spot5_not.where.not(title: @spot3.title)
    @spot5_not = @spot5_not.where.not(title: @spot4.title)
    @spot5_not_lunch = @spot5_not.where.not("large like '%ディナー%'")
    @spot5_timezone = @spot5_not_lunch.where("timezone like '%夜%'")
    @spot5_category = @spot5_timezone
    @spot5_category = @spot5_category.where(
      @nights.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@nights.map { |attr| "%#{attr}%" }
      )
    @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    until @spot5_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    end
    @spot5 = @spot5_distance.order("RANDOM()").first
   end

   #夜景デート
   if params[:theme] == "夜景"
   	#timezomeを定義
    params[:timezone] = "noon"
   	#スポット５
    @spot5_category = @spots.where("large like '%夜景%'")
   	@spot5 = @spot5_category.order("RANDOM()").first
    #スポット４(ディナー)
    @spot4_not = @spots.where.not(title: @spot5.title)
    @spot4_category = @spot4_not.where("large like '%ディナー%'")
    @spot4_price = @spot4_category.where(price_dinner: @price_startz..@price_endz)
    @spot4_distance = @spot4_price.near([@spot5.latitude, @spot5.longitude], @distance, :units => :km, :order => false)
    until @spot4_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot4_distance = @spot4_category.near([@spot5.latitude, @spot5.longitude], @distance, :units => :km, :order => false)
    end
    @spot4 = @spot4_distance.order("RANDOM()").first
    #スポット３
    @spot3_not = @spots.where.not(title: @spot4.title)
    @spot3_not = @spot3_not.where.not(title: @spot5.title)
    @spot3_not_lunch = @spot3_not.where.not("large like '%ランチ%'")
    @spot3_timezone = @spot3_not_lunch.where("timezone like '%昼%'")
    @spot3_category = @spot3_timezone
    @spot3_category = @spot3_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    @spot3_distance = @spot3_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    until @spot3_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot3_distance = @spot3_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    end
    @spot3 = @spot3_distance.order("RANDOM()").first
    #スポット２
    @spot2_not = @spots.where.not(title: @spot3.title)
    @spot2_not = @spot2_not.where.not(title: @spot4.title)
    @spot2_not = @spot2_not.where.not(title: @spot5.title)
    @spot2_not_lunch = @spot2_not.where.not("large like '%ランチ%'")
    @spot2_timezone = @spot2_not_lunch.where("timezone like '%昼%'")
    @spot2_category = @spot2_timezone
    @spot2_category = @spot2_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    @spot2_distance = @spot2_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    until @spot2_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot2_distance = @spot2_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    end
    @spot2 = @spot2_distance.order("RANDOM()").first
    #スポット１(ランチ)
    @spot1_not = @spots.where.not(title: @spot2.title)
    @spot1_not = @spot1_not.where.not(title: @spot3.title)
    @spot1_not = @spot1_not.where.not(title: @spot4.title)
    @spot1_not = @spot1_not.where.not(title: @spot5.title)
    @spot1_category = @spot1_not.where("large like '%ランチ%'")
    @spot1_price = @spot1_category.where(price_lunch: @price_start..@price_end)
    @spot1_distance = @spot1_price.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    until @spot1_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot1_distance = @spot1_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    end
    @spot1 = @spot1_distance.order("RANDOM()").first
   end

   #夜景デート
   if params[:theme] == "美術館巡り"
   	#timezomeを定義
    params[:timezone] = "noon"
    #スポット２
   	@spot2_category = @spots.where("large like '%美術館%'")
   	@spot2 = @spot2_category.order("RANDOM()").first
   	#スポット１(ランチ)
    @spot1_not = @spots.where.not(title: @spot2.title)
    @spot1_category = @spot1_not.where("large like '%ランチ%'")
    @spot1_price = @spot1_category.where(price_lunch: @price_start..@price_end)
    @spot1_distance = @spot1_price.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    until @spot1_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot1_distance = @spot1_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    end
    @spot1 = @spot1_distance.order("RANDOM()").first
    #スポット３
    @spot3_not = @spots.where.not(title: @spot1.title)
    @spot3_not = @spot3_not.where.not(title: @spot2.title)
    @spot3_not_lunch = @spot3_not.where.not("large like '%ランチ%'")
    @spot3_timezone = @spot3_not_lunch.where("timezone like '%昼%'")
    @spot3_category = @spot3_timezone
    @spot3_series = @spot3_category.near([@spot2.latitude, @spot2.longitude], 0.70, :units => :km, :order => false)
    unless @spot3_series.size = 0
    	@spot3_same = @spots.where("large like '%美術館%'")
    	@spot3 = @spot3_same.order("RANDOM()").first
    end
    if @spot3.blank?
	    @spot3_category = @spot3_category.where(
	      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
	      *@noons.map { |attr| "%#{attr}%" }
	      )
	    @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
	    until @spot3_distance.size >= 1 do
	      @distance = @distance + 0.2.to_f
	      @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
	    end
	    @spot3 = @spot3_distance.order("RANDOM()").first
   	end
    #スポット４(ディナー)
    @spot4_not = @spots.where.not(title: @spot1.title)
    @spot4_not = @spot4_not.where.not(title: @spot2.title)
    @spot4_not = @spot4_not.where.not(title: @spot3.title)
    @spot4_category = @spot4_not.where("large like '%ディナー%'")
    @spot4_price = @spot4_category.where(price_dinner: @price_startz..@price_endz)
    @spot4_distance = @spot4_price.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    until @spot4_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot4_distance = @spot4_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    end
    @spot4 = @spot4_distance.order("RANDOM()").first
    #スポット５
    @spot5_not = @spots.where.not(title: @spot1.title)
    @spot5_not = @spot5_not.where.not(title: @spot2.title)
    @spot5_not = @spot5_not.where.not(title: @spot3.title)
    @spot5_not = @spot5_not.where.not(title: @spot4.title)
    @spot5_not_lunch = @spot5_not.where.not("large like '%ディナー%'")
    @spot5_timezone = @spot5_not_lunch.where("timezone like '%夜%'")
    @spot5_category = @spot5_timezone
    @spot5_category = @spot5_category.where(
      @nights.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@nights.map { |attr| "%#{attr}%" }
      )
    @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    until @spot5_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    end
    @spot5 = @spot5_distance.order("RANDOM()").first
   end



end

unless params[:spot].blank?

   #@spotsを定義
   @spots = Spot.all
   #@latitudeがない物を排除
   @spots = @spots.where.not(latitude: nil)
   #距離定義
   @distance = 0.5.to_f
   #昼のカテゴリー定義
   @noons = ["アニマルカフェ", "映画", "ショップ・雑貨屋", "スポーツ", "プラネタリウム", "ボーリング", "ダーツ", "カラオケ", "公園", "動物園", "水族館", "美術館", "遊園地", "食べ歩き", "スパ・温泉", "ゲームセンター", "お寺・神社", "劇場", "コンセプトカフェ・バー", "体験", "ストリート", "複合施設", "その他"]
   #夜のカテゴリー定義
   @nights = ["カフェ","バー", "夜景"]
   #timezomeを定義
   params[:timezone] = "noon"
   #基本スポットを定義
   unless params[:spot].blank?
   	@spot = Spot.find(params[:spot])
   	#基本スポットのカテゴリーを定義
   	if params[:large].blank?
   		@large = @spot.large.sample
   	else
   		@large = params[:large]
   	end
   end
   #ランチの時
   if @large == "ランチ"
   	#スポット１(ランチ)
    @spot1 = @spot
    #スポット２
    @spot2_not = @spots.where.not(title: @spot1.title)
    @spot2_not_lunch = @spot2_not.where.not("large like '%ランチ%'")
    @spot2_timezone = @spot2_not_lunch.where("timezone like '%昼%'")
    @spot2_category = @spot2_timezone
    @spot2_category = @spot2_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
    until @spot2_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
    end
    @spot2 = @spot2_distance.order("RANDOM()").first
    #スポット３
    @spot3_not = @spots.where.not(title: @spot1.title)
    @spot3_not = @spot3_not.where.not(title: @spot2.title)
    @spot3_not_lunch = @spot3_not.where.not("large like '%ランチ%'")
    @spot3_timezone = @spot3_not_lunch.where("timezone like '%昼%'")
    @spot3_category = @spot3_timezone
    @spot3_category = @spot3_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    until @spot3_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    end
    @spot3 = @spot3_distance.order("RANDOM()").first
    #スポット４(ディナー)
    @spot4_not = @spots.where.not(title: @spot1.title)
    @spot4_not = @spot4_not.where.not(title: @spot2.title)
    @spot4_not = @spot4_not.where.not(title: @spot3.title)
    @spot4_category = @spot4_not.where("large like '%ディナー%'")
    @spot4_distance = @spot4_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    until @spot4_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot4_distance = @spot4_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    end
    @spot4 = @spot4_distance.order("RANDOM()").first
    #スポット５
    @spot5_not = @spots.where.not(title: @spot1.title)
    @spot5_not = @spot5_not.where.not(title: @spot2.title)
    @spot5_not = @spot5_not.where.not(title: @spot3.title)
    @spot5_not = @spot5_not.where.not(title: @spot4.title)
    @spot5_not_lunch = @spot5_not.where.not("large like '%ディナー%'")
    @spot5_timezone = @spot5_not_lunch.where("timezone like '%夜%'")
    @spot5_category = @spot5_timezone
    @spot5_category = @spot5_category.where(
      @nights.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@nights.map { |attr| "%#{attr}%" }
      )
    @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    until @spot5_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    end
    @spot5 = @spot5_distance.order("RANDOM()").first
   end

   #昼スポットの時
   if @noons.include?(@large)
   	#スポット２
    @spot2 = @spot
    #スポット１ランチ()
    @spot1_not = @spots.where.not(title: @spot2.title)
    @spot1_category = @spot1_not.where("large like '%ランチ%'")
    @spot1_distance = @spot1_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    until @spot1_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot1_distance = @spot1_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    end
    @spot1 = @spot1_distance.order("RANDOM()").first
    #スポット３
    @spot3_not = @spots.where.not(title: @spot1.title)
    @spot3_not = @spot3_not.where.not(title: @spot2.title)
    @spot3_not_lunch = @spot3_not.where.not("large like '%ランチ%'")
    @spot3_timezone = @spot3_not_lunch.where("timezone like '%昼%'")
    @spot3_category = @spot3_timezone
    @spot3_category = @spot3_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    until @spot3_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    end
    @spot3 = @spot3_distance.order("RANDOM()").first
    #スポット４(ディナー)
    @spot4_not = @spots.where.not(title: @spot1.title)
    @spot4_not = @spot4_not.where.not(title: @spot2.title)
    @spot4_not = @spot4_not.where.not(title: @spot3.title)
    @spot4_category = @spot4_not.where("large like '%ディナー%'")
    @spot4_distance = @spot4_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    until @spot4_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot4_distance = @spot4_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    end
    @spot4 = @spot4_distance.order("RANDOM()").first
    #スポット５
    @spot5_not = @spots.where.not(title: @spot1.title)
    @spot5_not = @spot5_not.where.not(title: @spot2.title)
    @spot5_not = @spot5_not.where.not(title: @spot3.title)
    @spot5_not = @spot5_not.where.not(title: @spot4.title)
    @spot5_not_lunch = @spot5_not.where.not("large like '%ディナー%'")
    @spot5_timezone = @spot5_not_lunch.where("timezone like '%夜%'")
    @spot5_category = @spot5_timezone
    @spot5_category = @spot5_category.where(
      @nights.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@nights.map { |attr| "%#{attr}%" }
      )
    @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    until @spot5_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    end
    @spot5 = @spot5_distance.order("RANDOM()").first
   end

   #ディナーの時
   if @large == "ディナー"
   	#スポット４(ディナー)
   	@spot4 = @spot
   	#スポット３
    @spot3_not = @spots.where.not(title: @spot4.title)
    @spot3_not_lunch = @spot3_not.where.not("large like '%ランチ%'")
    @spot3_timezone = @spot3_not_lunch.where("timezone like '%昼%'")
    @spot3_category = @spot3_timezone
    @spot3_category = @spot3_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    @spot3_distance = @spot3_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    until @spot3_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot3_distance = @spot3_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    end
    @spot3 = @spot3_distance.order("RANDOM()").first
    #スポット２
    @spot2_not = @spots.where.not(title: @spot3.title)
    @spot2_not = @spot2_not.where.not(title: @spot4.title)
    @spot2_not_lunch = @spot2_not.where.not("large like '%ランチ%'")
    @spot2_timezone = @spot2_not_lunch.where("timezone like '%昼%'")
    @spot2_category = @spot2_timezone
    @spot2_category = @spot2_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    @spot2_distance = @spot2_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    until @spot2_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot2_distance = @spot2_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    end
    @spot2 = @spot2_distance.order("RANDOM()").first
    #スポット１(ランチ)
    @spot1_not = @spots.where.not(title: @spot2.title)
    @spot1_not = @spot1_not.where.not(title: @spot3.title)
    @spot1_not = @spot1_not.where.not(title: @spot4.title)
    @spot1_category = @spot1_not.where("large like '%ランチ%'")
    @spot1_distance = @spot1_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    until @spot1_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot1_distance = @spot1_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    end
    @spot1 = @spot1_distance.order("RANDOM()").first
    #スポット５
    @spot5_not = @spots.where.not(title: @spot1.title)
    @spot5_not = @spot5_not.where.not(title: @spot2.title)
    @spot5_not = @spot5_not.where.not(title: @spot3.title)
    @spot5_not = @spot5_not.where.not(title: @spot4.title)
    @spot5_not_lunch = @spot5_not.where.not("large like '%ディナー%'")
    @spot5_timezone = @spot5_not_lunch.where("timezone like '%夜%'")
    @spot5_category = @spot5_timezone
    @spot5_category = @spot5_category.where(
      @nights.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@nights.map { |attr| "%#{attr}%" }
      )
    @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    until @spot5_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    end
    @spot5 = @spot5_distance.order("RANDOM()").first
   end

   #夜スポットの時
   if @nights.include?(@large)
   	#スポット５
    @spot5 = @spot
    #スポット４(ディナー)
    @spot4_not = @spots.where.not(title: @spot5.title)
    @spot4_category = @spot4_not.where("large like '%ディナー%'")
    @spot4_distance = @spot4_category.near([@spot5.latitude, @spot5.longitude], @distance, :units => :km, :order => false)
    until @spot4_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot4_distance = @spot4_category.near([@spot5.latitude, @spot5.longitude], @distance, :units => :km, :order => false)
    end
    @spot4 = @spot4_distance.order("RANDOM()").first
    #スポット３
    @spot3_not = @spots.where.not(title: @spot4.title)
    @spot3_not = @spot3_not.where.not(title: @spot5.title)
    @spot3_not_lunch = @spot3_not.where.not("large like '%ランチ%'")
    @spot3_timezone = @spot3_not_lunch.where("timezone like '%昼%'")
    @spot3_category = @spot3_timezone
    @spot3_category = @spot3_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    @spot3_distance = @spot3_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    until @spot3_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot3_distance = @spot3_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    end
    @spot3 = @spot3_distance.order("RANDOM()").first
    #スポット２
    @spot2_not = @spots.where.not(title: @spot3.title)
    @spot2_not = @spot2_not.where.not(title: @spot4.title)
    @spot2_not = @spot2_not.where.not(title: @spot5.title)
    @spot2_not_lunch = @spot2_not.where.not("large like '%ランチ%'")
    @spot2_timezone = @spot2_not_lunch.where("timezone like '%昼%'")
    @spot2_category = @spot2_timezone
    @spot2_category = @spot2_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    @spot2_distance = @spot2_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    until @spot2_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot2_distance = @spot2_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    end
    @spot2 = @spot2_distance.order("RANDOM()").first
    #スポット１(ランチ)
    @spot1_not = @spots.where.not(title: @spot2.title)
    @spot1_not = @spot1_not.where.not(title: @spot3.title)
    @spot1_not = @spot1_not.where.not(title: @spot4.title)
    @spot1_not = @spot1_not.where.not(title: @spot5.title)
    @spot1_category = @spot1_not.where("large like '%ランチ%'")
    @spot1_distance = @spot1_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    until @spot1_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot1_distance = @spot1_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
    end
    @spot1 = @spot1_distance.order("RANDOM()").first
   end
   
   #夜からの時
   if params[:timezone] == "night"
    #スポット１
    @spot1_city = @spots.where(city: params[:city])
    @spot1_category = @spot1_city.where("large like '%ディナー%'")
    @spot1_price = @spot1_category.where(price_dinner: @price_startz..@price_endz)
    @spot1 = @spot1_price.order("RANDOM()").first
    #スポット２
    @spot2_not = @spots.where.not(title: @spot1.title)
    @spot2_not_lunch = @spot2_not.where.not("large like '%ディナー%'")
    @spot2_timezone = @spot2_not_lunch.where("timezone like '%夜%'")
    @spot2_category = @spot2_timezone
    @spot2_category_2 = @spot2_timezone
    @spot2_category = @spot2_category.where(
      @nights.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@nights.map { |attr| "%#{attr}%" }
      )
    if @spot2_category.blank?
      @nights_not.each.with_index(1) do |night, i|
        @spot2_category = @spot2_category_2.where.not("large like '%#{night}%'")
      end
    end
    @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
    until @spot2_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
    end
    @spot2 = @spot2_distance.order("RANDOM()").first
   end

end



   #配列を作る
   @ss = []
   unless @spot1.blank?
     @ss.push(@spot1.id)
   end
   unless @spot2.blank?
     @ss.push(@spot2.id)
   end
   unless @spot3.blank?
     @ss.push(@spot3.id)
   end
   unless @spot4.blank?
     @ss.push(@spot4.id)
   end
   unless @spot5.blank?
     @ss.push(@spot5.id)
   end
   params[:ss] = []
   params[:ss] = @ss
    #料金について
    @ss_first = @ss.first
    @ss_last = @ss.last
    @spot_first = Spot.find(@ss_first)
    @spot_last = Spot.find(@ss_last)

    #料金
    @tatal = 0
    if params[:timezone] == "noon"
      @ss.each.with_index(1) do |s, i|
      	spot = Spot.find(s)
      	if i < 4
      		if spot.price_lunch.blank?
      			@price = 0
      		else
      			@price = spot.price_lunch
      		end
      	else
      		if spot.price_dinner.blank?
      			@price = 0
      		else
      			@price = spot.price_dinner
      		end
      	end
      	@total = @total.to_i + @price.to_i
      end
    end
    if params[:timezone] == "night"
      @ss.each.with_index(1) do |s, i|
      	spot = Spot.find(s)    	
      		if spot.price_dinner.blank?
      			@price = 0
      		else
      			@price = spot.price_dinner
      		end
      	@total = @total.to_i + @price.to_i
      end
    end

    if params[:timezone] == "noon"
      @timezone_ja = "昼"
    end
    if params[:timezone] == "night"
      @timezone_ja = "夜"
    end

    #ツイート用のURL作成
    @timezone = params[:timezone]
    @url = root_url(only_path: false)
    @url = @url.to_s + 'plan?'
    params[:ss].each.with_index(1) do |s, i|
      @url = @url.to_s + "&ss%5B%5D=#{s}"
    end
    @url = @url.to_s + "&timezone=#{@timezone}"

    flash.now[:notice] = "コースが作成されました"
    
  end


  private
  def set_params

  	
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
    @jiyugaoka = false
    @nakano = false
    @ningyocho = false
    @tachikawa = false
    @oicho = false
    @sangenchaya = false
    @otsuka = false
    @chofu = false
    @machida = false
    @senju = false
    @nerima = false
    @okubo = false
    @yoyogi = false
    @itabashi = false
    @ryogoku = false
    @koganei = false
    @izushoto = false

    if !params[:city].blank?
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
      if params[:city] == "自由が丘・二子玉川"
        @jiyugaoka = true
      end
      if params[:city] == "中野・荻窪"
        @nakano = true
      end
      if params[:city] == "人形町・門前仲町・葛西"
        @ningyocho = true
      end
      if params[:city] == "立川・八王子・青梅"
        @tachikawa = true
      end
      if params[:city] == "大井町・大森・蒲田"
        @oicho = true
      end
      if params[:city] == "三軒茶屋・駒沢"
        @sangenchaya = true
      end
      if params[:city] == "大塚・巣鴨・駒込"
        @otsuka = true
      end
      if params[:city] == "調布・府中・狛江"
        @chofu = true
      end
      if params[:city] == "町田・稲城・多摩"
        @machida = true
      end
      if params[:city] == "千住・綾瀬・葛飾"
        @senju = true
      end
      if params[:city] == "練馬・江古田"
        @nerima = true
      end
      if params[:city] == "大久保・高田馬場・早稲田"
        @okubo = true
      end
      if params[:city] == "代々木・初台"
        @yoyogi = true
      end
      if params[:city] == "板橋・赤羽"
        @itabashi = true
      end
      if params[:city] == "両国・錦糸町・小岩"
        @ryogoku = true
      end
      if params[:city] == "小金井・国分寺・国立"
        @koganei = true
      end
      if params[:city] == "伊豆諸島・小笠原"
        @izushoto = true
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
    if !params[:category].blank?
    	if params[:category] == "朝食"
        @breakfast = true
      end
      if params[:category] == "ランチ"
        @lunch = true
      end
      if params[:category] == "ディナー"
        @dinner = true
      end
      if params[:category] == "カフェ"
        @cafe = true
      end
      if params[:category] == "アニマルカフェ"
        @animal = true
      end
      if params[:category] == "バー"
        @bar = true
      end
      if params[:category] == "映画"
        @movie = true
      end
      if params[:category] == "ショップ・雑貨屋"
        @shop = true
      end
      if params[:category] == "カラオケ"
        @karaoke = true
      end
      if params[:category] == "スポーツ"
        @sport = true
      end
      if params[:category] == "夜景"
        @nitht_view = true
      end
      if params[:category] == "プラネタリウム"
        @planetarium = true
      end
      if params[:category] == "動物園"
        @zoo = true
      end
      if params[:category] == "水族館"
        @aquarium = true
      end
      if params[:category] == "美術館"
        @museum = true
      end
      if params[:category] == "遊園地"
        @amusement_park = true
      end
      if params[:category] == "ボーリング"
        @bowling = true
      end
      if params[:category] == "ダーツ"
        @darts = true
      end
      if params[:category] == "食べ歩き"
        @walk_eat = true
      end
      if params[:category] == "公園"
        @park = true
      end
      if params[:category] == "スパ・温泉"
        @spa = true
      end
      if params[:category] == "ゲームセンター"
        @game = true
      end
      if params[:category] == "お寺・神社"
        @temple = true
      end
      if params[:category] == "劇場"
        @theater = true
      end
      if params[:category] == "インターネットカフェ"
        @cyber = true
      end
      if params[:category] == "コンセプトカフェ・バー"
        @consept = true
      end
      if params[:category] == "体験"
        @experience = true
      end
      if params[:category] == "ストリート"
        @street = true
      end
      if params[:category] == "複合施設"
        @complex = true
      end
      if params[:category] == "その他"
        @other = true
      end
    end

  end


end