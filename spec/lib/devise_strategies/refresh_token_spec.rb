require 'spec_helper'
require 'spree/testing_support/factories/user_factory'

RSpec.describe SolidusJwt::DeviseStrategies::RefreshToken do
  let(:request) { double(:request) }
  let(:strategy) { described_class.new(nil, :spree_user) }

  let(:params) do
    {
      refresh_token: token.token,
      grant_type: 'refresh_token'
    }
  end

  let(:headers) { {} }
  let(:user) { FactoryBot.create(:user, password: password) }
  let(:password) { 'secret' }
  let(:token) { user.auth_tokens.create! }

  before(:each) do
    allow(request).to receive(:headers).and_return(:headers)

    allow(strategy).to receive(:request).and_return(request)
    allow(strategy).to receive(:params).and_return(params)
  end

  describe '#valid?' do
    subject { strategy.valid? }

    it { is_expected.to eql true }

    context 'when refresh_token is missing' do
      before(:each) { params.delete(:refresh_token) }

      it { is_expected.to eql false }
    end

    context 'when grant_type is not refresh_token' do
      before(:each) { params[:grant_type] = 'invalid' }

      it { is_expected.to eql false }
    end
  end

  describe '#authenticate!' do
    subject { strategy.authenticate! }

    it { is_expected.to eql :success }

    context 'when token is not honorable' do
      before(:each) do
        allow_any_instance_of(SolidusJwt::Token).to receive(:honor?).and_return false
      end

      it { is_expected.to eql :failure }
    end

    context 'when user is not valid for authentication' do
      before(:each) do
        allow_any_instance_of(Spree::User).to receive(:valid_for_authentication?).and_return(false)
      end

      it { is_expected.to eql :failure }
    end

    context 'when token is used more than once' do
      before(:each) { strategy.authenticate! }

      it { is_expected.to eql :failure }
    end
  end
end
