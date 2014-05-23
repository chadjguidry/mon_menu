FactoryGirl.define do
  factory :food do
    user
    sequence(:name) { |n| "Test food #{n}" }
    description "A Test Food"
    category "Main"

    factory :main_dish do
    end

    factory :side_dish do
      category "Side"
    end

    factory :snack do
      category "Snack"
    end
  end
end
