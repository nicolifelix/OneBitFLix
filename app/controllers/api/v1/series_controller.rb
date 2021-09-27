class Api::V1::SeriesController < ApplicationController

  # Exibe player para reprodução do contéudo com seus dados
  # @param,
  # @return JSON
  # @return Serializer
  def show
    @serie = Serie.find(params[:id])
    render json: Api::V1::SerieSerializer.new(@serie, include: [:episodes], params: { user: current_user }).serialized_json
  end
end