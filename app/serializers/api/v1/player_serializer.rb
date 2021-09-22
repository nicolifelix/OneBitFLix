# frozen_string_literal: true

module Api
  module V1
    class PlayerSerializer
      include FastJsonapi::ObjectSerializer
      set_type :execution
      attributes :id, :start_date, :end_date, :elapsed_time
      belongs_to :movie
    end
  end
end
