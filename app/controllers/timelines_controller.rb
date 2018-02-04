class TimelinesController < ApplicationController

	def index
	    @timelines = Timeline.order('id DESC')
	end

	def search

	    if !params[:city_dinner].blank? && !params[:price_dinner].blank? && !params[:small_dinner].blank?
	    	@timelines = Timeline.where(city_dinner: params[:city_dinner], price_dinner: @price_start..@price_end, small_dinner: params[:small_dinner]).order(id: "DESC")
	    end
	    if params[:city_dinner].blank?
	    	if  !params[:price_dinner].blank? && !params[:small_dinner].blank?
	    		@timelines = Timeline.where(price_dinner: params[:price_dinner], small_dinner: params[:small_dinner]).order(id: "DESC")
	    	end
	    	if params[:price_dinner].blank? && !params[:small_dinner].blank?
	    		@timelines = Timeline.where(small_dinner: params[:small_dinner]).order(id: "DESC")
	    	end
	    	if !params[:price_dinner].blank? && params[:small_dinner].blank?
	    		@timelines = Timeline.where(price_dinner: params[:price_dinner]).order(id: "DESC")
	    	end
	    end
	    if params[:price_dinner].blank?
	    	if  !params[:city_dinner].blank? && !params[:small_dinner].blank?
	    		@timelines = Timeline.where(city_dinner: params[:city_dinner], small_dinner: params[:small_dinner]).order(id: "DESC")
	    	end
	    	if  params[:city_dinner].blank? && !params[:small_dinner].blank?
	    		@timelines = Timeline.where(small_dinner: params[:small_dinner]).order(id: "DESC")
	    	end
	    	if  !params[:city_dinner].blank? && params[:small_dinner].blank?
	    		@timelines = Timeline.where(city_dinner: params[:city_dinner]).order(id: "DESC")
	    	end
	    end
	    if params[:small_dinner].blank?
	    	if !params[:city_dinner].blank? && !params[:price_dinner].blank?
	    		@timelines = Timeline.where(city_dinner: params[:city_dinner], price_dinner: params[:price_dinner]).order(id: "DESC")
	    	end
	    	if params[:city_dinner].blank? && !params[:price_dinner].blank?
	    		@timelines = Timeline.where(price_dinner: params[:price_dinner]).order(id: "DESC")
	    	end
	    	if !params[:city_dinner].blank? && params[:price_dinner].blank?
	    		@timelines = Timeline.where(city_dinner: params[:city_dinner]).order(id: "DESC")
	    	end
	    end
	    if params[:city_dinner].blank? && params[:price_dinner].blank? && params[:small_dinner].blank?
	    	@timelines = Timeline.order('id DESC')
	    end

	end

	def show
		@n = 0
		@i = 0
		@timeline = Timeline.find(params[:id])
    	@course = Course.find(@timeline.course_id)
    	@points = Point.where(course_id: @course.id).order(id: "ASC")	
	end

	def copy
    if !params[:spot1_id].blank?
        @course = Course.new(user_id: current_user.id, title: params[:title])
          if @course.save
            @point1 = Point.new(spot_id: params[:spot1_id].to_i, course_id: @course.id)
            if params[:spot2_id].blank?
	            if @point1.save
	            	@copy = Copy.new(user_id: current_user.id, course_id: params[:course_id].to_i)
	            	@copy.save
	                redirect_to course_path(@course), notice: "コースを複製しました" #保存完了
	            else
	              redirect_back(fallback_location: root_path) #ポイント1が保存できなかった
	            end
	        else
	        	if @point1.save
	                @point2 = Point.new(spot_id: params[:spot2_id].to_i, course_id: @course.id)
	                if params[:spot3_id].blank?
			            if @point2.save
			            	@copy = Copy.new(user_id: current_user.id, course_id: params[:course_id].to_i)
	            			@copy.save
			                redirect_to course_path(@course), notice: "コースを複製しました" #保存完了
			            else
			              redirect_back(fallback_location: root_path) #ポイント2が保存できなかった
			            end
			        else
			        	if @point2.save
			                @point3 = Point.new(spot_id: params[:spot3_id].to_i, course_id: @course.id)
			                if params[:spot4_id].blank?
					            if @point3.save
					            	@copy = Copy.new(user_id: current_user.id, course_id: params[:course_id].to_i)
	            					@copy.save
					                redirect_to course_path(@course), notice: "コースを複製しました" #保存完了
					            else
					              redirect_back(fallback_location: root_path) #ポイント3が保存できなかった
					            end
					        else
					        	if @point3.save
					                @point4 = Point.new(spot_id: params[:spot4_id].to_i, course_id: @course.id)
					                if params[:spot5_id].blank?
							            if @point4.save
							            	@copy = Copy.new(user_id: current_user.id, course_id: params[:course_id].to_i)
	            							@copy.save
							                redirect_to course_path(@course), notice: "コースを複製しました" #保存完了
							            else
							              redirect_back(fallback_location: root_path) #ポイント4が保存できなかった
							            end
							        else
							        	if @point4.save
							                @point5 = Point.new(spot_id: params[:spot5_id].to_i, course_id: @course.id)
							                if params[:spot6_id].blank?
									            if @point5.save
									                redirect_to course_path(@course), notice: "コースを複製しました" #保存完了
									            else
									              redirect_back(fallback_location: root_path) #ポイント5が保存できなかった
									            end
									        else
									        	if @point5.save
									        		@copy = Copy.new(user_id: current_user.id, course_id: params[:course_id].to_i)
	            									@copy.save
									                @point6 = Point.new(spot_id: params[:spot6_id].to_i, course_id: @course.id)
										            if @point6.save
										            	@copy = Copy.new(user_id: current_user.id, course_id: params[:course_id].to_i)
	            										@copy.save
										                redirect_to course_path(@course), notice: "コースを複製しました" #保存完了
										            else
										              redirect_back(fallback_location: root_path) #ポイント6が保存できなかった
										            end
									            else
									              redirect_back(fallback_location: root_path) #ポイント5が保存できなかった
									            end
									        end
							            else
							              redirect_back(fallback_location: root_path) #ポイント4が保存できなかった
							            end
							        end
					            else
					              redirect_back(fallback_location: root_path) #ポイント3が保存できなかった
					            end
					        end
			            else
			              redirect_back(fallback_location: root_path) #ポイント2が保存できなかった
			            end
			        end
	            else
	              redirect_back(fallback_location: root_path) #ポイント1が保存できなかった
	            end
	        end
          else
            redirect_back(fallback_location: root_path) #コースが保存できなっかた
          end
    end
  	end

end



