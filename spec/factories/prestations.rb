FactoryBot.define do
  factory :prestation do
    duration { 30 }

    trait :woman_haircut do
      reference { 'woman_haircut' }
    end

    trait :woman_color do
      reference { 'woman_color' }
    end

    trait :woman_shampoo do
      reference { 'woman_shampoo' }
    end

    trait :man_haircut do
      reference { 'man_haircut' }
    end
  end
end
