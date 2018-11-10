require 'spec_helper'

RSpec.describe SolidusJwt::Config do
  it { is_expected.to be_kind_of SolidusJwt::Preferences }
end
