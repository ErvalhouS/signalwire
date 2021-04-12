# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :ticket_tags, dependent: :destroy
  has_many :tickets, through: :ticket_tags, counter_cache: true

  validates :title, uniqueness: { case_sensitive: false }, presence: true, allow_blank: false
end
