# frozen_string_literal: true

module Api
  module V1
    class MoviesController < ApplicationController
      def show
        @movie = Movie.find(params[:id])
        render json: Api::V1::MovieSerializer.new(@movie, params: { user:
      current_user }).serialized_json
      end
    end
  end
end
