class LovesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course

  def create
    @love = Love.create(user_id: current_user.id, course_id: params[:course_id])   
  end

  def destroy
    @love = Love.find_by(user_id: current_user.id, course_id: params[:course_id])
    @love.destroy   
  end

  def create0
  	@course_id = params[:course_id]
  	if Love.find_by(user_id: current_user.id, course_id: @course_id)
	    redirect_to "/seeks/course/#{@course_id}"
	else
		@love = Love.create(user_id: current_user.id, course_id: params[:course_id])  
		redirect_to "/seeks/course/#{@course_id}"
	end
  end


  private
  def set_course
  @course = Course.find(params[:course_id])
  end

end
