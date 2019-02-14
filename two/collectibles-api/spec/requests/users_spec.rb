require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    password = Faker::Internet.password
    {
      name: user['name'],
      username: user['username'],
      password: password,
      password_confirmation: password
    }.to_json
  end

  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes, headers: headers }

      it 'should create a new user' do
        expect(response).to have_http_status(201)
      end

      it 'should return a success message' do
        expect(JSON.parse(response.body)['message']).to match(/Account created successfully/)
      end

      it 'should return an authentication token' do
        expect(JSON.parse(response.body)['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'should not create a new user' do
        expect(response).to have_http_status(422)
      end
    end
  end
end