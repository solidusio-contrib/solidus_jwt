require 'spec_helper'

RSpec.describe SolidusJwt do
  include_examples 'Decodeable Examples'
  include_examples 'Encodeable Examples'
end
