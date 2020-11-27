FactoryBot.define do
  factory :job_group do
    sequence(:group_name) { |n| Faker::Lorem.word + n.to_s }
  end

  factory :employee do
    sequence(:employee_id) { |n| "{n}" }
  end
  factory :time_report_record
  factory :time_report
end
