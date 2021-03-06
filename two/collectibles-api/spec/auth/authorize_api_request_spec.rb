require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create(:user) }
  let(:header) { {'Authorization' => token_generator(user.id)} }

  subject(:invalid_request_obj) { described_class.new({}) }
  subject(:request_obj) { described_class.new(header) }

  describe '#call' do
    context 'when valid request' do
      it 'should return user object' do
        result = request_obj.call
        expect(result[:user]).to eq user
      end
    end

    context 'when invalid request' do
      context 'when missing token' do
        it 'should raise a MissingToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken)
        end
      end

      context 'when invalid token' do
        subject(:invalid_request_obj) do
          described_class.new('Authorization' => token_generator(5))
        end

        it 'should raise an InvalidToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken)
        end
      end

      context 'when token is expired' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id) } }

        subject(:request_obj) { described_class.new(header) }

        it 'should raise ExpiredSignature error' do
          expect { request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken)
        end
      end

      context 'when token is fake' do
        let(:header) { { 'Authorization' => 'fake!' } }

        subject(:invalid_request_obj) { described_class.new(header) }

        it 'should handle JWT::DecodeError' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken)
        end
      end
    end
  end
end