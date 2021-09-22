# frozen_string_literal: true

module Api
  module V1
    class DashboardsController < ApplicationController
      def index
        type_params and (return if performed?)
        result = DashboardService.new(params[:type], current_user).perform
        render json: result
      end

      private

      def type_params
        params[:type] ||= 'category'
        type_whitelist
      end

      def type_whitelist
        unless %w[category keep_watching highlight].include?(params[:type])
          render json: { errors: 'Unpermitted type parameter' }, status: :forbidden
        end
      end
    end
  end
end
