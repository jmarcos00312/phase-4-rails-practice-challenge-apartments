class ApartmentsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid


    def index
        render json: Apartment.all, status: :ok
    end

    def show
        apartment = find_apartment
        render json: apartment, status: :ok
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def update
        apartment = find_apartment
        apartment.update!(apartment_params)
        render json: apartment, status: :ok
    end

    def destroy
        apartment = find_apartment
        apartment.destroy
        render json: {messages: "Apartment room ##{apartment.number} has been deleted"}
    end



    private
    def find_apartment
        Apartment.find(params[:id])
    end

    def apartment_params
        params.permit(:number)
    end

    def render_not_found
        render json: {error: 'Apartment Not Found'}, status: :not_found
    end

    def render_invalid(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :invalid
    end
end
