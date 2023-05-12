# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'SolidusJwt Authentication', type: :request do
  let(:params) do
    { token: token }
  end

  let(:token) { nil }
  let(:user) { FactoryBot.create(:user, spree_api_key: 'secret') }

  it 'fails if user visits api without authenticating' do
    get spree.api_user_path(user.id)
    expect(response.status).to be(401)
  end

  context 'when jwt fails to decode' do
    let(:token) { 'abc.123.efg' }

    it 'renders invalid_api_key' do
      get spree.api_user_path(user.id), params: params

      aggregate_failures do
        expect(response.status).to be(401)
        expect(response.body).to include('Invalid API key')
      end
    end
  end

  context 'when spree api key is allowed' do
    context 'when spree api key is present' do
      let(:token) { user.spree_api_key }

      it 'passes authentication' do
        get spree.api_user_path(user.id), params: params
        expect(response.status).to be(200)
      end
    end

    context 'when json web token is used' do
      let(:token) { user.generate_jwt }

      it 'passes authentication' do
        get spree.api_user_path(user.id), params: params
        expect(response.status).to be(200)
      end
    end
  end

  context 'when spree api key is not allowed' do
    before do
      SolidusJwt::Config.allow_spree_api_key = false
    end

    after do
      SolidusJwt::Config.allow_spree_api_key = true
    end

    context 'when spree api key is present' do
      let(:token) { user.spree_api_key }

      it 'fails authentication' do
        get spree.api_user_path(user.id), params: params
        expect(response.status).to be(401)
      end
    end

    context 'when json web token is used' do
      let(:token) { user.generate_jwt }

      it 'passes authentication' do
        get spree.api_user_path(user.id), params: params
        expect(response.status).to be(200)
      end
    end
  end
end
