class ClipsController < ApplicationController
  before_action :authenticate_user!

  def create 	
    @clip = Clip.new(user_id: current_user.id, question_id: params[:question_id], sex: current_user.sex)
    @clip.save
    redirect_back(fallback_location: root_path) 
  end

  def destroy	
    @clip = Clip.find_by(user_id: current_user.id, question_id: params[:question_id])
    @clip.destroy
    redirect_back(fallback_location: root_path)
  end

end
