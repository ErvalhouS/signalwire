# frozen_string_literal: true

require 'rails_helper'

describe Ticket, type: :model do
  let(:ticket) { build(:ticket) }

  it 'is valid with valid attributes' do
    expect(ticket).to be_valid
  end

  it 'is not valid without a user_id' do
    ticket.user_id = nil
    expect(ticket).not_to be_valid
  end

  it 'is not valid without a title' do
    ticket.title = nil
    expect(ticket).not_to be_valid
  end

  it 'is not valid with more than 5 tags' do
    ticket.tags = build_list(:tag, rand(6..16))
    expect(ticket).not_to be_valid
  end
end
