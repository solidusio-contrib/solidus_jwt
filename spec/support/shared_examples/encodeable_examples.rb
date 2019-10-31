RSpec.shared_examples 'Encodeable Examples' do
  describe 'encode' do
    let(:payload) { { user_id: 1 } }

    it 'encodes a json web token' do
      expect(JWT).to receive(:encode).with(hash_including('iat', 'user_id' => 1),
                                           SolidusJwt::Config.jwt_secret, SolidusJwt::Config.jwt_algorithm).
          and_call_original

      token = subject.encode(payload: payload)
      expect(token).to be_kind_of String
    end

    context 'when expiration is passed in' do
      it 'encodes a json web token with expiration date' do
        expect(JWT).to receive(:encode).with(hash_including('iat', 'exp', 'user_id' => 1),
                                             SolidusJwt::Config.jwt_secret, SolidusJwt::Config.jwt_algorithm).
            and_call_original

        token = subject.encode(payload: payload, expires_in: 60)
        expect(token).to be_kind_of String
      end
    end
  end
end
