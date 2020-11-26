FactoryBot.define do
  factory :job_group do
    sequence(:group_name) { |n| Faker::Lorem.word + n.to_s }
  end
end
