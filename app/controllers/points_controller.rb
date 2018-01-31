class PointsController < ApplicationController


	def new
		@course = Course.find(params[:id])
		@user = current_user
		@points = Point.where(course_id: @course.id)
  		@likes = Like.where(user_id: @user.id).order('id DESC')
        
  	end

  	def create
  		@course = Course.find(params[:id])
        @spot = Spot.find(params[:spot_id])
        @point = Point.new(spot_id: @spot.id, course_id: @course.id)
        if @point.save
              redirect_to edit_course_path(@course) #保存完了
            else
              redirect_back(fallback_location: root_path) #ポイント1が保存できなかった
            end
  	end

    def destroy
        @point = Point.find(params[:id])
        if @point.destroy
            redirect_back(fallback_location: root_path) 
        else
            redirect_back(fallback_location: root_path) 
        end
  	end

    def memo
      @point = Point.find(params[:id])
      @memo = @point.memo
    end

    def update
      @point = Point.find(params[:id])
      @course = Course.find(@point.course_id)
    if @point.update(memo: params[:memo])
      redirect_to course_path(@course)
    end
    end

end



