class CoursesController < ApplicationController


  def search
  end

  def result
        @spot11 = Spot.where("scenes like '%ディナー%'")
  	    @spot1 = @spot11.where(city: params[:city], price: params[:price]).order("RANDOM()").first
  	    if @spot1
  	    	@pictures1 = @spot1.pictures.order(id: "ASC")
          @spot21 = Spot.where.not(title: @spot1.title)

        	if params[:large].to_i == 1
            @spot22 = @spot21.where("scenes like '%バー%'")
        		@spot2 = @spot22.where(station: @spot1.station).order("RANDOM()").first
        		if @spot2
        			@pictures2 = @spot2.pictures.order(id: "ASC")
        		end
        	end
        	if params[:large].to_i == 2
            @spot22 = @spot21.where("scenes like '%カフェ%'")
            @spot2 = @spot22.where(station: @spot1.station).order("RANDOM()").first
        		if @spot2
        			@pictures2 = @spot2.pictures.order(id: "ASC")
        		end
        	end

        end
  end

  
end
