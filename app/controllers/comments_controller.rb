class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create 	
    @comment = current_user.comments.build(comment_params)
    @comment.save
    redirect_back(fallback_location: root_path) 
  end

  def destroy	
    @comment = Comment.find_by(user_id: current_user.id, question_id: params[:question_id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end


  private
  def comment_params
    params.require(:comment).permit(:content, :sex, :question_id)
  end

end
