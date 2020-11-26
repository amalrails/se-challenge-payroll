# frozen_string_literal: true

class TimeReportRecord < ApplicationRecord
  belongs_to :time_report
  belongs_to :job_group
  belongs_to :employee

  validates_presence_of :report_date, :hours_worked, :employee_id, :job_group_id
  validates :hours_worked, numericality: { greater_than: 0 }

  def self.as_json
    TimeReportRecord.all.each do |record|
    end
  end
end
