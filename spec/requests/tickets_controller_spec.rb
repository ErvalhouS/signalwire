# frozen_string_literal: true

require 'rails_helper'

describe 'create a ticket route', type: :request do
  let!(:ticket) { build(:ticket) }

  before do
    post '/api/v1/tickets',
         params: { user_id: ticket.user_id, title: ticket.title, tags: ticket.tags.map(&:title) }
  end

  shared_examples 'does\'t send a webhook request' do
    it 'does\'t send a webhook request' do
      expect(TagCounterWorker).not_to receive(:perform_async)
      post '/api/v1/tickets',
           params: { user_id: ticket.user_id, title: ticket.title, tags: ticket.tags.map(&:title) }
    end
  end

  context 'with valid params' do
    it 'returns the ticket\'s user_id' do
      expect(JSON.parse(response.body)['user_id']).to eq(ticket.user_id)
    end

    it 'returns the ticket\'s title' do
      expect(JSON.parse(response.body)['title']).to eq(ticket.title)
    end

    it 'returns the ticket\'s tags' do
      expect(JSON.parse(response.body)['tags'].map{ |tag| tag['title'] }.compact).to eq(ticket.tags.map(&:title).uniq.compact)
    end

    it 'returns a created status' do
      expect(response).to have_http_status(:created)
    end

    it 'sends a webhook request' do
      expect(TagCounterWorker).to receive(:perform_async)
      post '/api/v1/tickets',
           params: { user_id: ticket.user_id, title: ticket.title, tags: ticket.tags.map(&:title) }
    end
  end

  context 'without an user_id' do
    let(:ticket) { build(:ticket, user_id: nil) }

    it 'returns a unprocessable_entity status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'gives details about the error' do
      expect(JSON.parse(response.body)["user_id"]).to eq(["can't be blank"])
    end

    include_examples 'does\'t send a webhook request'
  end

  context 'without an title' do
    let(:ticket) { build(:ticket, title: nil) }

    it 'returns a unprocessable_entity status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'gives details about the error' do
      expect(JSON.parse(response.body)["title"]).to eq(["can't be blank"])
    end

    include_examples 'does\'t send a webhook request'
  end

  context 'with more than 5 tags' do
    let(:ticket) { build(:ticket, tags: build_list(:tag, rand(6..20))) }

    it 'returns a unprocessable_entity status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'gives details about the error' do
      expect(JSON.parse(response.body)["tags"]).to eq(["Maximum of 5 tags allowed"])
    end

    include_examples 'does\'t send a webhook request'
  end
end
