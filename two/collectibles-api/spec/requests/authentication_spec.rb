require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /auth/login' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_credentials) do
      {
        username: user.username,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        username: Faker::Internet.username,
        password: Faker::Internet.password
      }.to_json
    end

    context 'When request is valid' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'should return an authentication token' do
        expect(JSON.parse(response.body)['auth_token']).not_to be_nil
      end
    end

    context 'When request is invalid' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'should return a failure message' do
        expect(JSON.parse(response.body)['message']).to match(/Invalid credentials/)
      end
    end
  end
end