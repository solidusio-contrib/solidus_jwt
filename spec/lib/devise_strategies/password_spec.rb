require 'spec_helper'

RSpec.describe SolidusJwt::DeviseStrategies::Password do
  let(:request) { double(:request) }
  let(:strategy) { described_class.new(nil, :spree_user) }

  let(:params) do
    {
      username: user.email,
      password: password,
      grant_type: 'password'
    }
  end

  let(:headers) { {} }
  let(:user) { FactoryBot.create(:user, email: 'user@example.com', password: password) }
  let(:password) { 'secret' }

  before(:each) do
    allow(request).to receive(:headers).and_return(:headers)

    allow(strategy).to receive(:request).and_return(request)
    allow(strategy).to receive(:params).and_return(params)
  end

  describe '#valid?' do
    subject { strategy.valid? }

    it { is_expected.to eql true }

    context 'when username is missing' do
      before(:each) { params.delete(:username) }

      it { is_expected.to eql false }
    end

    context 'when password is missing' do
      before(:each) { params.delete(:password) }

      it { is_expected.to eql false }
    end

    context 'when grant_type is not password' do
      before(:each) { params[:grant_type] = 'invalid' }

      it { is_expected.to eql false }
    end
  end

  describe '#authenticate!' do
    subject { strategy.authenticate! }

    it { is_expected.to eql :success }

    context 'when auth is invalid' do
      let(:params) do
        {
          username: user.email,
          password: 'invalid',
          grant_type: password
        }
      end

      it { is_expected.to eql :failure }
    end

    context 'when user is not valid for authentication' do
      before(:each) do
        allow_any_instance_of(Spree::User).to receive(:valid_for_authentication?).and_return(false)
      end

      it { is_expected.to eql :failure }
    end
  end
end
