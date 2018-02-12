class DemosController < ApplicationController


  def search
  end

  def search1
  end

  def dinner
  	@n = 0
  	@spots = Spot.where("large like '%ディナー%'")
    @price_start = params[:price_dinner].to_i - 1999
    @price_end = params[:price_dinner].to_i
    if params[:small_dinner] == "指定しない"
   	  @spots = @spots.where(city: params[:city_dinner], price_dinner: @price_start..@price_end).order("RANDOM()").limit(2)
    else
      @small = params[:small_dinner]
      @spots = Spot.where("small like '%#{@small}%'")
      @spots = @spots.where(city: params[:city_dinner], price_dinner: @price_start..@price_end).order("RANDOM()").limit(2)
    end
  end

  def search3
  end

  def search2
  	@n = 0
  	@large = params[:large]
  	@spot1 = Spot.find(params[:spot1])
  	if @spot1
	    @pictures1 = @spot1.pictures.order(id: "ASC")
	  	@spots = Spot.where.not(title: @spot1.title)
      @spots = @spots.near([@spot1.latitude, @spot1.longitude], params[:distance].to_f, :units => :km, :order => false)
	  	if params[:large] == "おまかせ"
        @spots = @spots.where("large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?", "%バー%", "%夜カフェ%", "%夜景%", "%夜アクティブ%", "%その他%").order("RANDOM()").limit(2)
      else
        @spots = @spots.where("large like '%#{@large}%'").order("RANDOM()").limit(2)
      end
	  end

  	if params[:large] == "２軒目なし"
      flash.now[:notice] = "コースが作成されました"
  		render :action => "result"
  	else
  		render :action => "second"
  	end
  end

  def second
    @n2000 = false
    @n4000 = false
    @n6000 = false
    @n8000 = false
    if !params[:price_second].blank?
      if params[:price_second].to_i == 2000
        @n2000 = true
      end
      if params[:price_second].to_i == 4000
        @n4000 = true
      end
      if params[:price_second].to_i == 6000
        @n6000 = true
      end
      if params[:price_second].to_i == 8000
        @n8000 = true
      end
    end

    @n1 = false
    @n08 = false
    @n05 = false
    @n02 = false
    @n01 = false
    if !params[:distance].blank?
      if params[:distance].to_f == 1
        @n1 = true
      end
      if params[:distance].to_f == 0.8
        @n08 = true
      end
      if params[:distance].to_f == 0.5
        @n05 = true
      end
      if params[:distance].to_f == 0.2
        @n02 = true
      end
      if params[:distance].to_f == 0.1
        @n01 = true
      end
    end

  	@n = 0
  	@large = params[:large]
  	@spot1 = Spot.find(params[:spot1])
  	@spots = Spot.where.not(title: @spot1.title)
    @spots = @spots.near([@spot1.latitude, @spot1.longitude], params[:distance].to_f, :units => :km, :order => false)
    if params[:large] == "おまかせ"
      @spots = @spots.where("large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?", "%バー%", "%夜カフェ%", "%夜景%", "%夜アクティブ%", "%その他%").order("RANDOM()").limit(2)
    else
      @spots = @spots.where("large like '%#{@large}%'").order("RANDOM()").limit(2)
    end
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
      @distance = Geocoder::Calculations.distance_between([@spot1.latitude,@spot1.longitude], [@spot2.latitude,@spot2.longitude], :units => :km)
      @distance = @distance.to_f.round(4) * 1000
      @distance = @distance.to_i
		end
    end
  end

  def change1
    @n = 0
    @large = params[:large]
    @spot1 = Spot.find(params[:spot1])
    @spots = Spot.where.not(title: @spot1.title)
    @spots = @spots.where("large like '%ディナー%'")
    @spots = @spots.where(station: @spot1.station, price: @spot1.price).order("RANDOM()").limit(2)

    if !params[:spot2].blank?
      @spot2 = Spot.find(params[:spot2])
    end
  end

  def change2
    @n = 0
    @large = params[:large]
    @spot1 = Spot.find(params[:spot1])
    @spot2 = Spot.find(params[:spot2])
    @spots = Spot.where.not(title: @spot2.title)
    @spots = @spots.near([@spot1.latitude, @spot1.longitude], params[:distance].to_f, :units => :km, :order => false)
    @spots = @spots.where("large like '%#{@large}%'")
    @spots = @spots.where(station: @spot2.station).order("RANDOM()").limit(2)

  end










  def lunchsearch1
  end

  def lunch
    @n = 0
    @spots = Spot.where("large like '%ランチ%'")
    @price_start = params[:price_lunch].to_i - 999
    @price_end = params[:price_lunch].to_i
    if params[:small_lunch] == "指定しない"
      @spots = @spots.where(city: params[:city_lunch], price_lunch: @price_start..@price_end).order("RANDOM()").limit(2)
    else
      @small = params[:small_lunch]
      @spots = Spot.where("small like '%#{@small}%'")
      @spots = @spots.where(city: params[:city_lunch], price_lunch: @price_start..@price_end).order("RANDOM()").limit(2)
    end
  end

  def lunchsearch3
  end

  def lunchsearch2
    @n = 0
    @large = params[:large_second]
    @spot1 = Spot.find(params[:spot1])
    if @spot1
      @pictures1 = @spot1.pictures.order(id: "ASC")
      @spots = Spot.where.not(title: @spot1.title)
      @spots = @spots.near([@spot1.latitude, @spot1.longitude], params[:distance_second].to_f, :units => :km, :order => false)
      if params[:large_second] == "おまかせ"
        @spots = @spots.where("large LIKE ? OR large LIKE ?OR large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?", "%昼カフェ%", "%公園%", "%ミュージアム%", "%ショップ%", "%昼アクティブ%", "%その他%").order("RANDOM()").limit(2)
      else
        @spots = @spots.where("large like '%#{@large}%'").order("RANDOM()").limit(2)
      end
    end

    if params[:large_second] == "２軒目なし"
      flash.now[:notice] = "コースが作成されました"
      render :action => "lunchresult"
    else
      render :action => "lunchsecond"
    end
  end

  def lunchsecond
    @n1000 = false
    @n2000 = false
    @n3000 = false
    @n4000 = false
    @n5000 = false
    if !params[:price_second].blank?
      if params[:price_second].to_i == 1000
        @n1000 = true
      end
      if params[:price_second].to_i == 2000
        @n2000 = true
      end
      if params[:price_second].to_i == 3000
        @n3000 = true
      end
      if params[:price_second].to_i == 4000
        @n4000 = true
      end
      if params[:price_second].to_i == 5000
        @n5000 = true
      end
    end

    @n1 = false
    @n08 = false
    @n05 = false
    @n02 = false
    @n01 = false
    if !params[:distance_second].blank?
      if params[:distance_second].to_f == 1
        @n1 = true
      end
      if params[:distance_second].to_f == 0.8
        @n08 = true
      end
      if params[:distance_second].to_f == 0.5
        @n05 = true
      end
      if params[:distance_second].to_f == 0.2
        @n02 = true
      end
      if params[:distance_second].to_f == 0.1
        @n01 = true
      end
    end

    @n = 0
    @large = params[:large_second]
    @spot1 = Spot.find(params[:spot1])
    @spots = Spot.where.not(title: @spot1.title)
    @spots = @spots.near([@spot1.latitude, @spot1.longitude], params[:distance_second].to_f, :units => :km, :order => false)
    if params[:large_second] == "おまかせ"
      @spots = @spots.where("large LIKE ? OR large LIKE ?OR large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?", "%昼カフェ%", "%公園%", "%ミュージアム%", "%ショップ%", "%昼アクティブ%", "%その他%").order("RANDOM()").limit(2)
    else
      @spots = @spots.where("large like '%#{@large}%'").order("RANDOM()").limit(2)
    end
  end

  def lunchsearch4
  end

  def lunchsearch5
    @n = 0
    @large = params[:large_third]
    @spot1 = Spot.find(params[:spot1])
    if @spot1
      @pictures1 = @spot1.pictures.order(id: "ASC")
    end
    @spot2 = Spot.find(params[:spot2])
    if @spot2
      @pictures2 = @spot2.pictures.order(id: "ASC")
    end
    @spot1 = Spot.find(params[:spot1])
    @spot2 = Spot.find(params[:spot2])
    @spots = Spot.where.not(title: @spot1.title)
    @spots = @spots.where.not(title: @spot2.title)
    @spots = @spots.near([@spot2.latitude, @spot2.longitude], params[:distance_third].to_f, :units => :km, :order => false)
    if params[:large_third] == "おまかせ"
      @spots = @spots.where("large LIKE ? OR large LIKE ?OR large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?", "%昼カフェ%", "%公園%", "%ミュージアム%", "%ショップ%", "%昼アクティブ%", "%その他%").order("RANDOM()").limit(2)
    else
      @spots = @spots.where("large like '%#{@large}%'").order("RANDOM()").limit(2)
    end
    

    if params[:large_third] == "３軒目なし"
      flash.now[:notice] = "コースが作成されました"
      render :action => "lunchresult"
    else
      render :action => "lunchthird"
    end
  end

  def lunchthird
    @n1000 = false
    @n2000 = false
    @n3000 = false
    @n4000 = false
    @n5000 = false
    if !params[:price_third].blank?
      if params[:price_third].to_i == 1000
        @n1000 = true
      end
      if params[:price_third].to_i == 2000
        @n2000 = true
      end
      if params[:price_third].to_i == 3000
        @n3000 = true
      end
      if params[:price_third].to_i == 4000
        @n4000 = true
      end
      if params[:price_third].to_i == 5000
        @n5000 = true
      end
    end

    @n1 = false
    @n08 = false
    @n05 = false
    @n02 = false
    @n01 = false
    if !params[:distance_third].blank?
      if params[:distance_third].to_f == 1
        @n1 = true
      end
      if params[:distance_third].to_f == 0.8
        @n08 = true
      end
      if params[:distance_third].to_f == 0.5
        @n05 = true
      end
      if params[:distance_third].to_f == 0.2
        @n02 = true
      end
      if params[:distance_third].to_f == 0.1
        @n01 = true
      end
    end

    @n = 0
    @large = params[:large_third]
    @spot1 = Spot.find(params[:spot1])
    @spot2 = Spot.find(params[:spot2])
    @spots = Spot.where.not(title: @spot1.title)
    @spots = @spots.where.not(title: @spot2.title)
    @spots = @spots.near([@spot2.latitude, @spot2.longitude], params[:distance_third].to_f, :units => :km, :order => false)
    if params[:large_third] == "おまかせ"
      @spots = @spots.where("large LIKE ? OR large LIKE ?OR large LIKE ? OR large LIKE ? OR large LIKE ? OR large LIKE ?", "%昼カフェ%", "%公園%", "%ミュージアム%", "%ショップ%", "%昼アクティブ%", "%その他%").order("RANDOM()").limit(2)
    else
      @spots = @spots.where("large like '%#{@large}%'").order("RANDOM()").limit(2)
    end
  end



  def lunchresult
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






































  
end
