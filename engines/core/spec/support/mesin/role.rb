module Mesin
  FactoryGirl.define do
    factory :role, class: "Mesin/Role" do |f|
      f.it_can_be_deleted false

      trait :super_admin do
        role_name "super_admin"
      end

      trait :admin do
        role_name "admin"
      end

      trait :customer do
        role_name "customer"
      end
    end

    factory :deleted_role, class: "Mesin/Role" do |f|
      f.it_can_be_deleted true
      role_name "super_admin"
    end

    factory :nil_role_name, class: "Mesin/Role" do |f|
      f.it_can_be_deleted true
      role_name nil
    end   
  end # end FactoryGirl
end
