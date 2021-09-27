class Api::V1::ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # Busca no BD e exibe lista de reviews de determinado item
  # @param
  # @return JSON
  # @return SERIALIZER
  def index
    @reviews = Review.where(reviewable_id: params[:id], reviewable_type: params[:type].capitalize!) 
    render json: Api::V1::ReviewSerializer.new(@reviews, include: [:user]).serialized_json
  end

  # Método para criação de novo review
  # @param
  # @return
  def create
    @review = Review.new(review_params.merge(user: current_user))
    if @review.save
      render json: @review
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    # Método para validar a criação de um novo review
    # @param
    # @return
    def review_params
      params.require(:review).permit(:reviewable_type, :reviewable_id, :rating, :description)
    end
end