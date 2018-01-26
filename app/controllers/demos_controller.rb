class DemosController < ApplicationController


  def search
  end

  def search1
  end

  def dinner
  	@spots = Spot.where("scenes like '%ディナー%'")
   	@spots = @spots.where(city: params[:city], price: params[:price]).order("RANDOM()").limit(3)
  end

  def search2
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
  	@scene = params[:large]
  	@spot1 = Spot.find(params[:spot1])
  	@spots = Spot.where.not(title: @spot1.title)
  	@spots = @spots.where("scenes like '%#{@scene}%'")
  	@spots = @spots.where(station: @spot1.station).order("RANDOM()").limit(3)
  end

  def result
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

  
end
