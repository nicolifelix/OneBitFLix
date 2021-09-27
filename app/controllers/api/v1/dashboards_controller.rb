class Api::V1::DashboardsController < ApplicationController

  # Método para definir itens apresentados na tela inicial do app
  # @param
  # @return
  def index
    type_params and (return if performed?)
    result = DashboardService.new(params[:type], current_user).perform
    render json: result
  end

  private
  # Método para forçar categoria na url da index
  # @param
  # @return
    def type_params
      params[:type] ||= "category"
      type_whitelist
    end

  # Método que verifica os parâmetros para exibição do conteúdo no index.
  # @param
  # @return
    def type_whitelist
      unless ["category", "keep_watching", "highlight"].include?(params[:type])
        render json: { errors: "Unpermitted type parameter" }, status: :forbidden
      end
    end
end