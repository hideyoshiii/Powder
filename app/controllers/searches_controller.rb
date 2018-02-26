class SearchesController < ApplicationController
	before_action :set_params, only: [:first, :second, :third, :middlesecond, :middlethird, :changefirst, :changesecond, :changethird]
  before_action :set_wday, only: [:first, :second, :third, :middlesecond, :middlethird, :changefirst, :changesecond, :changethird, :result]

def home
end

def timezone
end

def kind
end

def categoryfirst
end

def first
	@n = 0
	@timezone = params[:timezone]
  if @timezone == "昼"
	 @large = "ランチ"
  end
  if @timezone == "夜"
   @large = "ディナー"
  end
  	@spots = Spot.where("large like '%#{@large}%'")
  	@spots = @spots.where(city: params[:city])
    @price_start = params[:price_min].to_i
    @price_end = params[:price_max].to_i
    if @large == "ディナー"
    	@spots = @spots.where(price_dinner: @price_start..@price_end)
    end
    if @large == "ランチ"
    	@spots = @spots.where(price_lunch: @price_start..@price_end)
    end
    if !params[:small].blank?
      @small = params[:small]
      @spots = @spots.where("small like '%#{@small}%'")
    end
    @spots = @spots.order("RANDOM()").limit(2)
end

def categorysecond
end

def middlesecond
	@spot1 = Spot.find(params[:spot1])
    @spots = Spot.where.not(title: @spot1.title)

    if params[:city].blank?
      if !params[:distance].blank?
      	@distance = params[:distance].to_f / 1000
      	@spots = @spots.near([@spot1.latitude, @spot1.longitude], @distance.to_f, :units => :km, :order => false)
      end
    else
      @spots = @spots.where(city: params[:city])
    end

	@n = 0
	@timezone = params[:timezone]
	@large = params[:large]
	@spots = @spots.where("timezone like '%#{@timezone}%'")
  if @large == "おまかせ"
    @spots = @spots.where("large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?OR large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?", "%バー%", "%カフェ%", "%夜景%", "%公園%", "%ミュージアム%", "%ショップ%", "%アクティブ%", "%その他%")
  else
  	@spots = @spots.where("large like '%#{@large}%'")
  end

    @spots = @spots.order("RANDOM()").limit(2)

    if @spot1
      @pictures1 = @spot1.pictures.order(id: "ASC")
    end

    if params[:large] == "２軒目なし"
      flash.now[:notice] = "コースが作成されました"
      render :action => "result"
    else
      render :action => "second"
    end
end

def second

	@spot1 = Spot.find(params[:spot1])
    @spots = Spot.where.not(title: @spot1.title)
    
    if params[:city].blank?
      if !params[:distance].blank?
      	@distance = params[:distance].to_f / 1000
      	@spots = @spots.near([@spot1.latitude, @spot1.longitude], @distance.to_f, :units => :km, :order => false)
      end
    else
      @spots = @spots.where(city: params[:city])
    end

	@n = 0
	@timezone = params[:timezone]
	@large = params[:large]
	@spots = @spots.where("timezone like '%#{@timezone}%'")
  if @large == "おまかせ"
    @spots = @spots.where("large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?OR large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?", "%バー%", "%カフェ%", "%夜景%", "%公園%", "%ミュージアム%", "%ショップ%", "%アクティブ%", "%その他%")
  else
    @spots = @spots.where("large like '%#{@large}%'")
  end
  	

    @spots = @spots.order("RANDOM()").limit(2)

end

def categorythird
end

def middlethird

	@spot1 = Spot.find(params[:spot1])
    @spots = Spot.where.not(title: @spot1.title)
	@spot2 = Spot.find(params[:spot2])
    @spots = @spots.where.not(title: @spot2.title)

    if params[:city].blank?
      if !params[:distance].blank?
      	@distance = params[:distance].to_f / 1000
      	@spots = @spots.near([@spot2.latitude, @spot2.longitude], @distance.to_f, :units => :km, :order => false)
      end
    else
      @spots = @spots.where(city: params[:city])
    end

	@n = 0
	@timezone = params[:timezone]
	@large = params[:large]
	@spots = @spots.where("timezone like '%#{@timezone}%'")
  if @large == "おまかせ"
    @spots = @spots.where("large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?OR large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?", "%バー%", "%カフェ%", "%夜景%", "%公園%", "%ミュージアム%", "%ショップ%", "%アクティブ%", "%その他%")
  else
    @spots = @spots.where("large like '%#{@large}%'")
  end
  
    @spots = @spots.order("RANDOM()").limit(2)

    if @spot1
      @pictures1 = @spot1.pictures.order(id: "ASC")
    end
    if params[:spot2]
      @spot2 = Spot.find(params[:spot2])
      if @spot2
        @pictures2 = @spot2.pictures.order(id: "ASC")
        @distance_second = Geocoder::Calculations.distance_between([@spot1.latitude,@spot1.longitude], [@spot2.latitude,@spot2.longitude], :units => :km)
        @distance_second = @distance_second.to_f.round(4) * 1000
        @distance_second = @distance_second.to_i
      end
    end

    if params[:large] == "３軒目なし"
      flash.now[:notice] = "コースが作成されました"
      render :action => "result"
    else
      render :action => "third"
    end

