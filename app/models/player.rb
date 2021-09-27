class Player < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  before_create :set_start_date

  #Método indica que o filme/episódio foi iniciado.
  # @param
  # @return
  private
    def set_start_date
      self.start_date ||= Time.zone.now
    end
end