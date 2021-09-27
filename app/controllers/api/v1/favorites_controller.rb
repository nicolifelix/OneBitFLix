class Api::V1::FavoritesController < ApplicationController
  before_action :set_favorite, only: :destroy
  skip_before_action :verify_authenticity_token

  # Lista de itens favoritados, serializando todos os favoritos
  # @param
  # @return JSON
  # @return SERIALIZER
  def index
    @favorites = current_user.favorites
    render json: Api::V1::WatchableSerializer.new(@favorites.map(&:favoritable)).serialized_json
  end

  # Método para favoritar item
  # @param
  # @return JSON
  def create
    @favorite = Favorite.new(favorite_params.merge(user: current_user))
    if @favorite.save
      head :ok
    else
      render json: { errors: @favorite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Método para desfavoritar item
  # @param
  # @return
  def destroy
    @favorite.destroy
    head :ok
  end

  
  private
    # CALLBACK, roda antes do destroy, quando o usuário quiser defavoritar o item
    # Verifica usuário e tipo do item
    # @param
    # @return
    def set_favorite
      @favorite = Favorite.find_by(favoritable_type: params[:type].capitalize!, favoritable_id: params[:id], user: current_user)
    end

    #CALLBACK, retorna informações do item
    #Verifica usuário e tipo do item
    # @param
    # @return hash
    def favorite_params
      params.require(:favorite).permit(:favoritable_type, :favoritable_id)
    end
end