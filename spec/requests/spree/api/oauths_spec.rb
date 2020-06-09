# frozen_string_literal: true

require 'spec_helper'
require 'spree/testing_support/factories/user_factory'

RSpec.describe 'Token Retrieval', type: :request do
  let(:user) { FactoryBot.create(:user, password: 'password') }

  describe '/api/token' do
    context 'when username and password are provided' do
      context 'when success' do
        before do
          post '/oauth/token', params: { username: user.email, password: 'password', grant_type: 'password' }
        end

        it 'responds with status 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'responds with access_token and refresh_token' do
          json = JSON.parse(response.body)

          expect(json).to have_key('access_token')
          expect(json).to have_key('refresh_token')
        end
      end

      context 'when warden failure' do
        def send_request
          post '/oauth/token', params: { username: user.email, password: 'password', grant_type: 'password' }
        end

        it 'responds with status 401' do
          expect_any_instance_of(Spree::Api::OauthsController).to receive(:try_authenticate_user) do # rubocop:disable RSpec/AnyInstance
            throw(:warden, scope: :spree_user, message: :locked)
          end

          send_request
          expect(response).to have_http_status(:unauthorized)
        end

        it 'responds with translated Devise error message' do
          expect_any_instance_of(Spree::Api::OauthsController).to receive(:try_authenticate_user) do # rubocop:disable RSpec/AnyInstance
            throw(:warden, scope: :spree_user, message: :locked)
          end

          send_request
          json = JSON.parse(response.body)

          expect(json).to have_key('error')
          expect(json['error']).to eq('Your account is locked.')
        end
      end

      context 'when invalid password' do
        def send_request
          post '/oauth/token', params: { username: user.email, password: 'invalid', grant_type: 'password' }
        end

        it 'responds with status 401' do
          send_request
          expect(response).to have_http_status(:unauthorized)
        end

        it 'responds with invalid username or password' do
          send_request

          json = JSON.parse(response.body)

          expect(json).to have_key('error')
          expect(json['error']).to eq('invalid username or password')
        end

        context 'with error message translation' do
          before do
            allow(I18n).to receive(:t).with(:invalid_credentials, scope: 'solidus_jwt').and_return('Wrong token!')
          end

          it 'responds with translated error message' do
            send_request

            json = JSON.parse(response.body)

            expect(json).to have_key('error')
            expect(json['error']).to eq('Wrong token!')
          end
        end
      end
    end

    context 'when refresh token provided' do
      let(:refresh_token) { user.auth_tokens.create! }

      context 'when success' do
        before do
          post '/oauth/token', params: { refresh_token: refresh_token.token, grant_type: 'refresh_token' }
        end

        it 'responds with status 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'responds with access_token and refresh_token' do
          json = JSON.parse(response.body)

          expect(json).to have_key('access_token')
          expect(json).to have_key('refresh_token')
        end
      end

      context 'when failure' do
        before do
          post '/oauth/token', params: { refresh_token: 'invalid', grant_type: 'refresh_token' }
        end

        it 'response with status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
