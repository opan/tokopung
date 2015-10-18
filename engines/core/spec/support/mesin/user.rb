module Mesin
  FactoryGirl.define do 
    factory :role_users, class: "Mesin/Role" do |f|
      role_name "test" 
    end
  end # end FactoryGirl
end
