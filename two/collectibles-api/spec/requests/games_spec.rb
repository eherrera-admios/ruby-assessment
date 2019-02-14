require 'rails_helper'

RSpec.describe 'Games API', type: :request do
  let(:user) { create(:user) }
  let!(:games) { create_list(:game, 10, user_id: user.id) }
  let(:game_id) { games.first.id }
  let(:headers) { valid_headers }

  describe 'GET /games' do
    before { get '/games', params: {}, headers: headers }

    it 'should return a list of games' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body).size).to eq 10
    end

    it 'should return status code 200' do
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /games/:id' do
    before { get "/games/#{game_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'should return the game' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['id']).to eq game_id
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'when the record does not exist' do
      let(:game_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Game/)
      end
    end
  end

  describe 'POST /games' do
    let(:valid_attributes) do
      {
          title: 'Dota2',
          pg: 'T',
          rating: 4
      }.to_json
    end

    context 'when the request is valid' do
      before { post '/games', params: valid_attributes, headers: headers }

      it 'should create a game' do
        expect(JSON.parse(response.body)['title']).to eq 'Dota2'
      end

      it 'should return status code 201' do
        expect(response).to have_http_status 201
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: "Zelda's Adventure" }.to_json }
      before { post '/games', params: invalid_attributes, headers: headers }

      it 'should return status code 422' do
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'PUT /games/:id' do
    let(:valid_attributes) do
      {
          pg: 'A'
      }.to_json
    end

    context 'when the record exists' do
      before { put "/games/#{game_id}", params: valid_attributes, headers: headers }

      it 'should update the record' do
        expect(response.body).to be_empty
      end

      it 'should return status code 204' do
        expect(response).to have_http_status 204
      end
    end
  end

  describe 'DELETE /games/:id' do
    before { delete "/games/#{game_id}", params: {}, headers: headers }

    it 'should return status code 204' do
      expect(response).to have_http_status 204
    end
  end
end