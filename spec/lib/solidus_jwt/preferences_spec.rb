require 'spec_helper'

RSpec.describe SolidusJwt::Preferences do
  let(:instance) { described_class.new }

  it { is_expected.to be_kind_of(Spree::Preferences::Configuration) }

  describe '#jwt_secret' do
    subject { instance.jwt_secret }

    it { is_expected.to eql Rails.application.secret_key_base }
  end

  describe '#allow_spree_api_key' do
    subject { instance.allow_spree_api_key }

    it { is_expected.to be true }
  end

  describe '#jwt_algorithm' do
    subject { instance.jwt_algorithm }

    it { is_expected.to eql 'HS256' }
  end

  describe '#jwt_expiration' do
    subject { instance.jwt_expiration }

    it { is_expected.to be 3600 }
  end

  describe '#jwt_options' do
    subject { instance.jwt_options }

    it { is_expected.to be_kind_of Hash }
  end
end
