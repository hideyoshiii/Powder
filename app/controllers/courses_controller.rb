class CoursesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def index
      @courses = Course.where(release: true).order('id ASC')
  end

  def search99
    @ebisu = false
    @shibuya = false
    @harajuku = false
    @shinjuku = false
    if !params[:city].blank?
      if params[:city] == "恵比寿・代官山・中目黒"
        @ebisu = true
      end
      if params[:city] == "渋谷"
        @shibuya = true
      end
      if params[:city] == "原宿・表参道・青山"
        @harajuku = true
      end
      if params[:city] == "新宿"
        @shinjuku = true
      end
    end

    @n2000 = false
    @n4000 = false
    @n6000 = false
    @n8000 = false
    if !params[:price].blank?
      if params[:price].to_i == 2000
        @n2000 = true
      end
      if params[:price].to_i == 4000
        @n4000 = true
      end
      if params[:price].to_i == 6000
        @n6000 = true
      end
      if params[:price].to_i == 8000
        @n8000 = true
      end
    end

      if params[:city].blank? && params[:price].blank?
        @courses = Course.where(release: true).order('id ASC')
      else
        if params[:city].blank?
          @courses = Course.where(price_used: params[:price], release: true).order(id: "ASC")
        end
        if params[:price].blank?
          @courses = Course.where(city: params[:city], release: true).order(id: "ASC")
        end
          if !params[:city].blank? && !params[:price].blank?
            @courses = Course.where(city: params[:city], price_used: params[:price_dinner], release: true).order(id: "ASC")
          end
      end

  end

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
        @course = Course.new(user_id: current_user.id, title: params[:title], city: params[:city_dinner])
          if @course.save
            @point1 = Point.new(spot_id: params[:spot1_id].to_i, course_id: @course.id, number: 1)
            if @point1.save
              @timeline = Timeline.new(course_id: @course.id, city_dinner: params[:city_dinner], price_dinner: params[:price_dinner].to_i, small_dinner: params[:small_dinner])
              if @timeline.save
                redirect_to course_path(@course), notice: "コースを保存しました" #保存完了
              else
                redirect_to course_path(@course), notice: "コースを保存しました" #保存完了
              end
            else
              redirect_back(fallback_location: root_path) #ポイント1が保存できなかった
            end
          else
            redirect_back(fallback_location: root_path) #保存できなっかた
          end
      else
        @course = Course.new(user_id: current_user.id, title: params[:title], city: params[:city_dinner])
        if @course.save
            @point1 = Point.new(spot_id: params[:spot1_id].to_i, course_id: @course.id, number: 1)
            if @point1.save
              @point2 = Point.new(spot_id: params[:spot2_id].to_i, course_id: @course.id, number: 2)
              if @point2.save
                @timeline = Timeline.new(course_id: @course.id, city_dinner: params[:city_dinner], price_dinner: params[:price_dinner].to_i, small_dinner: params[:small_dinner])
                if @timeline.save
                  redirect_to course_path(@course), notice: "コースを保存しました" #保存完了
                else
                  redirect_to course_path(@course), notice: "コースを保存しました" #保存完了
                end
              else
                redirect_back(fallback_location: root_path) #ポイント2が保存できなかった
              end      
            else
              redirect_back(fallback_location: root_path) #ポイント1が保存できなかった
            end
          else
            redirect_back(fallback_location: root_path) #保存できなっかた
          end
      end
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to user_path(current_user)
  end

  def show
    @n = 0
    @i = 0
    @course = Course.find(params[:id])
    @points = Point.where(course_id: @course.id).order(number: "ASC")
    @pictures = Picture.where(course_id: @course.id).order(id: "ASC")
  end

  def edit
    @course = Course.find(params[:id])
    @points = Point.where(course_id: @course.id).order(number: "ASC")

    if !(current_user == @course.user)
      redirect_to root_path
    end
  end

  def release
    @n1 = 0
    @n2 = 0
    @n3 = 0
    @n4 = 0
    @course = Course.find(params[:id])
    @points = Point.where(course_id: @course.id)
    if !(current_user == @course.user)
      redirect_to root_path
    end
  end

  def update
    @n = 0
    @course = Course.find(params[:id])
    
      if @course.update(course_params)

        # 画像のアップロード対応
        if params[:course][:images]
          
          # 代わりに今回アップする画像に差し替え
          params[:course][:images].each do |image|
            @n = @n +1
            if @n == 1
              @picture = Picture.new(image: image, spot_id: params[:spot1], course_id: @course.id, user_id: current_user.id)
            end
            if @n == 2
              @picture = Picture.new(image: image, spot_id: params[:spot2], course_id: @course.id, user_id: current_user.id)
            end
            if @n == 3
              @picture = Picture.new(image: image, spot_id: params[:spot3], course_id: @course.id, user_id: current_user.id)
            end
            if @n == 4
              @picture = Picture.new(image: image, spot_id: params[:spot4], course_id: @course.id, user_id: current_user.id)
            end
            @picture.save
          end
          redirect_to "/users/#{current_user.id}/course"

        else
          redirect_to "/users/#{current_user.id}/course"
        end
        
      else
        redirect_back(fallback_location: root_path)
      end
  end

  private
  def course_params
    params.require(:course).permit(:title, :city, :release, :went, :price_used, :good_point, :bad_point)
  end

  def picture_params
    params.require(:course).permit(:title, :city, :release, :went, :price_used, :good_point, :bad_point, images:[])
  end

  
end
