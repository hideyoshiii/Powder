class PlansController < ApplicationController

def home
end

def theme
end

def spots
  #@spotsを定義
  @spots = Spot.all
  #@latitudeがない物を排除
  @spots = @spots.where.not(latitude: nil)
  #@スポットを10個に限定
  @spots = @spots.where(prefecture: "東京").order("RANDOM()").page(params[:page]).per(20)
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
     @price_endz = 4000
     @price_min = 0
     @price_max = 3000
   end
   if params[:budget] == "2"
     @price_start = 0
     @price_end = 2000
     @price_startz = 4001
     @price_endz = 8000
     @price_min = 0
     @price_max = 5000
   end
   if params[:budget] == "3"
     @price_start = 1001
     @price_end = 6000
     @price_startz = 8001
     @price_endz = 50000
     @price_min = 0
     @price_max = 50000
   end
   #距離定義
   @distance = 0.5.to_f
   #昼のカテゴリー定義
   @noons = ["アニマルカフェ", "映画", "ショップ・雑貨屋", "スポーツ", "プラネタリウム", "ボーリング", "公園", "動物園", "水族館", "美術館", "遊園地", "食べ歩き", "スパ・温泉", "ゲームセンター", "お寺・神社", "劇場", "コンセプトカフェ・バー", "体験", "ストリート", "複合施設", "その他"]
   #夜のカテゴリー定義
   @nights = ["カフェ","バー", "夜景", "ダーツ", "カラオケ", "公園"]

#お任せサーチ
if params[:rely] == "true"
   #時間帯定義
   params[:timezone] = "noon"
   #スポット１(ランチ)
    @spot1_category = @spots.where("large like '%ランチ%'")
    @spot1_price = @spot1_category.where(price_lunch: 0..2000)
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
    @spot4_price = @spot4_category.where(price_dinner: 0..8000)
    @spot4_distance = @spot4_price.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    until @spot4_distance.size >= 1 do
      @distance = @distance.to_f + 0.2.to_f
      @spot4_distance = @spot4_price.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    end
    @spot4 = @spot4_distance.order("RANDOM()").first
    #スポット５
    @spot5_not = @spots.where.not(title: @spot1.title)
    @spot5_not = @spot5_not.where.not(title: @spot2.title)
    @spot5_not = @spot5_not.where.not(title: @spot3.title)
    @spot5_not = @spot5_not.where.not(title: @spot4title)
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

