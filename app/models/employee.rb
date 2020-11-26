# frozen_string_literal: true

class Employee < ApplicationRecord
  has_many :time_report_records
  belongs_to :job_group
end
