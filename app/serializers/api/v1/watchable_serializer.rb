# frozen_string_literal: true

module Api
  module V1
    class WatchableSerializer
      include FastJsonapi::ObjectSerializer
      attributes :id, :title, :description, :thumbnail_key, :featured_thumbnail_key

      attribute :type, &:model_name

      attribute :favorite do |object, params|
        params[:user].favorites.where(favoritable: object).exists? if params.present? && params.key?(:user)
      end

      attribute :video_key do |object|
        object.video_key if object[:video_key].present?
      end

      attribute :featured_thumbnail_key do |object|
        object.featured_thumbnail_key if object[:featured_thumbnail_key].present?
      end
    end
  end
end