#駅サーチ
unless params[:station].blank?

  @distance_station = 1.5.to_f

  #駅の緯度軽度を定義
  @station = params[:station]
  if @station == "恵比寿"
    @station_l = [35.647232, 139.70929]
  end
  if @station == "代官山"
    @station_l = [35.648043, 139.703084]
  end
  if @station == "中目黒"
    @station_l = [35.64431, 139.699116]
  end
  if @station == "渋谷"
    @station_l = [35.658034, 139.701636]
  end
  if @station == "原宿"
    @station_l = [35.670229, 139.702698]
  end
  if @station == "表参道・青山"
    @station_l = [35.665251, 139.712092]
  end
  if @station == "東京・丸の内・日本橋"
    @station_l = [35.681167, 139.767052]
  end
  if @station == "新宿"
    @station_l = [35.689592, 139.700413]
  end
  if @station == "六本木"
    @station_l = [35.662866, 139.731507]
  end
  if @station == "麻布"
    @station_l = [35.656134, 139.736881]
  end
  if @station == "お台場"
    @station_l = [35.628836, 139.777649]
  end
  if @station == "品川"
    @station_l = [35.628471, 139.73876]
  end
  if @station == "池袋"
    @station_l = [35.729503, 139.7109]
  end
  if @station == "銀座"
    @station_l = [35.671752, 139.764308]
  end
  if @station == "汐留・新橋"
    @station_l = [35.662899, 139.75997]
  end
  if @station == "上野"
    @station_l = [35.712364, 139.776188]
  end
  if @station == "浅草"
    @station_l = [35.710711, 139.797676]
  end
  if @station == "押上"
    @station_l = [35.710332, 139.813297]
  end
  if @station == "目黒"
    @station_l = [35.633913, 139.715556]
  end
  if @station == "吉祥寺"
    @station_l = [35.703149, 139.579809]
  end
  if @station == "神楽坂"
    @station_l = [35.703819, 139.734518]
  end
  if @station == "下北沢"
    @station_l = [35.661523, 139.666982]
  end
  if @station == "谷中・根津・千駄木"
    @station_l = [35.728158, 139.770641]
  end
  if @station == "赤坂"
    @station_l = [35.672212, 139.73638]
  end

  if @station == "自由が丘"
    @station_l = [35.60735, 139.668532]
  end
  if @station == "二子玉川"
    @station_l = [35.612417, 139.627567]
  end
  if @station == "中野"
    @station_l = [35.705407, 139.665825]
  end
  if @station == "立川"
    @station_l = [35.697914, 139.413741]
  end
  if @station == "巣鴨"
    @station_l = [35.733413, 139.739289]
  end
  if @station == "町田"
    @station_l = [35.541994, 139.445376]
  end

   #昼からの時
   if params[:timezone] == "noon"
    #スポット１(ランチ)
    @spot1_category = @spots.where("large like '%ランチ%'")
    @spot1_price = @spot1_category.where(price_lunch: @price_start..@price_end)
    @spot1_distance = @spot1_price.near(@station_l, @distance_station, :units => :km, :order => false)
    until @spot1_distance.size >= 1 do
      @distance_station = @distance_station + 0.5.to_f
      @spot1_distance = @spot1_price.near(@station_l, @distance_station, :units => :km, :order => false)
    end
    @spot1 = @spot1_distance.order("RANDOM()").first
    #スポット２
    @spot2_not = @spots.where.not(title: @spot1.title)
    @spot2_not_lunch = @spot2_not.where.not("large like '%ランチ%'")
    @spot2_timezone = @spot2_not_lunch.where("timezone like '%昼%'")
    @spot2_price = @spot2_timezone.where(price_lunch: @price_min..@price_max)
    @spot2_category = @spot2_price
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
    @spot3_price = @spot3_timezone.where(price_lunch: @price_min..@price_max)
    @spot3_category = @spot3_price
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
      @spot4_distance = @spot4_price.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    end
    @spot4 = @spot4_distance.order("RANDOM()").first
    #スポット５
    @spot5_not = @spots.where.not(title: @spot1.title)
    @spot5_not = @spot5_not.where.not(title: @spot2.title)
    @spot5_not = @spot5_not.where.not(title: @spot3.title)
    @spot5_not = @spot5_not.where.not(title: @spot4title)
    @spot5_not_lunch = @spot5_not.where.not("large like '%ディナー%'")
    @spot5_timezone = @spot5_not_lunch.where("timezone like '%夜%'")
    @spot5_price = @spot5_timezone.where(price_dinner: @price_min..@price_max)
    @spot5_category = @spot5_price
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
   #夜からの時
   if params[:timezone] == "night"
    #スポット１
    @spot1_category = @spots.where("large like '%ディナー%'")
    @spot1_price = @spot1_category.where(price_dinner: @price_startz..@price_endz)
    @spot1_distance = @spot1_price.near(@station_l, @distance_station, :units => :km, :order => false)
    until @spot1_distance.size >= 1 do
      @distance_station = @distance_station + 0.5.to_f
      @spot1_distance = @spot1_price.near(@station_l, @distance_station, :units => :km, :order => false)
    end
    @spot1 = @spot1_distance.order("RANDOM()").first
    #スポット２
    @spot2_not = @spots.where.not(title: @spot1.title)
    @spot2_not_lunch = @spot2_not.where.not("large like '%ディナー%'")
    @spot2_timezone = @spot2_not_lunch.where("timezone like '%夜%'")
    @spot2_price = @spot2_timezone.where(price_dinner: @price_min..@price_max)
    @spot2_category = @spot2_price
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

end

