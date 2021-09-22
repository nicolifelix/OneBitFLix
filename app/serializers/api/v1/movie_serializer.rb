# frozen_string_literal: true

module Api
  module V1
    class MovieSerializer
      include FastJsonapi::ObjectSerializer
      attributes :id, :title, :description, :episode_number,
                 thumbnail_key, :featured_thumbnail_key, :video_key, :serie_id

      attribute :type do |_object|
        'serie'
      end

      attribute :category do |object|
        object.category&.name
      end

      attribute :reviews_count do |object|
        object.reviews.count
      end

      attribute :favorite do |object, params|
        params[:user].favorites.where(favoritable: object).exists? if params.present? && params.key?(:user)
      end
    end
  end
end
