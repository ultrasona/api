require 'rails_helper'

RSpec.describe 'ProsController', type: :request do
  describe 'GET pros/search' do
    subject(:action) { get '/pros/search' }

    it 'works' do
      action
      expect(response.status).to eq(200)
    end
  end

  describe 'POST pros/find' do
    subject(:action) { post '/pros/find', params: { references: references } }

    let(:references) { %w[woman_haircut woman_shampoo] }

    context 'when receiving only references' do
      it 'works' do
        action
        expect(response.status).to eq(200)
      end
    end
  end
end
