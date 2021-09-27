class Api::V1::MoviesController < ApplicationController
  
  # Exibe player para reprodução do contéudo com seus dados
  # @param
  # @return
  def show
    @movie = Movie.find(params[:id])
    render json: Api::V1::MovieSerializer.new(@movie, params: { user: current_user }).serialized_json
  end
end