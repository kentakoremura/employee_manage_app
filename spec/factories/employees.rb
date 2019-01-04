FactoryBot.define do
  factory :login_employee, class: Employee do
    name { 'staff1' }
    email { 'staff1@email.com' }
    password { '123456' }
    sex { 'M' }
    birthday { Date.new(1978, 5, 1) }
    joinday { Date.new(2000, 5, 1) }

    with_default_store

    trait :with_default_store do
      after(:build) do |employee|
        employee.stores << Store.find_by(name: "原宿店")
        employee.stores << Store.find_by(name: "渋谷店")
      end
    end
  end

  factory :employee, class: Employee do
    sequence(:name) { |n| "searchStaff#{n}" }
    sequence(:email) { |n| "searchStaff#{n}@email.com" }
    password { '123456' }

    trait :male do
      sex { 'M' }
    end
    trait :female do
      sex { 'F' }
    end

    birthday { Date.new(1978, 5, 1) }
    joinday { Date.new(2000, 5, 1) }

    with_default_store

    trait :with_default_store do
      after(:build) do |employee|
        employee.stores << Store.find_by(name: "原宿店")
        employee.stores << Store.find_by(name: "渋谷店")
      end
    end
  end
end
