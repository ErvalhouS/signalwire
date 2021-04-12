# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.integer :tickets_count, default: 0
      t.string :title, null: false

      t.timestamps
    end

    add_index :tags, 'lower(title)', name: 'index_tags_on_title_unique', unique: true
  end
end
