# frozen_string_literal: true

FactoryBot.define do
  factory :ticket, class: 'Ticket' do
    user_id { Faker::Number.digit }
    title { Faker::Lorem.word }
    tags { build_list(:tag, rand(0..5)) }
  end
end

FactoryBot.define do
  factory :tag, class: 'Tag' do
    title { Faker::Lorem.word }
  end
end
