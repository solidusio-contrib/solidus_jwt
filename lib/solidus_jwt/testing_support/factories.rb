# frozen_string_literal: true

FactoryBot.define do
  # Define your Spree extensions Factories within this file to enable applications,
  # and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'solidus_jwt/factories'
  factory :token, class: SolidusJwt::Token do
    association :user

    trait :expired do
      created_at { 1.year.ago }
    end

    trait :inactive do
      active { false }
    end
  end
end