end

def third

	@spot1 = Spot.find(params[:spot1])
    @spots = Spot.where.not(title: @spot1.title)
	@spot2 = Spot.find(params[:spot2])
    @spots = @spots.where.not(title: @spot2.title)

    if params[:city].blank?
      if !params[:distance].blank?
      	@distance = params[:distance].to_f / 1000
      	@spots = @spots.near([@spot2.latitude, @spot2.longitude], @distance.to_f, :units => :km, :order => false)
      end
    else
      @spots = @spots.where(city: params[:city])
    end

	@n = 0
	@timezone = params[:timezone]
	@large = params[:large]
	@spots = @spots.where("timezone like '%#{@timezone}%'")
  if @large == "おまかせ"
    @spots = @spots.where("large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?OR large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?", "%バー%", "%カフェ%", "%夜景%", "%公園%", "%ミュージアム%", "%ショップ%", "%アクティブ%", "%その他%")
  else
    @spots = @spots.where("large like '%#{@large}%'")
  end

  @spots = @spots.order("RANDOM()").limit(2)

end

def result

	flash.now[:notice] = "コースが作成されました"
    @spot1 = Spot.find(params[:spot1])
    if @spot1
      @pictures1 = @spot1.pictures.order(id: "ASC")
    end
    if params[:spot2]
      @spot2 = Spot.find(params[:spot2])
      if @spot2
        @pictures2 = @spot2.pictures.order(id: "ASC")
        @distance_second = Geocoder::Calculations.distance_between([@spot1.latitude,@spot1.longitude], [@spot2.latitude,@spot2.longitude], :units => :km)
        @distance_second = @distance_second.to_f.round(4) * 1000
        @distance_second = @distance_second.to_i
      end
    end
    if params[:spot3]
      @spot3 = Spot.find(params[:spot3])
      if @spot3
        @pictures3 = @spot3.pictures.order(id: "ASC")
        @distance_third = Geocoder::Calculations.distance_between([@spot2.latitude,@spot2.longitude], [@spot3.latitude,@spot3.longitude], :units => :km)
        @distance_third = @distance_third.to_f.round(4) * 1000
        @distance_third = @distance_third.to_i
      end
    end

    if @spot1.blank?
      @price = 0
    else
      if params[:timezone] == "昼"
        @price1 = @spot1.price_lunch
      end
      if params[:timezone] == "夜"
        @price1 = @spot1.price_dinner
      end
      if @price1.blank?
        @price1 = 0
      end
      if @spot2.blank?
        #スポットが１つの時の合計
        @price = @price1
      else
        if @spot2.large.include?('カフェ') || @spot2.large.include?('バー')
          if params[:timezone] == "昼"
            unless @spot2.price_lunch.blank?
              @price2 = @spot2.price_lunch
            end
          end
          if params[:timezone] == "夜"
            unless @spot2.price_dinner.blank?
              @price2 = @spot2.price_dinner
            end
          end
        else
          unless @spot2.price_spot.blank?
            @price2 = @spot2.price_spot  
          end
        end
        if @price2.blank?
          @price2 = 0
        end
        if @spot3.blank?
          #スポットが２つの時の合計
          @price = @price1 + @price2
        else
          if @spot3.large.include?('カフェ') || @spot3.large.include?('バー')
            if params[:timezone] == "昼"
              unless @spot3.price_lunch.blank?
                @price3 = @spot3.price_lunch
              end
            end
            if params[:timezone] == "夜"
              unless @spot3.price_dinner.blank?
                @price3 = @spot3.price_dinner
              end
            end
          else
            unless @spot3.price_spot.blank?
              @price3 = @spot3.price_spot  
            end
          end
          if @price3.blank?
            @price3 = 0
          end
          #スポットが３つの時の合計
          @price = @price1 + @price2 + @price3
        end
      end
    end

end

