require 'rails_helper'

RSpec.describe 'ProsController', type: :request do
  describe 'GET pros/search' do
    subject(:action) { get '/pros/search' }

    it 'works' do
      action
      expect(response.status).to eq(200)
    end
  end
end
