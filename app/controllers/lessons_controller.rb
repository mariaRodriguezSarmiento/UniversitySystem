# app/controllers/lessons_controller.rb

class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :new_student, :create_student]

  # GET /lessons
  def index
    @lessons = Lesson.all

    if params[:code].present?
      @lessons = @lessons.where(code: params[:code])
    end
  end

  # GET /lessons/1
  def show
    @students = @lesson.students
  end

  # GET /lessons/new
  def new
    @lesson = current_user.lessons.build
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  def create
    puts "**********************************************************************************************"
    puts "**********************************************************************************************"
    puts lesson_params[:start_time]
    puts lesson_params[:end_time] 
    puts lesson_params[:name]  
    puts lesson_params
    @lesson = current_user.lessons.build(lesson_params)
  
    if @lesson.save
      redirect_to @lesson, notice: 'Lesson was successfully created.'
    else
      render :new  # Renderiza nuevamente la vista de creación en caso de error
    end
  end


  # PATCH/PUT /lessons/1
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  def destroy
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /lessons/1/new_student
  def new_student
    @students = Student.all
    @lesson_student = @lesson.lesson_students.new
  end

  # POST /lessons/1/create_student
  def create_student
    @lesson_student = @lesson.lesson_students.new(student_params)

    respond_to do |format|
      if @lesson_student.save
        format.html { redirect_to lesson_path(@lesson), notice: 'Student added successfully.' }
      else
        @students = Student.all
        format.html { render :new_student, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:name, :code, :start_date, :end_date, :start_time, :end_time, :teacher_id, :lounge_id)
  end

  def student_params
    params.require(:lesson_student).permit(:student_id)
  end
end
