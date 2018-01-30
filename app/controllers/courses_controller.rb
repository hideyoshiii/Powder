class CoursesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]


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



  def create
    if !params[:spot1_id].blank?
      if params[:spot2_id].blank?
        @course = Course.new(user_id: current_user.id, spot1_id: params[:spot1_id].to_i, title: params[:title])
      else
        @course = Course.new(user_id: current_user.id, spot1_id: params[:spot1_id].to_i, spot2_id: params[:spot2_id].to_i, title: params[:title])
      end
    end

    if @course.save
      redirect_back(fallback_location: root_path) 
    else
      redirect_back(fallback_location: root_path) 
    end

  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_back(fallback_location: root_path) 
  end

  private
  def course_params
    params.require(:course).permit(:spot1_id, :spot2_id, :spot3_id, :spot4_id)
  end

  
end
