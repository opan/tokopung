module Mesin
  FactoryGirl.define do
    factory :role, class: "Mesin/Role" do |f|
      f.it_can_be_deleted false

      trait :superadmin do
        role_name "superadmin"
      end

      trait :admin do
        it_can_be_deleted true
        role_name "admin"
      end

      trait :customer do
        it_can_be_deleted true
        role_name "customer"
      end
    end

    factory :nil_role_name, class: "Mesin/Role" do |f|
      f.it_can_be_deleted true
      role_name nil
    end

    factory :invalid_role_name, class: "Mesin/Role" do |f|
      f.it_can_be_deleted true
      role_name "1aisudh9()"
    end   
  end # end FactoryGirl
end
