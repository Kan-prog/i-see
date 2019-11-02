require "#{Rails.root}/app/controllers/application_controller.rb"

class Api::V1::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
    render json: @questions
  end

  def show
    @question = Question.find_by(id: params[:id])
    @answers = @question.answers.all
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def create
    @question = current_user.questions.build(question_params)

    respond_to do |format|
      if @question.save
        format.json { render :show, status: :created, location: @question }
      else
        format.json { render json: @question.errors, status: :unprocessable_entity }
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