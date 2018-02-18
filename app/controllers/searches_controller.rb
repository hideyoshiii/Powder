class SearchesController < ApplicationController
	before_action :set_params, only: [:first, :second, :third]

def home
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
  	if !params[:price].blank?
	    if @large == "ディナー"
        @price_start = params[:price].to_i - 1999
        @price_end = params[:price].to_i
	    	@spots = @spots.where(price_dinner: @price_start..@price_end)
	    else
	    if @large == "ランチ"
        @price_start = params[:price].to_i - 999
        @price_end = params[:price].to_i
	    	@spots = @spots.where(price_lunch: @price_start..@price_end)
	    end
		end
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


end