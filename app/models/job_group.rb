# frozen_string_literal: true

# == Schema Information
#
# Table name: job_groups
#
#  id         :integer          not null, primary key
#  group_name :string(10)
#  rate       :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_job_groups_on_group_name  (group_name) UNIQUE
#
class JobGroup < ApplicationRecord
  has_many :employees
  has_many :time_report_records

  validates :group_name, presence: true, uniqueness: true
  validates :rate, presence: true
  validates :rate, numericality: { greater_than: 0 }
end
