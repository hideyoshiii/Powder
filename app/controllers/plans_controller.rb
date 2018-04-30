class PlansController < ApplicationController

def home
end

def sean
end

def course
	@course =  Course.find(params[:id])
    @points = Point.where(course_id: @course.id).order(number: "ASC")

    @ss =[]
    unless @points.size == 0
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
    end

    #ツイート用のURL作成
    @url = url_for(only_path: false)
end

def personal	
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

def area	
end

def timezone	
end

def budget	
end

def scene
end

def terms
end


def result   
   #再検索用の定義
   @timezone_lunch = false
   @timezone_night = false
    unless params[:timezone].blank?
      if params[:timezone] == "noon"
        @timezone_lunch = true
      end
      if params[:timezone] == "night"
        @timezone_night = true
      end
    end
    @budget_one = false
    @budget_two = false
    @budget_three = false
    unless params[:budget].blank?
      if params[:budget] == "1"
        @budget_one = true
      end
      if params[:budget] == "2"
        @budget_two = true
      end
      if params[:budget] == "3"
        @budget_three = true
      end
    end
    @scene_cool = false
    @scene_casual = false
    @scene_unique = false
    unless params[:scene].blank?
      if params[:scene] == "クール"
        @scene_cool = true
      end
      if params[:scene] == "カジュアル"
        @scene_casual = true
      end
      if params[:scene] == "ユニーク"
        @scene_unique = true
      end
    end
   #@spotsを定義
   @spots = Spot.all
   #@latitudeがない物を排除
   @spots = @spots.where.not(latitude: nil)
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
   #距離定義
   @distance = 0.5.to_f
   #昼のカテゴリー定義
   if params[:scene] == "クール"
    @noons = ["映画", "プラネタリウム", "動物園", "水族館", "美術館", "ダーツ", "スパ・温泉", "体験", "ストリート", "複合施設"]
   end
   if params[:scene] == "カジュアル"
    @noons = ["映画", "ショップ・雑貨屋", "スポーツ", "動物園", "水族館", "遊園地", "カラオケ", "ボーリング", "食べ歩き", "公園", "ゲームセンター", "体験", "ストリート", "複合施設"]
   end
   if params[:scene] == "ユニーク"
    @noons = ["アニマルカフェ", "ショップ・雑貨屋", "スポーツ", "プラネタリウム", "動物園", "水族館", "美術館", "遊園地", "食べ歩き", "スパ・温泉", "ゲームセンター", "お寺・神社", "劇場", "インターネットカフェ", "コンセプトカフェ・バー", "体験", "その他"]
   end
   @noons_not = ["カフェ","バー", "夜景"]
   #夜のカテゴリー定義
   if params[:scene] == "クール"
    @nights = ["バー", "夜景"]
   end
   if params[:scene] == "カジュアル"
    @nights = ["カフェ", "夜景"]
   end
   if params[:scene] == "ユニーク"
    @nights = ["夜景", "カラオケ", "ボーリング", "ダーツ", "その他", "カフェ"]
   end
   @nights_not = ["アニマルカフェ", "映画", "ショップ・雑貨屋", "スポーツ", "プラネタリウム", "動物園", "水族館", "美術館", "遊園地", "食べ歩き", "スパ・温泉", "ゲームセンター", "お寺・神社", "劇場", "コンセプトカフェ・バー", "体験", "ストリート", "複合施設", "その他"]
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
    @spot2_category_2 = @spot2_timezone
    @spot2_category = @spot2_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    if @spot2_category.blank?
      @noons_not.each.with_index(1) do |noon, i|
        @spot2_category = @spot2_category_2.where.not("large like '%#{noon}%'")
      end
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
    @spot3_category_2 = @spot3_timezone
    @spot3_category = @spot3_category.where(
      @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@noons.map { |attr| "%#{attr}%" }
      )
    if @spot3_category.blank?
      @noons_not.each.with_index(1) do |noon, i|
        @spot3_category = @spot3_category_2.where.not("large like '%#{noon}%'")
      end
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
    @spot5_category_2 = @spot5_timezone
    @spot5_category = @spot5_category.where(
      @nights.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
      *@nights.map { |attr| "%#{attr}%" }
      )
    if @spot5_category.blank?
      @nights_not.each.with_index(1) do |night, i|
        @spot5_category = @spot5_category_2.where.not("large like '%#{night}%'")
      end
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

    #料金２
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


  def plan
  	#@ssを定義
  	@ss = []
  	@ss = params[:ss]
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

    #料金２
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

  end



end