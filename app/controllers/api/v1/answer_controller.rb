require "#{Rails.root}/app/controllers/application_controller.rb"

class Api::V1::AnswersController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @answers = Answer.all
    render json: @answers
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = current_user.answers.build(answer_params)
    @answer.user_id = current_user.id
    @answer.question_id = @question.id
    @answers = @question.answers

    respond_to do |format|
      if @answer.save
        format.html { redirect_to questions_path, notice: '回答を作成しました' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:content, :url, :title)
    end
end