class CoursesController < ApplicationController


  def search
  end

  def result
  	    @spot1 = Spot.where(city: params[:city], large: "レストラン", price: params[:price]).order("RANDOM()").first
  	    @pictures1 = @spot1.pictures

    	if params[:large].to_i == 1
    		@spot2 = Spot.where(city: params[:city], large: "バー").order("RANDOM()").first
    		@pictures2 = @spot2.pictures
    	end
    	if params[:large].to_i == 2
    		@spot2 = Spot.where(city: params[:city], large: "カフェ").order("RANDOM()").first
    		@pictures2 = @spot2.pictures
    	end
    	if params[:large].to_i == 3
    		@spot2 = Spot.where(city: params[:city], large: "アクティブ").order("RANDOM()").first
    		@pictures2 = @spot2.pictures
    	end
    	if params[:large].to_i == 4
    		@spot2 = Spot.where(city: params[:city], large: "夜景").order("RANDOM()").first
    		@pictures2 = @spot2.pictures
    	end
    	if params[:large].to_i == 5
    		@spot2 = Spot.where(city: params[:city], large: "").order("RANDOM()").first
    		@pictures2 = @spot2.pictures
    	end
  end

  
end
