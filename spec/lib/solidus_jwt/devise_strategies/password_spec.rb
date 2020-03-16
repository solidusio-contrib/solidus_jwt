require 'spec_helper'
require 'spree/testing_support/factories/user_factory'

RSpec.describe SolidusJwt::DeviseStrategies::Password do
  let(:request) { instance_double('ActionController::Request') }
  let(:strategy) { described_class.new(nil, :spree_user) }

  let(:params) do
    {
      username: user.email,
      password: password,
      grant_type: 'password'
    }
  end

  let(:headers) { {} }
  let(:user) { FactoryBot.create(:user, password: password) }
  let(:password) { 'secret' }

  before do
    allow(request).to receive(:headers).and_return(:headers)

    allow(strategy).to receive(:request).and_return(request)
    allow(strategy).to receive(:params).and_return(params)
  end

  describe '#valid?' do
    subject { strategy.valid? }

    it { is_expected.to be true }

    context 'when username is missing' do
      before { params.delete(:username) }

      it { is_expected.to be false }
    end

    context 'when password is missing' do
      before { params.delete(:password) }

      it { is_expected.to be false }
    end

    context 'when grant_type is not password' do
      before { params[:grant_type] = 'invalid' }

      it { is_expected.to be false }
    end
  end

  describe '#authenticate!' do
    subject { strategy.authenticate! }

    it { is_expected.to be :success }

    context 'when auth is invalid' do
      let(:params) do
        {
          username: user.email,
          password: 'invalid',
          grant_type: password
        }
      end

      it { is_expected.to be :failure }
    end

    context 'when user is not valid for authentication' do
      before do
        allow_any_instance_of(Spree::User).to receive(:valid_for_authentication?).and_return(false) # rubocop:disable RSpec/AnyInstance
      end

      it { is_expected.to be :failure }
    end
  end
end
