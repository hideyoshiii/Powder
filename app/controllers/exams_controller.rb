class ExamsController < ApplicationController

def home
	#@spotsを定義
	@spots = Spot.all
	#@latitudeがない物を排除
    @spots = @spots.where.not(latitude: nil)
    #@スポットを10個に限定
	@spots = @spots.where(prefecture: "東京").limit(10).order('id DESC')

	if params[:city].blank?  
      @city = "指定なし"
    end

    if params[:category].blank?  
      @category = "指定なし"
    end
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

    @spots = @spots.order("RANDOM()").page(params[:page]).per(30)
end

def result   
   #@spotsを定義
   @spots = Spot.all
   #@latitudeがない物を排除
   @spots = @spots.where.not(latitude: nil)
   #距離定義
   @distance = 0.5.to_f
   #昼のカテゴリー定義
   @noons = ["アニマルカフェ", "映画", "ショップ・雑貨屋", "スポーツ", "プラネタリウム", "動物園", "水族館", "美術館", "遊園地", "食べ歩き", "スパ・温泉", "ゲームセンター", "お寺・神社", "劇場", "コンセプトカフェ・バー", "体験", "ストリート", "複合施設", "その他"]
   #夜のカテゴリー定義
   @nights = ["カフェ","バー", "夜景"]
   #timezomeを定義
   params[:timezone] == "noon"
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
      @spot4_distance = @spot4_price.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
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
      @spot1_distance = @spot1_price.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
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
      @spot4_distance = @spot4_price.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
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
      @spot1_distance = @spot1_price.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
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
      @spot4_distance = @spot4_price.near([@spot5.latitude, @spot5.longitude], @distance, :units => :km, :order => false)
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
      @spot1_distance = @spot1_price.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
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


end