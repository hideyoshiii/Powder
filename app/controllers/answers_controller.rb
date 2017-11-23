class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create1
  	
    @answer = Answer.new(user_id: current_user.id, question_id: params[:question_id], kind: 1, sex: current_user.sex)
    @answer.save
    redirect_back(fallback_location: root_path) 
  end

  def create2
    
    @answer = Answer.new(user_id: current_user.id, question_id: params[:question_id], kind: 2, sex: current_user.sex)
    @answer.save
    redirect_back(fallback_location: root_path) 
  end

  def update1
    @answer = Answer.find_by(user_id: current_user.id, question_id: params[:question_id], kind: 2)
    @answer.kind = 1
    @answer.save
    redirect_back(fallback_location: root_path) 
  end

   def update2
    @answer = Answer.find_by(user_id: current_user.id, question_id: params[:question_id], kind: 1)
    @answer.kind = 2
    @answer.save
    redirect_back(fallback_location: root_path) 
  end

  def destroy1
  	
    @answer = Answer.find_by(user_id: current_user.id, question_id: params[:question_id], kind: 1)
    @answer.destroy
    redirect_back(fallback_location: root_path)
  end

  def destroy2
    
    @answer = Answer.find_by(user_id: current_user.id, question_id: params[:question_id], kind: 2)
    @answer.destroy
    redirect_back(fallback_location: root_path)
  end

end
