class Movie < ApplicationRecord
  include Highlightable
  include PgSearch::Model
  multisearchable against: [:title], if: lambda{ |record| record.serie.nil? } # if: lambda -> episódio de uma série não dev ser apresentado solto..
  belongs_to :serie, optional: true #relacionado com série
  belongs_to :category, optional: true #relacionado com categoria
  has_many :reviews, as: :reviewable
  has_many :players, dependent: :destroy
  has_one :watched_serie, class_name: "Serie", foreign_key: "last_watched_episode_id", dependent: :nullify
  validates :title, presence: true
  validates :description, presence: true
  validates :thumbnail_key, presence: true
  validates :video_key, presence: true
  validates :episode_number, presence: true, uniqueness: { scope: :serie_id }, if: ->{ serie.present? }
  validates :category, presence: true, if: ->{ serie.nil? }
  validate :highlight_episode

  #Método valida se o highlight está ativo em algum epsódio de série.
  # @param
  # @return
  private
    def highlight_episode
      if self.serie.present? && self.highlighted == true
        errors.add(:highlight_episode, "It's not possible to highlight an serie episode")
      end
    end
end