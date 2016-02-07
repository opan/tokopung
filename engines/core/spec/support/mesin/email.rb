module Mesin
  FactoryGirl.define do 
    factory :email, class: "Mesin/Email" do |f|
      user
    end

    factory :email1, parent: :email do |f|
      email "satu@email.com"
    end

    factory :email2, parent: :email do |f|
      email "dua@email.com"
    end
  end # end FactoryGirl
end
