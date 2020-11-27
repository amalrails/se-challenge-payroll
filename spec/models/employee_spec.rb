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
require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'Associations' do
    it { should belong_to(:job_group) }
    it { should have_many(:time_report_records) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:employee_id) }
  end
end
