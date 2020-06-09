# frozen_string_literal: true

RSpec.shared_examples 'Encodeable Examples' do
  describe 'encode' do
    let(:payload) { { user_id: 1 } }

    it 'encodes a json web token' do
      allow(JWT).to receive(:encode).and_call_original

      token = subject.encode(payload: payload)

      expect(JWT).to have_received(:encode).with(hash_including('iat', 'user_id' => 1),
        SolidusJwt::Config.jwt_secret, SolidusJwt::Config.jwt_algorithm)
      expect(token).to be_kind_of String
    end

    context 'when expiration is passed in' do
      it 'encodes a json web token with expiration date' do
        allow(JWT).to receive(:encode).and_call_original

        token = subject.encode(payload: payload, expires_in: 60)

        expect(JWT).to have_received(:encode).with(hash_including('iat', 'exp', 'user_id' => 1),
          SolidusJwt::Config.jwt_secret, SolidusJwt::Config.jwt_algorithm)
        expect(token).to be_kind_of String
      end
    end
  end
end
