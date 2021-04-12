# frozen_string_literal: true

require 'rails_helper'

describe Tag, type: :model do
  let(:tag) { build(:tag) }

  it 'is valid with valid attributes' do
    expect(tag).to be_valid
  end

  it 'is not valid without a title' do
    tag.title = nil
    expect(tag).not_to be_valid
  end
end
