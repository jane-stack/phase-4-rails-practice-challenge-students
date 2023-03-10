class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    
    def index
        render json: Instructor.all
    end

    def update
        instructor = instructor_find
        render json: instructor.update(instructor_params)
    end

    def create
        instructor = Instructor.create(instructor_params)
        if instructor.valid?
            render json: instructor, status: :created
        else
            render json: { errors: instructor.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        instructor = instructor_find
        instructor.destroy
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def instructor_find
        Instructor.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Instructor not found" }, status: :not_found
    end
end
