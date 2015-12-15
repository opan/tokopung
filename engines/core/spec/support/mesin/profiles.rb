module Mesin
  FactoryGirl.define do
    factory :profile, :class => 'Mesin/Profile' do
      username "test"

      trait :invalid_username do
        username [*0..101].join
      end

      trait :invalid_fullname do
        fullname [*0..260].join
      end
    end

  end
end
