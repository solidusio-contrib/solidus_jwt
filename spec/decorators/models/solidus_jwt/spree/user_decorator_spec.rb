require 'spec_helper'

RSpec.describe Spree::User, type: :model do
  describe '.for_jwt' do
    subject { described_class.for_jwt(payload) }

    before do
      allow(described_class).to receive(:find_by).with(hash_including(id: String))
    end

    context 'when payload is a string' do
      let(:payload) { 'user-id' }

      it 'must call deprecator' do
        allow(SolidusJwt.deprecator).to receive(:deprecation_warning)

        described_class.for_jwt(payload)

        expect(SolidusJwt.deprecator).to have_received(:deprecation_warning)
      end

      it 'must call .find_by with { id: String } signature' do
        described_class.for_jwt(payload)

        expect(described_class).to have_received(:find_by).with(hash_including(id: payload))
      end
    end

    context 'when payload is a Hash' do
      let(:payload) do
        {
          sub: 'user-id',
          email: 'abc@example.com',
          iss: 'solidus'
        }
      end

      it 'must NOT call deprecator' do
        allow(SolidusJwt.deprecator).to receive(:deprecation_warning)

        described_class.for_jwt(payload)

        expect(SolidusJwt.deprecator).to_not have_received(:deprecation_warning)
      end

      it 'must call .find_by with { id: String } signature' do
        described_class.for_jwt(payload)

        expect(described_class).to have_received(:find_by).with(hash_including(id: payload[:sub]))
      end
    end
  end
end
