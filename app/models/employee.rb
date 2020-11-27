# frozen_string_literal: true

# == Schema Information
#
# Table name: employees
#
#  id           :integer          not null, primary key
#  employee_id  :string(10)
#  job_group_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_employees_on_job_group_id  (job_group_id)
#
# Foreign Keys
#
#  job_group_id  (job_group_id => job_groups.id)
#
class Employee < ApplicationRecord
  has_many :time_report_records
  belongs_to :job_group
  validates :employee_id, presence: true
end
