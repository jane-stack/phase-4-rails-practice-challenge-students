class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        render json: Student.all
    end

    def update
        student = student_find
        render json: student.update(student_params)
    end

    def create
        student = Student.create(student_params)
        if student.valid?
            render json: student, status: :created
        else
            render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        student = student_find
        student.destroy
    end

    private

    def render_not_found_response
        render json: { error: "Student not found" }, status: :not_found
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def student_find
        Student.find(params[:id])
    end
end
