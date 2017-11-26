class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @questions = Question.all.reverse_order
    @q = @questions.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a
  end

  def men
    @questions = Question.where(sex: "男").all.reverse_order
    @q = @questions.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a
  end

  def women
    @questions = Question.where(sex: "女").all.reverse_order
    @q = @questions.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a
  end

  def show
    @question = Question.find(params[:id])

    @comments = Comment.where(question_id: @question.id).all.reverse_order

    @comment = current_user.comments.build
  end

  def new
    # 現在のユーザーのリスティングの作成
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      redirect_to user_path(current_user)
    else
      redirect_to new_question_path
    end

  end

  def edit
     @question = Question.find(params[:id])
    if !(current_user == @question.user)
      redirect_to root_path
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to user_path(current_user)
    end
  end

  private
  def question_params
    params.require(:question).permit(:category, :content, :sex, :photo)
  end

end
