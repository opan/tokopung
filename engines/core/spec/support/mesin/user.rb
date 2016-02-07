module Mesin
  FactoryGirl.define do 
    factory :user, class: "Mesin/User" do |f|
      password "12345678"
      password_confirmation "12345678"
      confirmed_at DateTime.now

      trait :valid_email do
        email "test@email.com"

        f.after(:create) do |u|
          create(:profile, user_id: u.id)
        end

        f.after(:build) do |u|
          u.build_profile(username: "test")
        end
      end

      trait :invalid_email do
        email "test.com"

        f.after(:create) do |u|
          create(:profile, user_id: u.id)
        end

        f.after(:build) do |u|
          u.build_profile(username: "test")
        end
      end

      trait :null_email do
        email nil

        f.after(:create) do |u|
          create(:profile, user_id: u.id)
        end

        f.after(:build) do |u|
          u.build_profile(username: "test")
        end
      end

      factory :invalid_profile_username, parent: :user do
        email "invalid@profile.com"
        after(:create) do |u|
          create(:profile, username: nil)
        end
      end
    end

    factory :super_admin, parent: :user do |f|
      email "super@admin.com"

      f.after(:create) do |u|
        create(:profile, user_id: u.id)
      end

      f.after(:build) do |u|
        u.build_profile(username: "test")
      end
    end
  end # end FactoryGirl
end
