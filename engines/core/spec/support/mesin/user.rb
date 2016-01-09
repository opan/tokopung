module Mesin
  FactoryGirl.define do 
    factory :user, class: "Mesin/User" do |f|
      password "12345678"
      password_confirmation "12345678"
      confirmed_at DateTime.now

      trait :valid_email do 
        email "test@email.com"
      end

      trait :invalid_email do
        email "test.com"
      end

      trait :null_email do
        email nil
      end
    end

    factory :super_admin, parent: :user do |f|
      email "super@admin.com"
    end
  end # end FactoryGirl
end
