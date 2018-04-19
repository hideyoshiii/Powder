class SeeksController < ApplicationController
  before_action :set_params, only: [:area,:distance,:category,:choice,:result,:resultsave]
  before_action :authenticate_user!, only: [:area,:distance,:category,:choice,:resultsave]

  def city    
  end

  def timezone    
  end

  def price    
    #params[price_min]がない時のの定義
    if params[:price_min].blank?
      params[:price_min] = 0
    end
    #params[price_max]がない時のの定義
    if params[:price_max].blank?
      params[:price_max] = 20000
    end
    #params[price_min]がない時のの定義
    if params[:price_minz].blank?
      params[:price_minz] = 0
    end
    #params[price_max]がない時のの定義
    if params[:price_maxz].blank?
      params[:price_maxz] = 20000
    end
  end

  def outcome   
   #@spotsを定義
   @spots = Spot.all
   #@latitudeがない物を排除
   @spots = @spots.where.not(latitude: nil)
   #予算定義
   @price_start = params[:price_min].to_i
   @price_end = params[:price_max].to_i
   @price_startz = params[:price_minz].to_i
   @price_endz = params[:price_maxz].to_i
   #距離定義
   @distance = 0.5.to_f
   #昼のカテゴリー定義
   @category_noons = ["カフェ", "アニマルカフェ", "映画", "ショップ・雑貨屋", "スポーツ", "プラネタリウム", "動物園", "水族館", "美術館", "遊園地", "カラオケ", "ボーリング", "ダーツ", "食べ歩き", "公園", "スパ・温泉", "ゲームセンター", "お寺・神社", "劇場", "インターネットカフェ", "コンセプトカフェ・バー", "体験", "ストリート", "複合施設", "その他"]
   @noons = ["カフェ","バー", "夜景"]
   #夜のカテゴリー定義
   @category_nights = ["カフェ", "バー", "夜景", "カラオケ", "ボーリング", "ダーツ", "その他"]
   @nights = ["アニマルカフェ", "映画", "ショップ・雑貨屋", "スポーツ", "プラネタリウム", "動物園", "水族館", "美術館", "遊園地", "食べ歩き", "スパ・温泉", "ゲームセンター", "お寺・神社", "劇場", "コンセプトカフェ・バー", "体験", "ストリート", "複合施設", "その他"]
   #昼からの時
   if params[:timezone] == "noon"
    #スポット１(ランチ)
    @spot1_city = @spots.where(city: params[:city])
    @spot1_category = @spot1_city.where("large like '%ランチ%'")
    @spot1_price = @spot1_category.where(price_lunch: @price_start..@price_end)
    @spot1 = @spot1_price.order("RANDOM()").first
    #スポット２
    @spot2_not = @spots.where.not(title: @spot1.title)
    @spot2_not_lunch = @spot2_not.where.not("large like '%ランチ%'")
    @spot2_timezone = @spot2_not_lunch.where("timezone like '%昼%'")
    @spot2_category = @spot2_timezone
    @noons.each.with_index(1) do |noon, i|
      @spot2_category = @spot2_category.where.not("large like '%#{noon}%'")
    end
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
    @noons.each.with_index(1) do |noon, i|
      @spot3_category = @spot3_category.where.not("large like '%#{noon}%'")
    end
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
      @spot4_distance = @spot4_price.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    end
    @spot4 = @spot4_distance.order("RANDOM()").first
    #スポット５
    @spot5_not = @spots.where.not(title: @spot1.title)
    @spot5_not = @spot5_not.where.not(title: @spot2.title)
    @spot5_not_lunch = @spot5_not.where.not("large like '%ディナー%'")
    @spot5_timezone = @spot5_not_lunch.where("timezone like '%夜%'")
    @spot5_category = @spot5_timezone
    @nights.each.with_index(1) do |night, i|
      @spot5_category = @spot5_category.where.not("large like '%#{night}%'")
    end
    @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    until @spot5_distance.size >= 1 do
      @distance = @distance + 0.2.to_f
      @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
    end
    @spot5 = @spot5_distance.order("RANDOM()").first
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
    @nights.each.with_index(1) do |night, i|
      @spot2_category = @spot2_category.where.not("large like '%#{night}%'")
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

    @total_min = 0
    @total_max = 0

    @ss.each.with_index(1) do |s, i|
      spot = Spot.find(s)
      if spot.price_lunch.blank? || spot.price_lunch == 0
        if spot.price_dinner.blank? || spot.price_lunch == 0
          @price_1 = 0
          @price_2 = 0
        else
          @price_1 = spot.price_dinner
          @price_2 = spot.price_dinner
        end
      else
        if spot.price_dinner.blank? || spot.price_lunch == 0
          @price_1 = spot.price_lunch
          @price_2 = spot.price_lunch
        else
          @price_1 = spot.price_lunch
          @price_2 = spot.price_dinner
        end
      end
      unless @price_1.blank?
        unless  @price_2.blank?
          @total_min = @total_min + @price_1
          @total_max = @total_max + @price_2
        end
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
    @url = @url.to_s + '/seeks/result?'
    params[:ss].each.with_index(1) do |s, i|
      @url = @url.to_s + "&ss%5B%5D=#{s}"
    end
    @url = @url.to_s + "&timezone=#{@timezone}"

    flash.now[:notice] = "コースが作成されました"
    
  end

  def form 
    #params[price_min]がない時のの定義
    if params[:price_min].blank?
      params[:price_min] = 0
    end
    #params[price_max]がない時のの定義
    if params[:price_max].blank?
      params[:price_max] = 20000
    end
  end

  def confirm 
    if params[:spot].blank?
      params[:spot] = "特になし"
    end
    if params[:term].blank?
      params[:term] = "特になし"
    end
  end

  def sent  
    if params[:spot].blank?
      params[:spot] = "特になし"
    end
    if params[:term].blank?
      params[:term] = "特になし"
    end
    
    email = params[:mail]
    area = params[:area]
    time_start = params[:time_start]
    time_end = params[:time_end]
    price_min = params[:price_min]
    price_max = params[:price_max]
    image = params[:image]
    relation = params[:relation]
    age_you = params[:age_you]
    sex_you = params[:sex_you]
    age_opponent = params[:age_opponent]
    sex_opponent = params[:sex_opponent]
    spot = params[:spot]
    term = params[:term]

    @amount = 300
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail], 
      :source  => params[:stripeToken] 
    )
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'A.Date customer',
      :currency    => 'jpy'
    )
    if SampleMailer.send_when_accept(email,area,time_start,time_end,price_min,price_max,image,relation,age_you,sex_you,age_opponent,sex_opponent,spot,term).deliver
      redirect_to seeks_complete_path, notice: "受付が完了しました" 
    end
    rescue Stripe::CardError => e
      flash[:error] = e.message
      render 'confirm'
      flash.now[:alert] = "受付に失敗しました"
  end

  def complete  
  end

  def personal  
  end

  def new
  end

  def create   
    @amount = 500
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail], 
      :source  => params[:stripeToken] 
    )
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'A.Date customer',
      :currency    => 'jpy'
    )
    redirect_to root_path, notice: "支払いが完了しました" 
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to seeks_new_path 
  end



  def home
    @courses = Course.where(kind: "提案").order('id DESC').page(params[:page]).per(30)   
  end

  def about
    @courses = Course.where(kind: "提案").order('id DESC').limit(5)
  end

  def method
  end

  def line
    #params[price_min]がない時のの定義
    if params[:price_min].blank?
      params[:price_min] = 0
    end
    #params[price_max]がない時のの定義
    if params[:price_max].blank?
      params[:price_max] = 20000
    end
  end

  def mail
    #params[price_min]がない時のの定義
  if params[:price_min].blank?
      params[:price_min] = 0
    end
    #params[price_max]がない時のの定義
  if params[:price_max].blank?
      params[:price_max] = 20000
    end
  end

  def confirmline
    if params[:spot].blank?
      params[:spot] = "特になし"
    end
    if params[:term].blank?
      params[:term] = "特になし"
    end
  end

  def confirmmail
    if params[:spot].blank?
      params[:spot] = "特になし"
    end
    if params[:term].blank?
      params[:term] = "特になし"
    end
  end

  def sendmail
    if params[:spot].blank?
      params[:spot] = "特になし"
    end
    if params[:term].blank?
      params[:term] = "特になし"
    end
    
    email = params[:mail]
    area = params[:area]
    time_start = params[:time_start]
    time_end = params[:time_end]
    price_min = params[:price_min]
    price_max = params[:price_max]
    image = params[:image]
    relation = params[:relation]
    age_you = params[:age_you]
    sex_you = params[:sex_you]
    age_opponent = params[:age_opponent]
    sex_opponent = params[:sex_opponent]
    spot = params[:spot]
    term = params[:term]
 
    if SampleMailer.send_when_accept(email,area,time_start,time_end,price_min,price_max,image,relation,age_you,sex_you,age_opponent,sex_opponent,spot,term).deliver
      redirect_to seeks_sent_mail_path
    else
      render 'confirmmail'
      flash.now[:alert] = "受付に失敗しました"
    end
  end

  def sentmail
  end

  def save  
    @course = Course.new(user_id: current_user.id, title: params[:title], description: params[:description], city: params[:city], time_start: params[:time_start], time_end: params[:time_end], kind: params[:kind])
    if @course.save
      params[:ss].each.with_index(1) do |s, i|
        @point = Point.new(spot_id: s.to_i, course_id: @course.id, number: i.to_i)
        @point.save
      end
      #保存に成功した場合
      redirect_to "/seeks/course/#{@course.id}", notice: "コースを保存しました" 
    else
      #保存に失敗した場合
      flash.now[:error] = '保存に失敗しました'
      render :result
    end      
  end

  def courses
    @courses = Course.where(kind: "ユーザー").order('id DESC').page(params[:page]).per(30)   
  end

  def course 
    @course =  Course.find(params[:id])
    @points = Point.where(course_id: @course.id).order(number: "ASC")

    @ss =[]
    @points.each.with_index(1) do |point, i|
      @ss.push(point.spot_id)
    end

    params[:ss] = @ss

    @ss_first = @ss.first
    @ss_last = @ss.last
    @spot_first = Spot.find(@ss_first)
    @spot_last = Spot.find(@ss_last)

    @total_min = 0
    @total_max = 0

    @ss.each.with_index(1) do |s, i|
      spot = Spot.find(s)

      if spot.price_lunch.blank? || spot.price_lunch == 0
        if spot.price_dinner.blank? || spot.price_lunch == 0
          @price_1 = 0
          @price_2 = 0
        else
          @price_1 = spot.price_dinner
          @price_2 = spot.price_dinner
        end

      else
        if spot.price_dinner.blank? || spot.price_lunch == 0
          @price_1 = spot.price_lunch
          @price_2 = spot.price_lunch
        else
          @price_1 = spot.price_lunch
          @price_2 = spot.price_dinner
        end
      end

      unless @price_1.blank?
        unless  @price_2.blank?
          @total_min = @total_min + @price_1
          @total_max = @total_max + @price_2
        end
      end

    end

    #ツイート用のURL作成
    @url = url_for(only_path: false)

  end

  def proposals
    @courses = Course.where(kind: "提案").order('id DESC').page(params[:page]).per(30)   
  end

  def proposal 
    @course =  Course.find(params[:id])
    @points = Point.where(course_id: @course.id).order(number: "ASC")

    @ss =[]
    @points.each.with_index(1) do |point, i|
      @ss.push(point.spot_id)
    end

    params[:ss] = @ss

    @ss_first = @ss.first
    @ss_last = @ss.last
    @spot_first = Spot.find(@ss_first)
    @spot_last = Spot.find(@ss_last)

    @total_min = 0
    @total_max = 0

    @ss.each.with_index(1) do |s, i|
      spot = Spot.find(s)

      if spot.price_lunch.blank? || spot.price_lunch == 0
        if spot.price_dinner.blank? || spot.price_lunch == 0
          @price_1 = 0
          @price_2 = 0
        else
          @price_1 = spot.price_dinner
          @price_2 = spot.price_dinner
        end

      else
        if spot.price_dinner.blank? || spot.price_lunch == 0
          @price_1 = spot.price_lunch
          @price_2 = spot.price_lunch
        else
          @price_1 = spot.price_lunch
          @price_2 = spot.price_dinner
        end
      end

      unless @price_1.blank?
        unless  @price_2.blank?
          @total_min = @total_min + @price_1
          @total_max = @total_max + @price_2
        end
      end

    end

    #ツイート用のURL作成
    @url = url_for(only_path: false)

  end

  def edit
    @course = Course.find(params[:id])
    @points = Point.where(course_id: @course.id).order(number: "ASC")

    if !(current_user == @course.user)
      redirect_to root_path
    end   
  end

  def sort
    @course = Course.find(params[:id])
    @points = Point.where(course_id: @course.id).order(number: "ASC")

    if !(current_user == @course.user)
      redirect_to root_path
    end   

    @course.update(title: params[:title], description: params[:description], city: params[:city], time_start: params[:time_start], time_end: params[:time_end])

    unless params[:kind].blank?
      @course.update(kind: params[:kind])
    end


    unless params[:sorts].blank?
      @sorts = params[:sorts].to_a
      @points_new = []
      @sorts.each.with_index(1) do |sort, i|
        @point = Point.find_by(course_id: @course.id, number: sort)
        @points_new.push(@point)
      end
      @points_new.each.with_index(1) do |point, i|
        point.update(number: i)
      end
    end

    redirect_to "/seeks/course/#{@course.id}", notice: "コースを編集しました" 
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(title: params[:title], description: params[:description], city: params[:city], time_start: params[:time_start], time_end: params[:time_end])
      redirect_to "/seeks/course/#{@course.id}", notice: "コース情報を編集しました" 
    else
      redirect_to "/seeks/course/#{@course.id}", error: "コース情報の編集に失敗しました" 
    end
  end

  def destroy
    @course = Course.find(params[:id])
    if @course.destroy
      redirect_to user_path(current_user), notice: "コースを削除しました" 
    else
      redirect_to user_path(current_user), error: "削除に失敗しました" 
    end
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

    @ss_first = @ss.first
    @ss_last = @ss.last
    @spot_first = Spot.find(@ss_first)
    @spot_last = Spot.find(@ss_last)

    @total_min = 0
    @total_max = 0

    @ss.each.with_index(1) do |s, i|
      spot = Spot.find(s)

      if spot.price_lunch.blank? || spot.price_lunch == 0
        if spot.price_dinner.blank? || spot.price_lunch == 0
          @price_1 = 0
          @price_2 = 0
        else
          @price_1 = spot.price_dinner
          @price_2 = spot.price_dinner
        end
      else
        if spot.price_dinner.blank? || spot.price_lunch == 0
          @price_1 = spot.price_lunch
          @price_2 = spot.price_lunch
        else
          @price_1 = spot.price_lunch
          @price_2 = spot.price_dinner
        end
      end

      unless @price_1.blank?
        unless  @price_2.blank?
          @total_min = @total_min + @price_1
          @total_max = @total_max + @price_2
        end
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
    @url = @url.to_s + '/seeks/result?'
    params[:ss].each.with_index(1) do |s, i|
      @url = @url.to_s + "&ss%5B%5D=#{s}"
    end
    @url = @url.to_s + "&timezone=#{@timezone}"


  end

  def resultsave

    @ss_first = @ss.first
    @ss_last = @ss.last
    @spot_first = Spot.find(@ss_first)
    @spot_last = Spot.find(@ss_last)

    @total_min = 0
    @total_max = 0

    @ss.each.with_index(1) do |s, i|
      spot = Spot.find(s)

      if spot.price_lunch.blank? || spot.price_lunch == 0
        if spot.price_dinner.blank? || spot.price_lunch == 0
          @price_1 = 0
          @price_2 = 0
        else
          @price_1 = spot.price_dinner
          @price_2 = spot.price_dinner
        end
      else
        if spot.price_dinner.blank? || spot.price_lunch == 0
          @price_1 = spot.price_lunch
          @price_2 = spot.price_lunch
        else
          @price_1 = spot.price_lunch
          @price_2 = spot.price_dinner
        end
      end

      unless @price_1.blank?
        unless  @price_2.blank?
          @total_min = @total_min + @price_1
          @total_max = @total_max + @price_2
        end
      end

    end

    if params[:timezone] == "noon"
      @timezone_ja = "昼"
    end
    if params[:timezone] == "night"
      @timezone_ja = "夜"
    end

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