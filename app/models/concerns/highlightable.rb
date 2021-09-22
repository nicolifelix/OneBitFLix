# frozen_string_literal: true

# método vai validar se exite uma ou mais séries ou filmes com HighLight

module Highlightable
  extend ActiveSupport::Concern
  included do
    validate :single_highlight

    def single_highlight
      any_entity = has_any_other_highlighted?(Movie)
      any_entity ||= has_any_other_highlighted?(Serie) unless
  any_entity
      if highlighted && any_entity
        errors.add(:single_highlight, "Only one highlighted entity is
   permitted")
      end
    end

    def has_any_other_highlighted?(model)
      records = model.where(highlighted: true)
      return records.where.not(id: id).any? if instance_of?(model)

      records.any?
    end
  end
end
