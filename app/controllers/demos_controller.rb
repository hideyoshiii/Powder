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
	  	@spots = @spots.where("large like '%#{@large}%'").order("RANDOM()").limit(2)
	  end

  	if params[:large] == "２軒目なし"
      flash.now[:notice] = "コースが作成されました"
  		render :action => "result"
  	else
  		render :action => "second"
  	end
  end

  def second
  	@n = 0
  	@large = params[:large]
  	@spot1 = Spot.find(params[:spot1])
  	@spots = Spot.where.not(title: @spot1.title)
    @spots = @spots.near([@spot1.latitude, @spot1.longitude], params[:distance].to_f, :units => :km, :order => false)
  	@spots = @spots.where("large like '%#{@large}%'").order("RANDOM()").limit(2)
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
      @distance = Geocoder::Calculations.distance_between([@spot1.latitude,@spot1.latitude], [@spot2.latitude,@spot2.latitude], :units => :km)* 1.5
      @distance = @distance.to_f.round(2)
      @time = @distance / 0.080
      @time = @time.round(0)
      @price = @spot1.price_dinner + @spot2.price_spot
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

  
end
