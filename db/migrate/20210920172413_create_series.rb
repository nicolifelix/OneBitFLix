# frozen_string_literal: true

class CreateSeries < ActiveRecord::Migration[5.2]
  def change
    create_table :series do |t|
      t.boolean :highlighted, default: false
      t.string :title
      t.text :description
      t.string :thumbnail_key
      t.references :category, foreign_key: true
      t.string :featured_thumbmail_key
      t.string :thumbail_cover_key

      t.timestamps
    end
  end
end
