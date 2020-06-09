# frozen_string_literal: true

RSpec.shared_examples 'Decodeable Examples' do
  describe 'decode' do
    let(:token) do
      JWT.encode(payload, SolidusJwt::Config.jwt_secret,
        SolidusJwt::Config.jwt_algorithm)
    end

    let(:payload) { { sub: 1 } }

    it 'decodes a json web token' do
      allow(JWT).to receive(:decode).and_call_original

      decoded_token = subject.decode(token)

      expect(JWT).to have_received(:decode).with(token, SolidusJwt::Config.jwt_secret,
        true, hash_including(algorithm: SolidusJwt::Config.jwt_algorithm))
      expect(decoded_token).to be_kind_of(Array)
      expect(decoded_token.first).to include(payload.as_json)
    end
  end
end
