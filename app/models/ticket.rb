# frozen_string_literal: true

class Ticket < ApplicationRecord
  has_many :ticket_tags, dependent: :destroy
  has_many :tags, through: :ticket_tags

  validates :tags, length: { maximum: 5, message: "Maximum of 5 tags allowed"}
  validates :title, presence: true, allow_blank: false
  validates :user_id, presence: true, allow_blank: false
end
