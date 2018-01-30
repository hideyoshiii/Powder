class DemosController < ApplicationController


  def search
  end

  def search1
  end

  def dinner
  	@n = 0
  	@spots = Spot.where("scenes like '%ディナー%'")
    if params[:small] == "指定しない"
   	  @spots = @spots.where(city: params[:city], price_dinner: -Float::INFINITY..params[:price].to_i).order("RANDOM()").limit(3)
    else
      @small = params[:small]
      @spots = Spot.where("small like '%@small%'")
      @spots = @spots.where(city: params[:city], price_dinner: -Float::INFINITY..params[:price].to_i).order("RANDOM()").limit(3)
    end
  end

  def search2
  	@n = 0
  	@scene = params[:large]
  	@spot1 = Spot.find(params[:spot1])
  	if @spot1
	    @pictures1 = @spot1.pictures.order(id: "ASC")
	  	@spots = Spot.where.not(title: @spot1.title)
	  	@spots = @spots.where("scenes like '%#{@scene}%'")
	  	@spots = @spots.where(station: @spot1.station).order("RANDOM()").limit(3)
	  end

  	if params[:large] == "２軒目なし"
  		render :action => "result"
  	else
  		render :action => "second"
  	end
  end

  def second
  	@n = 0
  	@scene = params[:large]
  	@spot1 = Spot.find(params[:spot1])
  	@spots = Spot.where.not(title: @spot1.title)
  	@spots = @spots.where("scenes like '%#{@scene}%'")
  	@spots = @spots.where(station: @spot1.station).order("RANDOM()").limit(3)
  end

  def result
    @word = "コース①"
    @spot1 = Spot.find(params[:spot1])
    if @spot1
	    @pictures1 = @spot1.pictures.order(id: "ASC")
	end
    if params[:spot2]
    	@spot2 = Spot.find(params[:spot2])
    	if @spot2
			@pictures2 = @spot2.pictures.order(id: "ASC")
		end
    end
  end

  def change1
    @n = 0
    @scene = params[:large]
    @spot1 = Spot.find(params[:spot1])
    @spots = Spot.where.not(title: @spot1.title)
    @spots = @spots.where("scenes like '%ディナー%'")
    @spots = @spots.where(station: @spot1.station, price: @spot1.price).order("RANDOM()").limit(3)

    if !params[:spot2].blank?
      @spot2 = Spot.find(params[:spot2])
    end
  end

  def change2
    @n = 0
    @scene = params[:large]
    @spot2 = Spot.find(params[:spot2])
    @spots = Spot.where.not(title: @spot2.title)
    @spots = @spots.where("scenes like '%#{@scene}%'")
    @spots = @spots.where(station: @spot2.station).order("RANDOM()").limit(3)

    if !params[:spot1].blank?
      @spot1 = Spot.find(params[:spot1])
    end
  end

  
end
