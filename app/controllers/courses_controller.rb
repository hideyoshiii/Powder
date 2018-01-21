class CoursesController < ApplicationController


  def search
  end

  def result
        @spot11 = Spot.where("scenes like '%ディナー%'")
  	    @spot1 = @spot11.where(city: params[:city], price: params[:price]).order("RANDOM()").first
  	    if @spot1
  	    	@pictures1 = @spot1.pictures
  	    end

    	if params[:large].to_i == 1
        @spot22 = Spot.where("scenes like '%バー%'")
    		@spot2 = @spot22.where(city: params[:city]).order("RANDOM()").first
        if @spot2 == @spot1
          @spot2 = @spot22.where(city: params[:city]).order("RANDOM()").first
        end
        if @spot2 == @spot1
          @spot2 = @spot22.where(city: params[:city]).order("RANDOM()").first
        end
    		if @spot2
    			@pictures2 = @spot2.pictures
    		end
    	end
    	if params[:large].to_i == 2
        @spot22 = Spot.where("scenes like '%カフェ%'")
        @spot2 = @spot22.where(city: params[:city]).order("RANDOM()").first
        if @spot2 == @spot1
          @spot2 = @spot22.where(city: params[:city]).order("RANDOM()").first
        end
        if @spot2 == @spot1
          @spot2 = @spot22.where(city: params[:city]).order("RANDOM()").first
        end
    		@spot2 = @spot22.where(city: params[:city]).order("RANDOM()").first
    		if @spot2
    			@pictures2 = @spot2.pictures
    		end
    	end
  end

  
end