def changefirst
  @n = 0
  if params[:timezone] == "昼"
   @large = "ランチ"
  end
  if params[:timezone] == "夜"
   @large = "ディナー"
  end
  @spot1 = Spot.find(params[:spot1])
  @spots = Spot.where.not(title: @spot1.title)
  if !params[:spot2].blank?
    @spot2 = Spot.find(params[:spot2])
    @spots = @spots.where.not(title: @spot2.title)
  end
  if !params[:spot3].blank?
    @spot3 = Spot.find(params[:spot3])
    @spots = @spots.where.not(title: @spot3.title)
  end
  if params[:timezone] == "昼"
    @spots = @spots.where("large like '%ランチ%'")
  end
  if params[:timezone] == "夜"
    @spots = @spots.where("large like '%ディナー%'")
  end
  params[:city] = @spot1.city
  @spots = @spots.where(city: params[:city])
  if params[:price_min].blank?
    if @large == "ディナー"
    params[:price_min] = @spot1.price_dinner.to_i - 2000
    params[:price_max] = @spot1.price_dinner.to_i + 2000
    end
    if @large == "ランチ"
      params[:price_min] = @spot1.price_lunch.to_i - 1000
      params[:price_max] = @spot1.price_lunch.to_i + 1000
    end
  end
    @price_start = params[:price_min].to_i
    @price_end = params[:price_max].to_i
    if @large == "ディナー"
      @spots = @spots.where(price_dinner: @price_start..@price_end)
    end
    if @large == "ランチ"
      @spots = @spots.where(price_lunch: @price_start..@price_end)
    end
    if !params[:small].blank?
      @small = params[:small]
      @spots = @spots.where("small like '%#{@small}%'")
    end
  @spots = @spots.order("RANDOM()").limit(2)

end

def changesecond

  @n = 0
  @spot2 = Spot.find(params[:spot2])
  @spots = Spot.where.not(title: @spot2.title)
  if !params[:spot1].blank?
    @spot1 = Spot.find(params[:spot1])
    @spots = @spots.where.not(title: @spot1.title)
  end
  if !params[:spot3].blank?
    @spot3 = Spot.find(params[:spot3])
    @spots = @spots.where.not(title: @spot3.title)
  end

  if params[:city].blank?
    if params[:distance].blank?
      params[:distance] = 500
      @distance = params[:distance].to_f / 1000
      @spots = @spots.near([@spot1.latitude, @spot1.longitude], @distance.to_f, :units => :km, :order => false)
    else
      @distance = params[:distance].to_f / 1000
      @spots = @spots.near([@spot1.latitude, @spot1.longitude], @distance.to_f, :units => :km, :order => false)
    end
  else
    @spots = @spots.where(city: params[:city])
  end

  @timezone = params[:timezone]
  @spots = @spots.where("timezone like '%#{@timezone}%'")

  if params[:large].blank?
    params[:large] = "おまかせ"
  end
  @large = params[:large]

  if @large == "おまかせ"
    @spots = @spots.where("large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?OR large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?", "%バー%", "%カフェ%", "%夜景%", "%公園%", "%ミュージアム%", "%ショップ%", "%アクティブ%", "%その他%")
  else
    @spots = @spots.where("large like '%#{@large}%'")
  end

  
  @spots = @spots.order("RANDOM()").limit(2)

end

def changethird

  @n = 0
  @spot3 = Spot.find(params[:spot3])
  @spots = Spot.where.not(title: @spot3.title)
  if !params[:spot1].blank?
    @spot1 = Spot.find(params[:spot1])
    @spots = @spots.where.not(title: @spot1.title)
  end
  if !params[:spot2].blank?
    @spot2 = Spot.find(params[:spot2])
    @spots = @spots.where.not(title: @spot2.title)
  end

  if params[:city].blank?
    if params[:distance].blank?
      params[:distance] = 500
      @distance = params[:distance].to_f / 1000
      @spots = @spots.near([@spot2.latitude, @spot2.longitude], @distance.to_f, :units => :km, :order => false)
    else
      @distance = params[:distance].to_f / 1000
      @spots = @spots.near([@spot2.latitude, @spot2.longitude], @distance.to_f, :units => :km, :order => false)
    end
  else
    @spots = @spots.where(city: params[:city])
  end

  @timezone = params[:timezone]
  @spots = @spots.where("timezone like '%#{@timezone}%'")

  if params[:large].blank?
    params[:large] = "おまかせ"
  end
  @large = params[:large]

  if @large == "おまかせ"
    @spots = @spots.where("large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?OR large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?", "%バー%", "%カフェ%", "%夜景%", "%公園%", "%ミュージアム%", "%ショップ%", "%アクティブ%", "%その他%")
  else
    @spots = @spots.where("large like '%#{@large}%'")
  end

  
  @spots = @spots.order("RANDOM()").limit(2)


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

    @ebisu = false
    @shibuya = false
    @harajuku = false
    @shinjuku = false
    @tokyo = false
    @roppongi = false
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
    end

    @bar = false
    @cafe = false
    @active = false
    @night = false
    @park = false
    @museum = false
    @shop = false
    @walk = false
    @other = false
    if !params[:large].blank?
      if params[:large] == "バー"
        @bar = true
      end
      if params[:large] == "カフェ"
        @cafe = true
      end
      if params[:large] == "アクティブ"
        @active = true
      end
      if params[:large] == "夜景"
        @night = true
      end
      if params[:large] == "公園"
        @park = true
      end
      if params[:large] == "ミュージアム"
        @museum = true
      end
      if params[:large] == "ショップ"
        @shop = true
      end
      if params[:large] == "食べ歩き"
        @walk = true
      end
      if params[:large] == "その他"
        @other = true
      end
    end

  end

  def set_wday
    @wday = Date.today.wday
  end


end