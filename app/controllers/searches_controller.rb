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
	    @price_start = params[:price].to_i - 999
	    @price_end = params[:price].to_i
	    if @large == "ディナー"
	    	@spots = @spots.where(price_dinner: @price_start..@price_end)
	    else
		    if @large == "ランチ"
		    	@spots = @spots.where(price_lunch: @price_start..@price_end)
		    else
		    	@spots = @spots.where(price_spot: @price_start..@price_end)
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
  	@spots = @spots.where("large like '%#{@large}%'")
  	if !params[:price].blank?
	    @price_start = params[:price].to_i - 999
	    @price_end = params[:price].to_i
	    if @large == "ディナー"
	    	@spots = @spots.where(price_dinner: @price_start..@price_end)
	    else
		    if @large == "ランチ"
		    	@spots = @spots.where(price_lunch: @price_start..@price_end)
		    else
		    	@spots = @spots.where(price_spot: @price_start..@price_end)
		    end
		end
	end
    if !params[:small].blank?
      @small = params[:small]
      @spots = @spots.where("small like '%#{@small}%'")
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
  	@spots = @spots.where("large like '%#{@large}%'")
  	if !params[:price].blank?
	    @price_start = params[:price].to_i - 999
	    @price_end = params[:price].to_i
	    if @large == "ディナー"
	    	@spots = @spots.where(price_dinner: @price_start..@price_end)
	    else
		    if @large == "ランチ"
		    	@spots = @spots.where(price_lunch: @price_start..@price_end)
		    else
		    	@spots = @spots.where(price_spot: @price_start..@price_end)
		    end
		end
	end
    if !params[:small].blank?
      @small = params[:small]
      @spots = @spots.where("small like '%#{@small}%'")
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
  	@spots = @spots.where("large like '%#{@large}%'")
  	if !params[:price].blank?
	    @price_start = params[:price].to_i - 999
	    @price_end = params[:price].to_i
	    if @large == "ディナー"
	    	@spots = @spots.where(price_dinner: @price_start..@price_end)
	    else
		    if @large == "ランチ"
		    	@spots = @spots.where(price_lunch: @price_start..@price_end)
		    else
		    	@spots = @spots.where(price_spot: @price_start..@price_end)
		    end
		end
	end
    if !params[:small].blank?
      @small = params[:small]
      @spots = @spots.where("small like '%#{@small}%'")
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
  	@spots = @spots.where("large like '%#{@large}%'")
  	if !params[:price].blank?
	    @price_start = params[:price].to_i - 999
	    @price_end = params[:price].to_i
	    if @large == "ディナー"
	    	@spots = @spots.where(price_dinner: @price_start..@price_end)
	    else
		    if @large == "ランチ"
		    	@spots = @spots.where(price_lunch: @price_start..@price_end)
		    else
		    	@spots = @spots.where(price_spot: @price_start..@price_end)
		    end
		end
	end
    if !params[:small].blank?
      @small = params[:small]
      @spots = @spots.where("small like '%#{@small}%'")
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


  end


end