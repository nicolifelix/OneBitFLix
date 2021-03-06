#PLAYERS

class Api::V1::ExecutionsController < ApplicationController
  before_action :set_execution, only: :update
  skip_before_action :verify_authenticity_token

  # Método que localiza e reproduz player ativo ou cria caso não encontre (find_or_create_by).
  # @param
  # @return
  def show
    movie = Movie.find(params[:id])
    @player = movie.players.find_or_create_by(end_date: nil, user: current_user)
    render json: Api::V1::PlayerSerializer.new(@player, include: [:movie, :'movie.serie']).serialized_json
  end

  # Método para gravar atualizações do vídeo em reprodução (tempo assistido) ou se finalizado.
  # @param
  # @return
  def update
    if @player.update(player_params.merge(user: current_user))
      if @player.movie.serie
        @player.movie.serie.update(last_watched_episode: @player.movie)
      end
      render json: Api::V1::PlayerSerializer.new(@player, include: [:movie]).serialized_json
    else
      render json: { errors: @player.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  # Método para definir parâmetros do update:  tempo assistido, ou se finalizado.
  # @param
  # @return
    def player_params
      params.require(:execution).permit(:elapsed_time, :end_date)
    end

    # Método trás o id do filme, e salva as atualizações nesse ID.
    # @param
    # @return
    def set_execution
      @player = Player.find_by(movie_id: params[:id])
    end
end