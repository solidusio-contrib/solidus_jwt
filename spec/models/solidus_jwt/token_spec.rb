require 'spec_helper'

RSpec.describe SolidusJwt::Token, type: :model do
  subject { instance }
  let(:instance) { FactoryBot.create(:token) }

  it { is_expected.to be_valid }
  it { is_expected.to be_active }
  it { is_expected.to_not be_expired }

  context 'when token is nil' do
    let(:instance) { FactoryBot.build(:token, token: nil) }

    it 'should generate one automatically' do
      expect(instance.token).to be_nil
      instance.save
      expect(instance.token).to be_present
    end
  end

  describe '.honor?' do
    subject { described_class.honor?(token) }
    let(:token) { instance.token }

    it { is_expected.to eql true }

    context 'when token is inactive' do
      let(:instance) { FactoryBot.create(:token, :inactive) }
      it { is_expected.to eql false }
    end

    context 'when token is expired' do
      let(:instance) { FactoryBot.create(:token, :expired) }
      it { is_expected.to eql false }
    end
  end
end
