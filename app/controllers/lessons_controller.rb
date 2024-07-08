class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :new_student, :create_student]

  # GET /lessons or /lessons.json
  def index
    @lessons = Lesson.all
  end

  # GET /lessons/1 or /lessons/1.json
  def show
    @lesson = Lesson.find(params[:id])
    @students = @lesson.students  # Obtener los estudiantes inscritos en la lección
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons or /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to lesson_url(@lesson), notice: "Lesson was successfully created." }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1 or /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to lesson_url(@lesson), notice: "Lesson was successfully updated." }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1 or /lessons/1.json
  def destroy
    @lesson.destroy!

    respond_to do |format|
      format.html { redirect_to lessons_url, notice: "Lesson was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /lessons/1/new_student
  def new_student
    @lesson = Lesson.find(params[:id])
    @students = Student.all
    @lesson_student = @lesson.lesson_students.new  # Para inicializar el objeto LessonStudent
  end
  # POST /lessons/1/create_student
  def create_student
    @lesson = Lesson.find(params[:id])
    @lesson_student = @lesson.lesson_students.new(student_params)
  
    if @lesson_student.save
      redirect_to lesson_path(@lesson), notice: 'Student added successfully.'
    else
      @students = Student.all  # Si hay errores, asegúrate de volver a cargar la lista de estudiantes
      render :new_student
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
