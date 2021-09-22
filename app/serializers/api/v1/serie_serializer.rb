# frozen_string_literal: true

module Api
  module V1
    class SerieSerializer
      include FastJsonapi::ObjectSerializer
      attributes :id, :title, :description, thumbnail_key,
                 featured_thumbnail_key
      has_many :episodes, record_type: :movies, serializer: :movie

      attribute :type do |_object|
        'serie'
      end

      attribute :category do |object|
        object.category.name
      end

      attribute :last_watched_episode, &:last_watched_episode_id

      attribute :reviews_count do |object|
        object.reviews.count
      end

      attribute :favorite do |object, params|
        params[:user].favorites.where(favoritable: object).exists? if params.present? && params.key?(:user)
      end
    end
  end
end
