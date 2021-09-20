class Review < ApplicationRecord
    belongs_to :rewiewable, polimorphic: true
    belongs_to :user
end
