class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
  end

  def men
    @questions = Question.where(sex: "男").all.reverse_order
    @q = Question.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a
  end

  def women
    @questions = Question.where(sex: "女").all.reverse_order
    @q = Question.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a
  end

  def show
  end

  def new
    # 現在のユーザーのリスティングの作成
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      redirect_to user_path(current_user), notice: "リスティングを作成・保存をしました"
    else
      redirect_to new_question_path, notice: "リスティングを作成・保存出来ませんでした"
    end

  end

  def edit
     @question = Question.find(params[:id])
    if !(current_user == @question.user)
      redirect_to root_path, notice: "他人の編集ページにはアクセスできません"
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to user_path(current_user), notice: "更新しました"
    end
  end

  private
  def question_params
    params.require(:question).permit(:category, :content, :sex, :photo)
  end

end