#エリアサーチ
unless params[:city].blank?

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
    @spot2_price = @spot2_timezone.where(price_lunch: @price_min..@price_max)
    @spot2_category = @spot2_price
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
    @spot3_price = @spot3_timezone.where(price_lunch: @price_min..@price_max)
    @spot3_category = @spot3_price
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
      @spot4_distance = @spot4_price.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
    end
    @spot4 = @spot4_distance.order("RANDOM()").first
    #スポット５
    @spot5_not = @spots.where.not(title: @spot1.title)
    @spot5_not = @spot5_not.where.not(title: @spot2.title)
    @spot5_not = @spot5_not.where.not(title: @spot3.title)
    @spot5_not = @spot5_not.where.not(title: @spot4title)
    @spot5_not_lunch = @spot5_not.where.not("large like '%ディナー%'")
    @spot5_timezone = @spot5_not_lunch.where("timezone like '%夜%'")
    @spot5_price = @spot5_timezone.where(price_dinner: @price_min..@price_max)
    @spot5_category = @spot5_price
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
    @spot2_price = @spot2_timezone.where(price_dinner: @price_min..@price_max)
    @spot2_category = @spot2_price
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

end

#テーマサーチ
unless params[:theme].blank?

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

   #美術館巡りデート
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
    unless @spot3_series.size == 0
      @spot3_same = @spot3_series.where("large like '%美術館%'")
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

   #雑貨屋巡りデート
   if params[:theme] == "雑貨屋巡り"
    #timezomeを定義
    params[:timezone] = "noon"
    #スポット２
    @spot2_category = @spots.where("large like '%ショップ・雑貨屋%'")
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
    unless @spot3_series.size == 0
      @spot3_same = @spot3_series.where("large like '%ショップ・雑貨屋%'")
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

   #お寺・神社巡りデート
   if params[:theme] == "お寺・神社巡り"
    #timezomeを定義
    params[:timezone] = "noon"
    #スポット２
    @spot2_category = @spots.where("large like '%お寺・神社%'")
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
    unless @spot3_series.size == 0
      @spot3_same = @spot3_series.where("large like '%お寺・神社%'")
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

   #プラネタリウムデート
   if params[:theme] == "プラネタリウム"
    #timezomeを定義
    params[:timezone] = "noon"
    #スポット２
    @spot2_category = @spots.where("large like '%プラネタリウム%'")
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

   #アクティブデート
   if params[:theme] == "アクティブ"
    #timezomeを定義
    params[:timezone] = "noon"
    #スポット２
    @spot2_category = @spots.where("large like '%スポーツ%'")
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

   #公園デート
   if params[:theme] == "公園"
    #timezomeを定義
    params[:timezone] = "noon"
    #スポット２
    @spot2_category = @spots.where("large like '%公園%'")
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

   #食べ歩きデート
   if params[:theme] == "食べ歩き"
    #timezomeを定義
    params[:timezone] = "noon"
    #スポット２
    @spot1_category = @spots.where("large like '%食べ歩き%'")
    @spot1 = @spot1_category.order("RANDOM()").first
    #スポット２
    @spot2_not = @spots.where.not(title: @spot1.title)
    @spot2_not_lunch = @spot2_not.where.not("large like '%ランチ%'")
    @spot2_timezone = @spot2_not_lunch.where("timezone like '%昼%'")
    @spot2_category = @spot2_timezone
    @spot2_series = @spot2_category.near([@spot1.latitude, @spot1.longitude], 0.70, :units => :km, :order => false)
    unless @spot2_series.size == 0
      @spot2_same = @spot2_series.where("large like '%食べ歩き%'")
      @spot2 = @spot2_same.order("RANDOM()").first
    end
    if @spot2.blank?
      @spot2_category = @spot2_category.where(
        @noons.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
        *@noons.map { |attr| "%#{attr}%" }
        )
      @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
      until @spot3_distance.size >= 1 do
        @distance = @distance + 0.2.to_f
        @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
      end
      @spot2 = @spot2_distance.order("RANDOM()").first
    end
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

end

#スポットサーチ
unless params[:spot].blank?

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

   #昼スポットの時
   if @noons.include?(@large)
    #スポット２
    @spot2 = @spot
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
    @spot1_price = @spot1_category.where(price_lunch: @price_start..@price_end)
    @spot1_distance = @spot1_price.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
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


  def plan
  	#@ssを定義
  	@ss = []
  	@ss = params[:ss]
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

  end



end