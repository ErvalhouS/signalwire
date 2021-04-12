# frozen_string_literal: true

class CreateTicketTags < ActiveRecord::Migration[6.1]
  def change
    create_table :ticket_tags, id: false do |t|
      t.belongs_to :tag
      t.belongs_to :ticket
    end
  end
end
