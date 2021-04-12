# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :user_id, null: false
      t.string :title, null: false

      t.timestamps
    end
  end
end
